#!/bin/bash

# Resampling surface data from fsa5 space to fs_LR (conte69) space

## Input = subject name
subj=$1

# create temp folder 
mkdir temp_$subj
cd temp_$subj

pth_orig='/local_raid/abide1/07_geodist/'$subj
pth_func='/local_raid/abide1/01_fs_processed/'$subj'/surf'
pth_new='/data/mica3/ABIDE/Outputs/geodist/fs_LR_10k'


# define resampling function
conv_surf1(){
	sid=$1
	hemisphere=$2
	if [ "$hemisphere" = "left" ]
	then
		cp $pth_func'/lh.white' ./lh.white
		cp $pth_func'/lh.pial' ./lh.pial
		cp $pth_func'/lh.sphere.reg' ./lh.sphere.reg
		cp '/data/mica1/03_projects/clara/fs_LR-deformed_to-fsaverage.L.sphere.32k_fs_LR.surf.gii' ./lh.newsurf.surf.gii
		midthick_cur=$subj'.L.thickness.fsa5.surf.gii'
		midthick_new=$subj'.L.midthickness.32k_fs_LR.surf.gii'
		surf_out='lh.sphere.reg.surf.gii'
	
		# workbench command for resampling
		wb_shortcuts -freesurfer-resample-prep lh.white lh.pial lh.sphere.reg lh.newsurf.surf.gii $midthick_cur $midthick_new $surf_out
	fi
	if [ "$hemisphere" = "right" ]
	then
		cp $pth_func'/rh.white' ./rh.white
		cp $pth_func'/rh.pial' ./rh.pial
		cp $pth_func'/rh.sphere.reg' ./rh.sphere.reg
		cp '/data/mica1/03_projects/clara/fs_LR-deformed_to-fsaverage.R.sphere.32k_fs_LR.surf.gii' ./rh.newsurf.surf.gii
		midthick_cur=$subj'.R.thickness.fsa5.surf.gii'
		midthick_new=$subj'.R.midthickness.32k_fs_LR.surf.gii'
		surf_out='rh.sphere.reg.surf.gii'

		# workbench command for resampling
		wb_shortcuts -freesurfer-resample-prep rh.white rh.pial rh.sphere.reg rh.newsurf.surf.gii $midthick_cur $midthick_new $surf_out
	fi

	#sid = string of subject id; hemisphere = left/right
}

# second step
conv_surf2() {
	sid=$1
	hemisphere=$2
	if [ "$hemisphere" = "left" ]
	then
		cp $pth_func'/lh.white.gii' ./lh.white.gii
		# convert to gifti
		#wb_command -cifti-convert -to-gifti-ext lh.white lh.white

		wb_command -metric-resample lh.white.gii lh.sphere.reg.surf.gii lh.newsurf.surf.gii BARYCENTRIC $subj'.geodist.lh.32k.fs_LR.func.gii'
	fi
	if [ "$hemisphere" = "right" ]
	then
		wb_command -metric-resample rh.white rh.sphere.reg.surf.gii rh.newsurf.surf.gii BARYCENTRIC $subj'.white.rh.32k.fs_LR.func.gii'
	fi
}

# downsample before GD calculation

calculate_newdist() {
	sid=$1
	hemisphere=$2
	if [ "$hemisphere" = "left" ]
	then
		wb_command -surface-geodesic-distance-all-to-all lh.white L.geodist.dconn.nii
	fi
	if [ "$hemisphere" = "right" ]
	then
		wb_command -surface-geodesic-distance-all-to-all rh.white R.geodist.dconn.nii
	fi
}

conv_surf1 $subj 'left'
#conv_surf2 $subj 'left'
#calculate_newdist $subj 'left'
conv_surf1 $subj 'right'
#conv_surf2 $subj 'right'
#calculate_newdist $subj 'right'

cd ..



