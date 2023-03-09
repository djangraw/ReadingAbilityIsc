#!/bin/bash

# afni_A182story_v2.0.sh
#
# Created 1/31/19 by DJ based on afni_A182.sh
# Updated 2/1/19 by DJ - modified to match afni_isc_d2.sh, but with regress_reml_exec and 12 jobs
# Updated 3/2/23 by DJ - new directory structure'
# Updated 3/9/23 by DJ - use skull-stripped brain.nii instead of identifiable
#   ${subj}_SurfVol.nii, updated directory structure.

module load afni

# Set directory structure
source 00_CommonVariables.sh
cd $dataDir

for subj in $@
do
	cd $subj
	# run afni_proc.py to create a single subject processing script
	afni_proc.py -subj_id ${subj} \
	-script afni_story_${subj}.tcsh  -scr_overwrite \
	-out_dir ${subj}.story \
	-dsets func_story/*ep2dbold*  \
	-blocks despike tshift align tlrc volreg blur mask scale regress \
		-copy_anat freesurfer/brain.nii  \
		-anat_has_skull no \
		-anat_follower_ROI aaseg anat freesurfer/aparc.a2009s+aseg_rank.nii        \
		-anat_follower_ROI aeseg epi freesurfer/aparc.a2009s+aseg_rank.nii        \
		-anat_follower_ROI FSvent epi freesurfer/FSmask_vent.nii                  \
		-anat_follower_ROI FSWMe epi freesurfer/FSmask_WM.nii                   \
		-anat_follower_erode FSvent FSWMe                           \
	-tcat_remove_first_trs 6 \
	-tshift_opts_ts -tpattern alt+z2 \
		-align_opts_aea -giant_move 					    										\
	-tlrc_base MNI152_T1_2009c+tlrc \
	-tlrc_NL_warp                                                       \
		-volreg_align_to MIN_OUTLIER                                        \
		-volreg_align_e2a                                                   \
		-volreg_tlrc_warp                                                   \
	-blur_size 6 \
		-regress_ROI_PC FSvent 3                                            \
		-regress_make_corr_vols aeseg FSvent                                \
		-regress_anaticor_fast                                              \
		-regress_anaticor_label FSWMe                                       \
		-regress_censor_motion 0.3                                          \
		-regress_censor_outliers 0.1                                        \
		-regress_apply_mot_types demean deriv                               \
		-regress_est_blur_epits                                             \
		-regress_est_blur_errts                                             \
		-regress_run_clustsim no \
		-regress_reml_exec \
		-regress_opts_3dD \
			-jobs 12 \
	-bash -execute

	cd ../
done
