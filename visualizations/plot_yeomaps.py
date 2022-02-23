from brainstat.datasets import fetch_yeo_networks_metadata
from matplotlib.colors import ListedColormap

# load yeo map 
yeo = sio.loadmat('/pth/yeo_fsaverage5.mat')
yeo = yeo['yeo']
yeo = np.array(yeo, dtype='f')
yeo = yeo[0]

# extract single networks
yeo1 = (yeo == 2).astype(int)
yeo2 = (yeo == 3).astype(int)
yeo3 = (yeo == 4).astype(int)
yeo4 = (yeo == 5).astype(int)
yeo5 = (yeo == 6).astype(int)
yeo6 = (yeo == 7).astype(int)
yeo7 = (yeo == 8).astype(int)
yeoset= [yeo1, yeo2, yeo3, yeo4, yeo5, yeo6, yeo7]

# extract names and rgb values
yeo_data = fetch_yeo_networks_metadata(7) #7 networks parcellation
print(yeo_data[0]) 
print(yeo_data[1]) 

# new colormaps
def build_cmaps(r, g, b):  
    N = 256
    vals = np.ones((N, 4))
    vals[:, 0] = np.linspace(1, r, N)
    vals[:, 1] = np.linspace(1, g, N)
    vals[:, 2] = np.linspace(1, b, N)
    newcmp = ListedColormap(vals)
    return (newcmp)
  
cmaps_visual = build_cmaps(0.47058824, 0.07058824, 0.5254902)
cmaps_smn = build_cmaps(0.2745098, 0.50980392, 0.70588235)
cmaps_dan = build_cmaps(0.,  0.4627451,  0.05490196)
cmaps_van = build_cmaps(0.76862745, 0.22745098, 0.98039216)
cmaps_limbic = build_cmaps(0.8627451,  0.97254902, 0.64313725)
cmaps_fpn = build_cmaps(0.90196078, 0.58039216, 0.13333333)
cmaps_dmn = build_cmaps(0.80392157, 0.24313725, 0.30588235)
cmaps_yeo = [cmaps_dan, cmaps_fpn, cmaps_dmn, cmaps_visual, cmaps_limbic, cmaps_smn, cmaps_van]

# plot with brainstats
plot_hemispheres(
    pial_left,
    pial_right,
    yeoset,
    label_text=['DAN', 'FPN', 'DMN', 'Visual', 'Limbic', 'SMN', 'VAN'],
    cmap = cmaps_yeo,
    embed_nb=True,
    size=(1400,1400),
    zoom=1.45,
    cb__labelTextProperty={'fontSize':15},
)
