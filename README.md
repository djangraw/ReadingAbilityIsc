# Reading Ability ISC

This repository contains the scripts necessary to preprocess, analyze, print and plot the results reported in the following paper:

> Jangraw et al. (in submission). "Inter-Subject Correlation During Long Narratives Uniquely Reveals Neural Correlates of Reading Ability." NeuroImage.


## Dependencies
This code depends on AFNI (version 22.1.09 or later), freesurfer (version 6 or later), and MATLAB (version 2022 or later).

Data must be downloaded and placed as described below.

The code requires adding this project directory and all subdirectories to your MATLAB path.

## Datasets
Data from the included participants described in the paper can be found in the following repository on the Open Science Framework: https://osf.io/qk5yd/.
After downloading and unzipping this file, its contents should be placed inside the `Data` folder of this repository.

If you must place the data elsewhere (e.g., on a cluster), change the directories in [00_CommonVariables.m](Scripts/ShellScripts/00_CommonVariables.sh), each setwd command in the [R folder](Scripts/R), and [GetStoryConstants.m](Scripts/MATLAB/GetStoryConstants.m)

## Usage
After data are copied to the Data folder of this repository, the scripts described below should then be run from their respective folders. Processed data files and figures will be saved to subfolders of the `Data` folder. Note that to remove personally identifying information, the shared anatomical data are the skull-stripped brain.nii and associated masks produced by freesurfer's recon-all (see [RunFreesurferOnAll.sh](Scripts/ShellScripts/RunFreesurferOnAll.sh) for the code used to run freesurfer on the original anatomical images). 

### fMRI Preprocessing
Converts raw fMRI data into preprocessed files. Run the following:
- [RunStoryIscAfniProc_swarm.sh](Scripts/ShellScripts/RunStoryIscAfniProc_swarm.sh) to preprocess all fMRI data
- [RunStory3dDeconvolve_block_tlrc_swarm_minus12.sh](Scripts/ShellScripts/RunStory3dDeconvolve_block_tlrc_swarm_minus12.sh) to run a GLM involving visual and auditory blocks
- [RunStoryGroupTtest_block_tlrc_minus12.sh](Scripts/ShellScripts/RunStoryGroupTtest_block_tlrc_minus12.sh) to run group t-test on GLM results
- [SaveMeanTimecourses_TopBot.m](Scripts/MATLAB/SaveMeanTimecourses_TopBot.m) to save mean and stderr timecourses of activity for each group
- [ResampleShenAtlasToEpiRes.sh](Scripts/ShellScripts/ResampleShenAtlasToEpiRes.sh) to resample the Shen atlas to match the EPI resolution of this dataset.

## Behavior Preprocessing
Groups subjects by behavioral scores. *Resulting values should be copied into relevant ISC R scripts if they have changed.*
- [PlotReadScoreVsConfounds.m](Scripts/MATLAB/PlotReadScoreVsConfounds.m). Plots reading scores against other behaviors/traits.
- [SortStorySubjectsByReadScore.m](Scripts/MATLAB/SortStorySubjectsByReadScore.m). Groups subjects by their reading scores and plots weights of subtests in overall reading score.
- [PrintGroupingsByAgeAndIQ.m](Scripts/MATLAB/PrintGroupingsByAgeAndIQ.m). Groups subjects by their IQ and other scores.
- [SubsampleToMatchGroupIqs.m](Scripts/MATLAB/SubsampleToMatchGroupIqs.m). Randomizes groups of 40 subjects 10,000x and picks the groupings in which readScores and IQs are matched.

### Inter-Subject Correlation (ISC)
Runs pairwise ISC on the data, then calculates group-level ISC results. Run the following:
- [RunStoryPairwiseIscSwarm.sh](Scripts/ShellScripts/RunStoryPairwiseIscSwarm.sh). Runs pairwise ISC on whole dataset.
- [RunStoryPairwiseIscSwarm_reversed.sh](Scripts/ShellScripts/RunStoryPairwiseIscSwarm_reversed.sh). Overwrites the above with manually corrected version for the two subjects with reversed runs.
- [RunStoryPairwiseIscSwarm_VisAud.sh](Scripts/ShellScripts/RunStoryPairwiseIscSwarm_VisAud.sh). Runs pairwise ISC on modality-specific subsets of the data.
- [RunStoryPairwiseIscSwarm_VisAud_reversed.sh](Scripts/ShellScripts/RunStoryPairwiseIscSwarm_VisAud_reversed.sh). Overwrites the above with manually corrected version for the two subjects with reversed runs.
- [3dLME_ISC_1Grp_n68.R](Scripts/R/3dLME_ISC_1Grp_n68.R) ISC 1-group analysis for all n=68 subjects.
- [3dLME_ISC_2Grps_readScoreMedSplit_n68.R](Scripts/R/3dLME_ISC_2Grps_readScoreMedSplit_n68.R) ISC 2-group analysis split by reading score for all n=68 subjects.
- [3dLME_ISC_2Grps_iqMedSplit_n68.R](Scripts/R/3dLME_ISC_2Grps_iqMedSplit_n68.R) ISC 2-group analysis split by IQ score for all n=68 subjects.
- [3dLME_ISC_2Grps_readScoreMedSplit_n40-iqMatched.R](Scripts/R/3dLME_ISC_2Grps_readScoreMedSplit_n40-iqMatched.R) ISC 2-group analysis split by reading score for the IQ-matched set of n=40 subjects.
- [3dLME_ISC_2Grps_iqMedSplit_n40-readMatched.R](Scripts/R/3dLME_ISC_2Grps_iqMedSplit_n40-readMatched.R) ISC 2-group analysis split by IQ score for the reading-matched set of n=40 subjects.
- [3dLME_ISC_1Grp_n68_diffs.R](Scripts/R/3dLME_ISC_1Grp_n68_diffs.R). Compare 1-group ISC in auditory and visual blocks.
- [3dLME_ISC_2Grps_readScoreMedSplit_n68_diffs.R](Scripts/R/3dLME_ISC_2Grps_readScoreMedSplit_n68_diffs.R). Compare 2-group ISC differences observed in auditory and visual blocks.

### Results Production
Produces all the remaining figures, tables, and printed results reported in the paper. Run the following:
- [SetUpClusterThreshMaskedStats.m](Scripts/MATLAB/SetUpClusterThreshMaskedStats.m). Turn group ISC results into cluster-threshold-masked statistics. Must be run before many of the others in this section.
- [MakeSumaImages_script.m](Scripts/MATLAB/MakeSumaImages_script.m). Make 8-view whole-brain fMRI visualizations of all results.
- [PlotPairwiseIscInClusters.m](Scripts/MATLAB/PlotPairwiseIscInClusters.m). Plot subject-by-subject ISC matrices from each cluster, plus permutation tests.
- [RunRoiIscVsBehaviorRsaInLoop.m](Scripts/MATLAB/RunRoiIscVsBehaviorRsaInLoop.m). Run inter-subject representational similarity analysis (IS-RSA) for ReadScore and other behaviors/traits.
- [GetSlidingWindowIsc.m](Scripts/MATLAB/GetSlidingWindowIsc.m). Create sliding-window ISC results.
- [PlotWindowedIscAndTc_roiFile.m](Scripts/MATLAB/PlotWindowedIscAndTc_roiFile.m). Plot timecourse and time-limited ISC in each cluster.
