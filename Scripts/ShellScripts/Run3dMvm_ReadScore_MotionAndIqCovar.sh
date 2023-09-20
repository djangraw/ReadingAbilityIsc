#!/bin/bash
set -e

# Run3dMvm_ReadScore_MotionAndIqCovar.sh
#
# Created 7/31/23 by DJ.

# Declare centering
centering=population # if motion is considered a confound, subtract mean motion of whole population
# centering=group # if motion is considered a mediator, subtract mean motion of each reading group

# Declare filenames
dataDir=/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data
dataTable=${dataDir}/GROUP_block_tlrc/StoryMvmTable_3dMVM_${centering}Centered_both.txt
prefix=${dataDir}/GROUP_block_tlrc/3dMVM_Dimensional_readScore_n68_motionAndIqCovar_${centering}Centered_v2
# Navigate to location of pairwise ISC results
cd ${dataDir}/GROUP_block_tlrc

# Run main command
3dMVM -prefix $prefix -jobs 12                          \
          -mask MNI_mask_epiRes.nii  \
          -wsVars 'Modality' \
          -bsVars 'ReadScore+Motion+IQ'        \
          -qVars 'ReadScore,Motion,IQ'                            \
          -num_glt 16 \
          -gltLabel 1 Ave -gltCode 1 'Modality : 0.5*aud +0.5*vis'                \
          -gltLabel 2 ReadScore -gltCode 2 'Modality : 0.5*aud +0.5*vis ReadScore : '                \
          -gltLabel 3 Motion  -gltCode 3 'Modality : 0.5*aud +0.5*vis Motion : '                \
          -gltLabel 4 IQ -gltCode 4 'Modality : 0.5*aud +0.5*vis IQ : '                \
          -gltLabel 5 ave_vis -gltCode 5 'Modality : 1*vis'                \
          -gltLabel 6 ReadScore_vis -gltCode 6 'Modality : 1*vis ReadScore : '                \
          -gltLabel 7 Motion_vis  -gltCode 7 'Modality : 1*vis Motion : '                \
          -gltLabel 8 IQ_vis -gltCode 8 'Modality : 1*vis IQ : '                \
          -gltLabel 9 ave_aud -gltCode 9 'Modality : 1*aud'                \
          -gltLabel 10 ReadScore_aud -gltCode 10 'Modality : 1*aud ReadScore : '                \
          -gltLabel 11 Motion_aud  -gltCode 11 'Modality : 1*aud Motion : '                \
          -gltLabel 12 IQ_aud -gltCode 12 'Modality : 1*aud IQ : '                \
          -gltLabel 13 ave_aud-vis -gltCode 13 'Modality : 1*aud -1*vis'                \
          -gltLabel 14 ReadScore_aud-vis -gltCode 14 'Modality : 1*aud -1*vis ReadScore : '                \
          -gltLabel 15 Motion_aud-vis  -gltCode 15 'Modality : 1*aud -1*vis Motion : '                \
          -gltLabel 16 IQ_aud-vis -gltCode 16 'Modality : 1*aud -1*vis IQ : '                \
          -dataTable @${dataTable}
