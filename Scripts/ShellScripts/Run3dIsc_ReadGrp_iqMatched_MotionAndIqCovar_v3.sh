#!/bin/bash
set -e

# Run3dIsc_ReadGrp_iqMatched_MotionCovar_v3.sh
#
# Created 7/13/23 by DJ.
# Updated 7/20/23 by DJ - cleanup, added centering option. Corrected GLTs (G11vG22=1,0.5, G11=1,1, G22=1,-1).
# Updated 7/24/23 by DJ - IQ matching

# Declare centering
centering=population # if motion is considered a confound, subtract mean motion of whole population
# centering=group # if motion is considered a mediator, subtract mean motion of each reading group

# Declare filenames
dataDir=/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data
dataTable=${dataDir}/IscResults/Pairwise/StoryPairwiseIscTable_3dISC_iqMatched_${centering}Centered.txt
prefix=${dataDir}/IscResults/Group/3dISC_2Grps_readScoreMedSplit_n40-iqMatched_motionAndIqCovar_${centering}Centered_v3
# Navigate to location of pairwise ISC results
cd ${dataDir}/IscResults/Pairwise

# Other possible options
# -qVars  'ReadScoreGroup,IQGroup,MotionGroup,ReadScore,IQ,Motion'                            \

3dISC -prefix $prefix -jobs 12 -r2z                     \
          -mask MNI_mask_epiRes.nii  \
          -model  '0+ReadScoreGroup+Motion+IQ+(1|Subj1)+(1|Subj2)'        \
          -qVars  'Motion,IQ'                            \
          -gltCode Poor       '1 0 0 0 0'                \
          -gltCode Good       '0 0 1 0 0'                \
          -gltCode Mixed       '0 1 0 0 0'                \
          -gltCode Good-Poor       '-1 0 1 0 0'                \
          -gltCode Good-Mixed       '0 -1 1 0 0'                \
          -gltCode Poor-Mixed       '1 -1 0 0 0'                \
          -gltCode Ave-Mixed       '0.5 -1 0.5 0 0'                \
          -gltCode Motion       '0   0  0 1 0'                \
          -gltCode IQ       '0   0  0 0 1'                \
          -dataTable  @${dataTable}
