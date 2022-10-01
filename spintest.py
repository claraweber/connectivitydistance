import pandas as pd
import numpy as np
from brainspace.datasets import load_gradient, load_marker, load_conte69, load_parcellation
from brainspace.utils.parcellation import reduce_by_labels, map_to_labels
from brainspace.null_models import SpinPermutations
from brainspace.plotting import plot_hemispheres
from matplotlib import pyplot as plt
from scipy.stats import spearmanr

surf_lh, surf_rh = load_conte69()
sphere_lh, sphere_rh = load_conte69(as_sphere=True)

# Load the data
thickness_lh, thickness_rh = load_marker('thickness')
thickness = np.concatenate([thickness_lh, thickness_rh])

#------
# import gene data
genes = pd.read_csv('expression_filtered_correlation0.5.csv')

# import cd data
condist = np.asarray(pd.read_csv('/parcellated_cd_schaefer200.csv'))[:,1:]
condist_asd = np.asarray(pd.read_csv('/parcellated_cd_schaefer200_asd.csv'))[:,1:]
condist_tdc = np.asarray(pd.read_csv('/parcellated_cd_schaefer200_tdc.csv'))[:,1:]
t_df = np.asarray(pd.read_csv('/condist_t_lm.csv'))

print('Imported in shape: condist:', condist.shape, 'asd', condist_asd.shape, 'tdc', condist_tdc.shape)

def s200_to_fslr(in_s200):
	labeling = load_parcellation('schaefer', scale=200, join=True)
	mask = labeling == 0
	out_fslr = map_to_labels(in_s200, labeling)
	out_fslr[mask] = np.nan
	return(out_fslr)

condist_map = s200_to_fslr(condist)
condist_asd_map = s200_to_fslr(condist_asd)
condist_tdc_map = s200_to_fslr(condist_tdc)
t_map = s200_to_fslr(t_df)

print('Coverted to shapes: condist:', condist_map.shape, 'asd', condist_asd_map.shape, 'tdc', condist_tdc_map.shape)

def getgene(name):
	g = np.asarray(genes[name].fillna(0))
	g = np.insert(g, 0, 0)
	print(g.shape)
	g_map= s200_to_fslr(g)
	g_lh = g_map[:32492,]
	g_rh = g_map[32492:,]
	g_rotated = np.hstack(sp.randomize(g_lh, g_rh))
	return(g_map, g_rotated)

#------

# Template functional gradient
#embedding = load_gradient('fc', idx=0, join=True)
embedding = np.mean(condist_tdc_map, axis =1)
print('embedding', embedding.shape)
ename = 'cd-tdc'

# Let's create some rotations
n_rand = 5000

sp = SpinPermutations(n_rep=n_rand, random_state=0)
sp.fit(sphere_lh, points_rh=sphere_rh)


def spintest(name, embedding=embedding):
	fig = plt.figure(figsize=(6, 3.5))

	map_in = getgene(name)[0]
	map_rotated =getgene(name)[1]

	feats = {name: map_in}
	rotated = {name: map_rotated}

	r_spin = np.empty(n_rand)
	mask = ~np.isnan(thickness)
	for k, (fn, feat) in enumerate(feats.items()):
	    r_obs, pv_obs = spearmanr(feat[mask], embedding[mask])

	    # Compute perm pval
	    for i, perm in enumerate(rotated[fn]):
	        mask_rot = mask & ~np.isnan(perm)  # Remove midline
	        r_spin[i] = spearmanr(perm[mask_rot], embedding[mask_rot])[0]
	    pv_spin = np.mean(np.abs(r_spin) >= np.abs(r_obs))

	    # Plot null dist
	    plt.hist(r_spin, bins=25, density=True, alpha=0.5, color=(.8, .8, .8))
	    plt.axvline(r_obs, lw=2, ls='--', color='k')
	    plt.xlabel(f'Correlation with {fn}')
	    if k == 0:
	        plt.ylabel('Density')

	    print(f'{fn.capitalize()}:\n Obs : p {pv_obs:.5e} r {r_obs:.5e}\n Spin: {pv_spin:.5e}\n')

	fig.tight_layout()
	plt.savefig(f'/spintest{n_rand}_{name}_{ename}.svg')
	return(pv_obs, r_obs, pv_spin)

genelist = ['ADAM23','CADPS2','GABRA2','GABRA5','GABRB1','GABRG1','MET','NPY1R','RAPGEF4', 
	'NEFH', 'CRYM', 'CALB1', 'SYT2', 'SCN4B', 'VAMP1']

data = []

for i, n in enumerate(genelist):
	try:
		print(n)
		data_1g = spintest(n)
		data.append(data_1g)
	except:
		pass

df = pd.DataFrame(data, columns = ['P_observed', 'R_observed', 'P_spin'])
df.to_csv(f'results_spintest{n_rand}__{ename}genes.csv')
