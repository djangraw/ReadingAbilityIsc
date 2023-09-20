function PrintGroupingsByAgeAndIQ()

% Created 7/5/19 by DJ.
% Updated 5/23/22 by DJ - updated behFile
% Updated 11/2/22 by DJ - added handeness & subject motion
% Updated 6/14/23 by DJ - added comprehension

%% Set up
info = GetStoryConstants;

% Read behavior file
behFile = info.behFile;
behTable = readtable(behFile);

%% crop to okReadSubj
behTable = behTable(ismember(behTable.haskinsID,info.okReadSubj),:);

%% get age
subjects = string(behTable.haskinsID);
age = behTable.MRIScans__ProfileAge;
cutoff = median(age);
subj_topAge = subjects(age>cutoff);
subj_botAge = subjects(age<=cutoff);

%% Get IQ
iq = behTable.WASIVerified__Perf_IQ;
cutoff = nanmedian(iq);
subj_topIq = subjects(iq>cutoff);
subj_botIq = subjects(iq<=cutoff);

%% get handedness
handedness = behTable.EdinburghHandedness__LiQ;
cutoff = median(handedness);
subj_topHandedness = subjects(handedness>cutoff);
subj_botHandedness = subjects(handedness<=cutoff);

%% Get subject motion
[subjMotion, censorFraction] = GetStorySubjectMotion(behTable.haskinsID);
cutoff = nanmedian(subjMotion);
subj_topMotion = subjects(subjMotion>cutoff);
subj_botMotion = subjects(subjMotion<=cutoff);

%% Get comprehension scores
comprehension = behTable.Comprehension__PercentageCorrect;
% crop to those with comprehension scores present
subjectsWithComprehension = subjects(~isnan(comprehension));
comprehension = comprehension(~isnan(comprehension));
cutoff = median(comprehension);
subj_topComprehension = subjectsWithComprehension(comprehension>cutoff);
subj_botComprehension = subjectsWithComprehension(comprehension<=cutoff);

%% Print for R script
% display results for easy input into R script

fprintf('===FOR AGE TWO-GROUP R SCRIPT:===\n');
fprintf('# list labels for Group 1 - age <= MEDIAN(age)\n')
fprintf('G1Subj <- c(''%s'')\n',join(subj_botAge,''','''));
fprintf('# list labels for Group 2 - age > MEDIAN(age)\n')
fprintf('G2Subj <- c(''%s'')\n',join(subj_topAge,''','''));

fprintf('===FOR IQ TWO-GROUP R SCRIPT:===\n');
fprintf('# list labels for Group 1 - IQ <= MEDIAN(IQ)\n')
fprintf('G1Subj <- c(''%s'')\n',join(subj_botIq,''','''));
fprintf('# list labels for Group 2 - IQ > MEDIAN(IQ)\n')
fprintf('G2Subj <- c(''%s'')\n',join(subj_topIq,''','''));


fprintf('===FOR HANDEDNESS TWO-GROUP R SCRIPT:===\n');
fprintf('# list labels for Group 1 - handedness <= MEDIAN(handedness)\n')
fprintf('G1Subj <- c(''%s'')\n',join(subj_botHandedness,''','''));
fprintf('# list labels for Group 2 - handedness > MEDIAN(handedness)\n')
fprintf('G2Subj <- c(''%s'')\n',join(subj_topHandedness,''','''));

fprintf('===FOR MOTION TWO-GROUP R SCRIPT:===\n');
fprintf('# list labels for Group 1 - motion <= MEDIAN(motion)\n')
fprintf('G1Subj <- c(''%s'')\n',join(subj_botMotion,''','''));
fprintf('# list labels for Group 2 - motion > MEDIAN(motion)\n')
fprintf('G2Subj <- c(''%s'')\n',join(subj_topMotion,''','''));

fprintf('===FOR COMPREHENSION TWO-GROUP R SCRIPT:===\n');
fprintf('# list labels for Group 1 - comprehension <= MEDIAN(comprehension)\n')
fprintf('G1Subj <- c(''%s'')\n',join(subj_botComprehension,''','''));
fprintf('# list labels for Group 2 - comprehension > MEDIAN(comprehension)\n')
fprintf('G2Subj <- c(''%s'')\n',join(subj_topComprehension,''','''));
