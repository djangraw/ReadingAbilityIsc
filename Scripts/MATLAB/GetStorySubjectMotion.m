function [subjMotion, censorFraction] = GetStorySubjectMotion(subjects)

% [subjMotion, censorFraction] = GetStorySubjectMotion(subjects)
%
% INPUTS:
% -subjects is an N-element cell array of strings indicating the subjects
% to be analyzed.
%
% OUTPUTS:
% -subjMotion is an N-element vector of the mean subject motion per TR
% (before censoring).
% -censorFraction is an N-element vector of the fraction of TRs censored
% due to excessive motion or outliers.
%
% Created 5/15/18 by DJ based on GetSrttSubjectMotion.
% Updated 5/22/18 by DJ - use censored motion and directory <subj>.storyISC
% Updated 5/23/18 by DJ - use directory <subj>.storyISC_d2
% Updated 2/5/19 by DJ - use directory a182_v2/<subj>/<subj>.story
% Updated 11/3/22 by DJ - use info.dataDir instead of hard-coded path
% Updated 3/2/23 by DJ - updated file structure
% Updated 6/14/23 by DJ - use participant_motion_table.txt if available


info = GetStoryConstants();
% use participant_motion_table.txt if available
if exist(sprintf("%s/participant_motion_table.txt",info.dataDir),"file")
    fprintf("Using participant_motion_table.txt to get motion...");
    motionTable = readtable(sprintf("%s/participant_motion_table.txt",info.dataDir));
    subjMotion = zeros(numel(subjects),1);
    censorFraction = zeros(numel(subjects),1);
    for i=1:numel(subjects)
        haskinsID = subjects(i);
        subjMotion(i) = motionTable.averageMotion_perTR_(strcmp(motionTable.subject,haskinsID));
        censorFraction(i) = motionTable.censorFraction(strcmp(motionTable.subject,haskinsID));
    end
else
    
    % Set Up
    info = GetStoryConstants;
    % motionStr = 'average motion (per TR)';
    motionStr = 'average censored motion';
    censorStr = 'censor fraction';
    
    subjMotion = nan(1,numel(subjects));
    censorFraction = nan(1,numel(subjects));
    % Get Motion
    for i=1:numel(subjects)
        % Get text from file
        filename = sprintf('%s/%s/%s.story/out.ss_review.%s.txt',info.dataDir,subjects{i},subjects{i},subjects{i});
        if ~exist(filename,'file')
            fprintf('Skipping %s...\n',subjects{i});
        else
            fid = fopen(filename);
            allText = textscan(fid,'%s %s','delimiter',':');
            fclose(fid);
            % Extract motion value
            isAvgMotionLine = strncmpi(allText{1},motionStr,length(motionStr));
            subjMotion(i) = str2double(allText{2}{isAvgMotionLine});
            % Extract censor value
            isCensorFracLine = strncmpi(allText{1},censorStr,length(censorStr));
            censorFraction(i) = str2double(allText{2}{isCensorFracLine});
        end
    end
end
