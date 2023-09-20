function ReportReadingMotionStats()
% Report stats on participant motion in each group.
% 
% Created 7/10/23 by DJ in response to reviewer comments.

info = GetStoryConstants();

behTable = readtable(info.behFile);

behTable.readScores = GetStoryReadingScores(behTable.haskinsID);
behTable.subjMotion = GetStorySubjectMotion(behTable.haskinsID);

behTable_cropped = behTable(ismember(behTable.haskinsID,info.okReadSubj),:);

isTop = (behTable_cropped.readScores > median(behTable_cropped.readScores));

medMotion_top = median(behTable_cropped.subjMotion(isTop));
maxMotion_top = max(behTable_cropped.subjMotion(isTop));
minMotion_top = min(behTable_cropped.subjMotion(isTop));
medMotion_bot = median(behTable_cropped.subjMotion(~isTop));
maxMotion_bot = max(behTable_cropped.subjMotion(~isTop));
minMotion_bot = min(behTable_cropped.subjMotion(~isTop));
[p,h,stats] = ranksum(behTable_cropped.subjMotion(isTop),behTable_cropped.subjMotion(~isTop));
% print results
fprintf('GOOD readers median (min-max): %.3g (%.3g-%.3g)\n',medMotion_top,minMotion_top,maxMotion_top)
fprintf('POOR readers median (min-max): %.3g (%.3g-%.3g)\n',medMotion_bot,minMotion_bot,maxMotion_bot)
fprintf('ranksum (top vs. bottom): p=%.3g\n',p)
