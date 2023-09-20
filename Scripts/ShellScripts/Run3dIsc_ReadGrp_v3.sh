#!/bin/bash
set -e

# Run3dIsc_ReadGrp_v3.sh
#
# Created 7/20/23 by DJ - remove motionCovar. Corrected GLTs (G11vG22=1,0.5, G11=1,1, G22=1,-1).
#  AND made ReadScoreGroup categorical.

# Declare filenames
dataDir=/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data
dataTable=${dataDir}/IscResults/Pairwise/StoryPairwiseIscTable_3dISC_populationCentered.txt
prefix=${dataDir}/IscResults/Group/3dISC_2Grps_readScoreMedSplit_n68_v3
# Navigate to location of pairwise ISC results
cd ${dataDir}/IscResults/Pairwise

# Other possible options
# -qVars  'ReadScoreGroup,IQGroup,MotionGroup,ReadScore,IQ,Motion'                            \

3dISC -prefix $prefix -jobs 12 -r2z                     \
          -mask MNI_mask_epiRes.nii  \
          -model  '0+ReadScoreGroup+(1|Subj1)+(1|Subj2)'        \
          -gltCode Poor       '1 0 0'                \
          -gltCode Good       '0 0 1'                \
          -gltCode Mixed       '0 1 0'                \
          -gltCode Good-Poor       '-1 0 1'                \
          -gltCode Good-Mixed       '0 -1 1'                \
          -gltCode Poor-Mixed       '1 -1 0'                \
          -gltCode Ave-Mixed       '0.5 -1 0.5'                \
          -dataTable  @${dataTable}
