function Make3dISCTable()

% Make3dISCTable.m
%
% Use behavioral scores to generate a dataTable for 3dISC 
% (run using Run3dIsc_ReadGrp_MotionCovar.sh).
%
% Created 7/14/23 by DJ.
% Updated 7/18/23 by DJ - added options to center by group, use small set
% of participants or crop features to a small set.
% Updated 7/27/23 by DJ - iq matching, aud/vis/both flag.
% Updated 8/4/23 by DJ - population centering is default, so no longer included in filename

%% Declare constants
AUD_VIS_BOTH_ALL = 'all';
CENTER_BY_GROUP = false; % perform mean centering separately in each group. Divide by std across groups.
USE_SMALL_SET = false; % crop to a small set of participants for debugging
CROP_FEATURES = false; % crop to a small set of features for debugging
USE_IQ_MATCHED = true; % crop to iq-matched participants (N=40)
USE_NN_MODEL = false; % use nearest-neighbor model instead of AnnaK

outFile = 'StoryPairwiseIscTable_3dISC';
if USE_IQ_MATCHED
    outFile = [outFile '_n40-iqMatched'];
else
    outFile = [outFile '_n68'];
end
if USE_NN_MODEL
    outFile = [outFile '_NNmodel'];
end

if CENTER_BY_GROUP
    outFile = [outFile '_groupCentered'];
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
storyTableFilename = sprintf('%s/IscResults/Pairwise/%s',info.dataDir,outFile);
fprintf('Writing to %s...\n',storyTableFilename)
fileID = fopen(storyTableFilename,'w');
if CROP_FEATURES    
    fprintf(fileID,'Subj1 Subj2 ReadScoreGroup Motion Modality InputFile \\\n');
else
    fprintf(fileID,'Subj1 Subj2 ReadScoreGroup IQGroup MotionGroup ReadScore IQ Motion Modality InputFile \\\n');
end
% fill in table
for iSubj1 = 1:length(subjects)
    subject1 = subjects{iSubj1};
    for iSubj2 = (iSubj1+1):length(subjects)
        subject2 = subjects{iSubj2};
        readGroup = (isTopRead(iSubj1)+isTopRead(iSubj2))-1;
        iqGroup = (isTopIQ(iSubj1)+isTopIQ(iSubj2))-1;
        motionGroup = (isTopMotion(iSubj1)+isTopMotion(iSubj2))-1;
        if USE_NN_MODEL
            readScore = -abs(readScore_normed(iSubj1) - readScore_normed(iSubj2));
        else
            readScore = readScore_normed(iSubj1) + readScore_normed(iSubj2);
        end
        iq = iq_normed(iSubj1) + iq_normed(iSubj2);
        motion = motion_normed(iSubj1) + motion_normed(iSubj2);
        if strcmp(AUD_VIS_BOTH_ALL,'both')
            for modality = {'aud','vis'}
                inputFile = sprintf('ISC_%s_%s_story_%s+tlrc',subject1,subject2,modality{1});
                if CROP_FEATURES
                    fprintf(fileID,'%s %s %d %g %s %s \\\n', ...
                        subject1,subject2,readGroup,motion,modality{1},inputFile);
                else
                    fprintf(fileID,'%s %s %d %d %d %g %g %g %s %s \\\n', ...
                        subject1,subject2,readGroup,iqGroup,motionGroup,readScore,iq,motion,modality{1},inputFile);
                end
            end
        else
            if strcmp(AUD_VIS_BOTH_ALL,'all')
                inputFile = sprintf('ISC_%s_%s_story+tlrc',subject1,subject2);
            else
                inputFile = sprintf('ISC_%s_%s_story_%s+tlrc',subject1,subject2,AUD_VIS_BOTH_ALL);
            end
            if CROP_FEATURES
                fprintf(fileID,'%s %s %d %g %s %s \\\n', ...
                    subject1,subject2,readGroup,motion,AUD_VIS_BOTH_ALL,inputFile);
            else
                fprintf(fileID,'%s %s %d %d %d %g %g %g %s %s \\\n', ...
                    subject1,subject2,readGroup,iqGroup,motionGroup,readScore,iq,motion,AUD_VIS_BOTH_ALL,inputFile);
            end
        end
    end
end

fclose(fileID);
disp('Done!')