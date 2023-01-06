import numpy as np
import pandas as pd
import bct as bct
import nibabel
from brainspace.mesh.mesh_io import read_surface
from brainspace.mesh.mesh_creation import build_polydata
from brainspace.datasets import load_conte69, load_parcellation
from brainspace.utils.parcellation import map_to_labels, reduce_by_labels
from mica_clusteringcoeff_pythonadaption_v3 import RandomizeClust_Pathlength, gretnapy_gen_random_network1_weight

def do_graphtheory_things_pathlength(case, v=False):
	"""
	Input case = string case name

	"""
	# load surface 
	s10 = 'conte_10k_fixed.vtp'
	pial_left, pial_right  = load_conte69()
	s10 = read_surface(s10)
	mask = s10.PointData['mask'] == 1
	half = 10242
	cells = s10.GetCells2D()
	s10_lh_points = s10.Points[:half]
	s10_lh_cells = cells[(cells<half).any(1)]
	s10_rh_points = s10.Points[half:]
	s10_rh_cells = cells[(cells>=half).any(1)]
	s10_lh = build_polydata(s10_lh_points, cells=s10_lh_cells)
	s10_rh = build_polydata(s10_rh_points-half, cells=s10_rh_cells-half)
	for array_name in s10.PointData.keys():
	    x = s10.get_array(array_name)
	    s10_lh.append_array(x[:half], name=array_name, at='p')
	    s10_rh.append_array(x[half:], name=array_name, at='p')

	# load case 
	mat = np.load(f'{case}_fc_10k.npz')['Z']

	# Parcellate to Schaefer 200
	parc = s10.PointData['schaefer200_yeo7']
	mask = s10.PointData['mask'] == 1
	parcellated = reduce_by_labels(mat, parc, red_op='mean', axis=1, dtype = np.float32)
	parcel = reduce_by_labels(parcellated.T, parc, red_op='mean', axis=1, dtype = np.float32)

	# leave negative out
	parcel[parcel<0]=0
	parcel[np.isnan(parcel)]=0
	if v:
		print('case loaded and parcellated', parcel.shape)
	# parcel = unthesholded data we wanna use, p = thresholded version
	
	p = bct.threshold_proportional(parcel, 0.1)

	# find number of zeros in p
	pzrs = np.empty(shape=(p.shape[1], p.shape[1]))*0
	pzrs[p==0] =1
	nzrs = pzrs.sum(axis=1).sum(axis=0)

	# is graph fully connected?
	check = ((len(p)*len(p))-nzrs)/(len(p)*len(p))
	if check >=0.975:
	    fullyconnected = 'jup'
	else:
	    fullyconnected = 'no'
	if v:
		print('Fully connected?', fullyconnected, check)

	rIt = 16
	if v:
		print('thresholding done. Looks good?', p)
	Cw_group_lambda, Cw_group_efficiency, Cw_group_ecc, Cw_group_radius, Cw_group_diameter = bct.charpath(p)
	Cw_group = np.empty (shape=(4,1))
	Cw_group[0] = Cw_group_lambda
	Cw_group[1] = Cw_group_efficiency
	Cw_group[2] = Cw_group_radius
	Cw_group[3] = Cw_group_diameter
	Cw_rand_group = np.empty(shape=(rIt, 4))*0

	for ii in range(rIt):
		Cw_rand_group_lambda, Cw_rand_group_efficiency, Cw_rand_group_ecc, Cw_rand_group_radius, Cw_rand_group_diameter = RandomizeClust_Pathlength(parcel, 0.1)
		Cw_rand_group[ii][0] = Cw_rand_group_lambda
		Cw_rand_group[ii][1] = Cw_rand_group_efficiency
		Cw_rand_group[ii][2] = Cw_rand_group_radius
		Cw_rand_group[ii][3] = Cw_rand_group_diameter	

	# normalize randoms
	randomGs = np.mean(Cw_rand_group, axis = 0)
	randomGs[np.isnan(randomGs)] = 0

	#normalize clustering coefficient
	Cw_group_norm = Cw_group/randomGs

	# characteristic clustering coefficient
	#cCw_group = Cw_group_avg/np.mean(cGrand, axis=0)

	return(case, Cw_group_norm[0], Cw_group_norm[1], Cw_group_norm[2], Cw_group_norm[3])


#------
# load case names
origdata = pd.read_csv('demodata.csv')
filter_quality = origdata['Func_MeanFD'] <=0.3
origdata = origdata[filter_quality]

all_subjects = origdata['ID']
cases = []
for subject in all_subjects:
    cases.append(str(subject))

d_cw_groupnorm=[]
d_cw_group=[]

count=0

for case in cases:
	print(count,'/', len(cases))
	results = do_graphtheory_things_pathlength(case)

	ind_groupnorm = [case]
	ind_group = [case]

	for i in range(4):
	    ind_groupnorm.append(results[1][i])
	    ind_group.append(results[2][i])
	d_cw_groupnorm.append(ind_groupnorm)
	d_cw_group.append(ind_group)
	count=count+1

pd.DataFrame(d_cw_groupnorm).to_csv('graphtheory_abide_pathlength_groupnorm.csv')
pd.DataFrame(d_cw_group).to_csv('graphtheory_abide_pathlength_group.csv')
