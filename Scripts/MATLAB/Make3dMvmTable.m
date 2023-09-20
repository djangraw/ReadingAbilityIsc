function Make3dMvmTable()

% Make3dMVMTable.m
%
% Use behavioral scores to generate a dataTable for 3dMVM
% (run using Run3dMvm_ReadGrp_MotionCovar.sh).
%
% Created 7/14/23 by DJ.
% Updated 7/18/23 by DJ - added options to center by group, use small set
% of participants or crop features to a small set.
% Updated 7/27/23 by DJ - iq matching, aud/vis/both flag.
% Updated 7/31/23 by DJ - ISC -> MVM


%% Declare constants
AUD_VIS_BOTH_ALL = 'both';
CENTER_BY_GROUP = false; % perform mean centering separately in each group. Divide by std across groups.
USE_SMALL_SET = false; % crop to a small set of participants for debugging
CROP_FEATURES = false; % crop to a small set of features for debugging
USE_IQ_MATCHED = false; % crop to iq-matched participants (N=40)
USE_NN_MODEL = false; % use nearest-neighbor model instead of AnnaK

outFile = 'StoryMvmTable_3dMVM';
if USE_IQ_MATCHED
    outFile = [outFile '_iqMatched'];
end
if USE_NN_MODEL
    outFile = [outFile '_NNmodel'];
end

if CENTER_BY_GROUP
    outFile = [outFile '_groupCentered'];
else
    outFile = [outFile '_populationCentered'];
end

if strcmp(AUD_VIS_BOTH_ALL,'all')
    outFile = [outFile '.txt'];
else
    outFile = [outFile '_' AUD_VIS_BOTH_ALL '.txt'];
end

%% get subject list
info = GetStoryConstants();

% get behavioral info
behTable = readtable(info.behFile);
behTable.readScores = GetStoryReadingScores(behTable.haskinsID);
behTable.subjMotion = GetStorySubjectMotion(behTable.haskinsID);
if USE_IQ_MATCHED
    behTable_cropped = behTable(ismember(behTable.haskinsID,info.okReadSubj_iqMatched),:);
else
    behTable_cropped = behTable(ismember(behTable.haskinsID,info.okReadSubj),:);
end
% crop to small set if debugging
if USE_SMALL_SET
    subjects = behTable_cropped.haskinsID;
    isTopRead = (behTable_cropped.readScores > median(behTable_cropped.readScores));
    tops = subjects(isTopRead);
    bots = subjects(~isTopRead);
    smallSet = [tops(1:2); bots(1:2)];
    behTable_cropped = behTable_cropped(ismember(behTable_cropped.haskinsID,smallSet),:);
end
% sort alphabetically
[~,order] = sort(behTable_cropped.haskinsID);
behTable_cropped = behTable_cropped(order,:);
% extract quantities for table
subjects = behTable_cropped.haskinsID;
isTopRead = (behTable_cropped.readScores > median(behTable_cropped.readScores));
isTopIQ = (behTable_cropped.WASIVerified__Perf_IQ > median(behTable_cropped.WASIVerified__Perf_IQ));
isTopMotion = (behTable_cropped.subjMotion > median(behTable_cropped.subjMotion));

% subtract mean from these quantitative variables
if CENTER_BY_GROUP
    [readScore_normed,iq_normed,motion_normed] = deal(zeros(length(subjects)));   
    % Center good readers
    readScore_normed(isTopRead) = (behTable_cropped.readScores(isTopRead) - mean(behTable_cropped.readScores(isTopRead)))/std(behTable_cropped.readScores);
    iq_normed(isTopRead) = (behTable_cropped.WASIVerified__Perf_IQ(isTopRead) - mean(behTable_cropped.WASIVerified__Perf_IQ(isTopRead)))/std(behTable_cropped.WASIVerified__Perf_IQ);
    motion_normed(isTopRead) = (behTable_cropped.subjMotion(isTopRead) - mean(behTable_cropped.subjMotion(isTopRead)))/std(behTable_cropped.subjMotion);
    % Center poor readers
    readScore_normed(~isTopRead) = (behTable_cropped.readScores(~isTopRead) - mean(behTable_cropped.readScores(~isTopRead)))/std(behTable_cropped.readScores);
    iq_normed(~isTopRead) = (behTable_cropped.WASIVerified__Perf_IQ(~isTopRead) - mean(behTable_cropped.WASIVerified__Perf_IQ(~isTopRead)))/std(behTable_cropped.WASIVerified__Perf_IQ);
    motion_normed(~isTopRead) = (behTable_cropped.subjMotion(~isTopRead) - mean(behTable_cropped.subjMotion(~isTopRead)))/std(behTable_cropped.subjMotion);
else
    readScore_normed = (behTable_cropped.readScores - mean(behTable_cropped.readScores))/std(behTable_cropped.readScores);
    iq_normed = (behTable_cropped.WASIVerified__Perf_IQ - mean(behTable_cropped.WASIVerified__Perf_IQ))/std(behTable_cropped.WASIVerified__Perf_IQ);
    motion_normed = (behTable_cropped.subjMotion - mean(behTable_cropped.subjMotion))/std(behTable_cropped.subjMotion);
end

%% start file
storyTableFilename = sprintf('%s/GROUP_block_tlrc/%s',info.dataDir,outFile);
fprintf('Writing to %s...\n',storyTableFilename)
fileID = fopen(storyTableFilename,'w');
if CROP_FEATURES    
    fprintf(fileID,'Subj ReadScoreGroup Motion Modality InputFile \\\n');
else
    fprintf(fileID,'Subj ReadScoreGroup IQGroup MotionGroup ReadScore IQ Motion Modality InputFile \\\n');
end
% fill in table
for iSubj1 = 1:length(subjects)
    subject1 = subjects{iSubj1};
    readGroup = isTopRead(iSubj1)-0.5;
    iqGroup = isTopIQ(iSubj1)-0.5;
    motionGroup = isTopMotion(iSubj1)-0.5;
    iq = iq_normed(iSubj1);
    motion = motion_normed(iSubj1);
    readScore = readScore_normed(iSubj1);
    if strcmp(AUD_VIS_BOTH_ALL,'both')
        for modality = {'aud','vis'}  
            inputFile = sprintf('stats.block_minus12.%s_REML+tlrc[%s#0_Coef]',subject1,modality{1});
            if CROP_FEATURES
                fprintf(fileID,'%s %g %g %s %s \\\n', ...
                    subject1,readGroup,motion,modality{1},inputFile);
            else
                fprintf(fileID,'%s %g %g %g %g %g %g %s %s \\\n', ...
                    subject1,readGroup,iqGroup,motionGroup,readScore,iq,motion,modality{1},inputFile);
            end
        end
    else
        if strcmp(AUD_VIS_BOTH_ALL,'all')
            inputFile = sprintf('stats.block_minus12.%s_REML+tlrc',subject1); % TODO: CHECK THIS!
        else
            inputFile = sprintf('stats.block_minus12.%s_REML+tlrc[%s#0_Coef]',subject1,AUD_VIS_BOTH_ALL);
        end
        if CROP_FEATURES
            fprintf(fileID,'%s %g %g %s %s \\\n', ...
                subject1,readGroup,motion,AUD_VIS_BOTH_ALL,inputFile);
        else
            fprintf(fileID,'%s %g %g %g %g %g %g %s %s \\\n', ...
                subject1,readGroup,iqGroup,motionGroup,readScore,iq,motion,AUD_VIS_BOTH_ALL,inputFile);
        end
    end
end

fclose(fileID);
disp('Done!')