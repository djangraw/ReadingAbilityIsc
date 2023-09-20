#!/bin/bash
set -e

# Run3dIsc_ReadGrp_v2.sh
#
# Created 7/20/23 by DJ - remove motionCovar. Corrected GLTs (G11vG22=1,0.5, G11=1,1, G22=1,-1).

# Declare filenames
dataDir=/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data
dataTable=${dataDir}/IscResults/Pairwise/StoryPairwiseIscTable_3dISC_populationCentered.txt
prefix=${dataDir}/IscResults/Group/3dISC_2Grps_readScoreMedSplit_n68_v2
# Navigate to location of pairwise ISC results
cd ${dataDir}/IscResults/Pairwise

# Other possible options
# -qVars  'ReadScoreGroup,IQGroup,MotionGroup,ReadScore,IQ,Motion'                            \

3dISC -prefix $prefix -jobs 12 -r2z                     \
          -mask MNI_mask_epiRes.nii  \
          -model  'ReadScoreGroup+(1|Subj1)+(1|Subj2)'        \
          -qVars  'ReadScoreGroup'                            \
          -gltCode ave       '1   0'                \
          -gltCode Good-Poor   '0   2'                \
          -gltCode Good       '1  1'                \
          -gltCode Poor       '1 -1'                \
          -dataTable  @${dataTable}
