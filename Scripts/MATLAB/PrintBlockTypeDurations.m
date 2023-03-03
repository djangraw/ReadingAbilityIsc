% PrintBlockTypeDurations.m
% 
% Print durations of each block type for reporting in the Haskins Reading ISC paper.
%
% Created 7/11/22 by DJ.

% From RunStoryPairwiseIscSwarm_VisAud.sh: 
% 3dTcat -overwrite -prefix $visOut $fileIn'[35..54, 93..117, 248..268, 305..327]' # in samples, with onsets delayed 12s for HRF ramp-up
% 3dTcat -overwrite -prefix $audOut $fileIn'[60..87, 123..148, 216..242, 274..299]' # in samples, with onsets delayed 12s for HRF ramp-up
% 3dTcat -overwrite -prefix $transOut $fileIn'[30..34, 55..59, 88..92, 118..122, 149..153, 211..215, 243..247, 269..273, 300..304, 328..332]' # in samples, 2-10s after block offset

% Calculate total times from the TRs used above
TR = 2;
tVis = (54-35 + 117-93 + 268-248 + 327-305 + 4)*TR; % +4 for inclusive
tAud = (87-60 + 148-123 + 242-216 + 299-274 + 4)*TR; % +4 for inclusive
tTrans = (34-30 + 59-55 + 92-88 + 122-118 + 153-149 + 215-211 + 247-243 + 273-269 + 304-300 + 332-328 + 10)*TR; % +10 for inclusive
% Report results in both seconds and TRs
fprintf('tVis = %d s (%d TRs)\ntAud = %d s (%d TRs)\ntTrans = %d s (%d TRs)\n',tVis,tVis/TR,tAud, tAud/TR, tTrans, tTrans/TR)


