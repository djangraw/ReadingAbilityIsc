#!/bin/bash
set -e

# Run3dIsc_ReadScore_iqMatched.sh
#
# Created 7/13/23 by DJ.
# Updated 7/20/23 by DJ - cleanup, added centering option. Corrected GLTs (G11vG22=1,0.5, G11=1,1, G22=1,-1).

# Declare centering
centering=population # if motion is considered a confound, subtract mean motion of whole population
# centering=group # if motion is considered a mediator, subtract mean motion of each reading group

# Declare filenames
dataDir=/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data
dataTable=${dataDir}/IscResults/Pairwise/StoryPairwiseIscTable_3dISC_iqMatched_${centering}Centered.txt
prefix=${dataDir}/IscResults/Group/3dISC_Dimensional_readScore_n40-iqMatched_v2
# Navigate to location of pairwise ISC results
cd ${dataDir}/IscResults/Pairwise

# Other possible options
# -qVars  'ReadScoreGroup,IQGroup,MotionGroup,ReadScore,IQ,Motion'                            \

3dISC -prefix $prefix -jobs 12 -r2z                     \
          -mask MNI_mask_epiRes.nii  \
          -model  'ReadScore+(1|Subj1)+(1|Subj2)'        \
          -qVars  'ReadScore'                            \
          -gltCode ave       '1   0'                \
          -gltCode ReadScore   '0   1'                \
          -dataTable  @${dataTable}
