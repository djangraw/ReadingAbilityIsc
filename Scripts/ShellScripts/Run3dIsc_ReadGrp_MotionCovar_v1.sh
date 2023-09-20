#!/bin/bash
set -e

# Run3dIsc_ReadGrp_MotionCovar_v1.sh
#
# Created 7/13/23 by DJ.
# Updated 7/20/23 by DJ - cleanup, added centering option

# Declare centering
centering=population # if motion is considered a confound, subtract mean motion of whole population
# centering=group # if motion is considered a mediator, subtract mean motion of each reading group

# Declare filenames
dataDir=/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data
dataTable=${dataDir}/IscResults/Pairwise/StoryPairwiseIscTable_3dISC_${centering}Centered.txt
prefix=${dataDir}/IscResults/Group/3dISC_2Grps_readScoreMedSplit_n68_motionCovar_${centering}Centered_v1
# Navigate to location of pairwise ISC results
cd ${dataDir}/IscResults/Pairwise

# Other possible options
# -qVars  'ReadScoreGroup,IQGroup,MotionGroup,ReadScore,IQ,Motion'                            \

3dISC -prefix $prefix -jobs 12 -r2z                     \
          -mask MNI_mask_epiRes.nii  \
          -model  'ReadScoreGroup+Motion+(1|Subj1)+(1|Subj2)'        \
          -qVars  'ReadScoreGroup,Motion'                            \
          -gltCode ave       '1   0  0'                \
          -gltCode G11vG22   '0   1  0'                \
          -gltCode G11       '1  0.5 0'                \
          -gltCode G22       '1 -0.5 0'                \
          -gltCode Motion       '0   0  1'                \
          -dataTable  @${dataTable}
