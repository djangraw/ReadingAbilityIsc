#!/bin/tcsh -e

# Created 10-Jul-2023 17:11:37 by MATLAB function SetUpClusterThreshMaskedStats.m

set statsfolder = "/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data/IscResults/Group/"
set statsfile = "3dLME_2Grps_readScoreMedSplit_n68_Automask"
set statsfile_space = "tlrc"
set iMean = "8"
set iThresh = "9"
set cond_name = "bot-topbot"
set maskfile = "MNI_mask_epiRes.nii"
set cmd_file = "ClustMaskCmd.tcsh"
set csim_folder = "/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data/ClustSimFiles"
set csim_neigh = "1"
set csim_NN = "NN${csim_neigh}"
set csim_sided = "bisided"
set csim_pthr = "0.01"
set csim_alpha = "0.05"
set csim_pref = "${statsfile}_${cond_name}_clust_p${csim_pthr}_a${csim_alpha}_${csim_sided}"

# run script
source /Users/djangraw/Documents/GitHub/ReadingAbilityIsc/Scripts/ShellScripts/GetClusterThreshMaskedStats.tcsh
