function [r_AnnaK,r_NN] = GetIsRsa(behScoreName,doPlot)

if ~exist("doPlot","var")
    doPlot = false;
end

%% Get behavior scores (from PlotReadingSubscoreHistos.m)

constants = GetStoryConstants();
subjects = constants.okReadSubj;

%% SORT BY BEH SCORE

if startsWith(behScoreName,"ReadScore")
    % get standard reading scores
    disp('Getting reading scores...')
    [readScores, weights,weightNames,IQs,ages] = GetStoryReadingScores(subjects);
    % sort subjects by their reading score
    [behScore_sorted,order] = sort(readScores,'ascend');
    subj_sorted = constants.okReadSubj(order);
else
    % Get other behaviors
    % read behavior table
    behTable = readtable(constants.behFile);

    nSubj = length(subjects);
    behScore = zeros(1,nSubj);
    for i = 1:nSubj
        behScore(i) = behTable.(behScoreName)(strcmp(behTable.haskinsID,subjects{i}));
    end
    [behScore_sorted,order] = sort(behScore,'ascend');
    subj_sorted = subjects(order);

end

if contains(behScoreName,'omprehension')
    behTable = readtable(constants.behFile);
    compScore_sorted = zeros(1,length(subj_sorted));
    for i = 1:length(subj_sorted)
        compScore_sorted(i) = behTable.("Comprehension__PercentageCorrect")(strcmp(behTable.haskinsID,subj_sorted{i}));
    end
    behScore_sorted = behScore_sorted(~isnan(compScore_sorted));
    subj_sorted = subj_sorted(~isnan(compScore_sorted));
    fprintf('%d/%d subjects removed for lacking Comprehension score.\n',nSubj-length(subj_sorted),nSubj);
end

% TODO: In place of behScore_sorted, try each of these other scores that we might
% hypothesize match the function of a certain ROI

%% TODO: Get & Plot "ISC" matrices from behavioral scores
% (i.e., how much does each pair's behavioral profile match?)
disp('Getting behavioral similarity matrices...')
nSubj = length(subj_sorted);
% Anna Karenina model
behSim_AnnaK = zeros(nSubj);
for i = 1:nSubj
    for j = 1:nSubj
        behSim_AnnaK(i,j) = mean(behScore_sorted([i,j]));
    end
end
% Nearest Neighbor model
behSim_NN = zeros(nSubj);
for i = 1:nSubj
    for j = 1:nSubj
        behSim_NN(i,j) = -abs(behScore_sorted(i) - behScore_sorted(j));
    end
end

if doPlot
    % Plot behavioral similarity matrices
    figure(241); clf;
    set(gcf,'Position',[10 10 800 300])
    subplot(1,2,1); cla; hold on;
    imagesc(behSim_AnnaK);
    title(sprintf('Behavioral Similarity:\n %s, AnnaK model',behScoreName))
    subplot(1,2,2); cla; hold on;
    imagesc(behSim_NN);
    title(sprintf('Behavioral Similarity:\n %s, NN model',behScoreName))
    for iPlot=1:2
        subplot(1,2,iPlot)
        % annotate plot
        axis square
        if contains(lower(behScoreName),'iq')
            xlabel(sprintf('higher IQ-->'))
            ylabel(sprintf('participant\nhigher IQ-->'))
        elseif contains(lower(behScoreName),'age')
            xlabel(sprintf('older-->'))
            ylabel(sprintf('participant\nolder-->'))
        else
            xlabel(sprintf('better reader-->'))
            ylabel(sprintf('participant\nbetter reader-->'))
        end
        set(gca,'ydir','normal');
        set(gca,'xtick',[],'ytick',[]);
        xlim([1 nSubj]-0.5)
        ylim([1 nSubj]-0.5)
    %     colormap jet
        colorbar
    end
    outFile = sprintf('%s/%s_BehSimModels_n68.eps',constants.dataDir,behScoreName);
    fprintf('Saving figure as %s...\n',outFile)
    saveas(gcf,outFile,'epsc')
    disp('Done!')
end

%% Get ISC in clusters (from GetPairwiseIscInClusters.m)

% Load & name Shen atlas regions
roiMapFile = sprintf('%s/shen_268_epiRes_masked+tlrc.BRIK.gz',constants.dataDir); % all Shen atlas regions
nRoi = 268;
roiIndices = 1:nRoi; % all Shen atlas regions
roiNames = cell(1,nRoi); % for Shen atlas regions
for iRoi = 1:nRoi
    roiNames{iRoi} = sprintf('Shen%03d',iRoi);
end

% set up
roiLongNames = cell(1,nRoi);
[err,roiMap,Info,errMessage] = BrikLoad(roiMapFile);
for iRoi=1:nRoi
    fprintf('===ROI %d/%d...\n',iRoi,nRoi);
    % get voxels in this ROI
    roiMask = roiMap==roiIndices(iRoi);
    % get long name
    nVoxels = sum(roiMask(:));
    fprintf('%d voxels in mask %s.\n',nVoxels,roiNames{iRoi});
    roiLongNames{j} = sprintf('ROI %d: %s (%d voxels)',roiIndices(iRoi),roiNames{iRoi},nVoxels);
    % add to ROI brick
    if iRoi==1
        roiBrik = roiMask;
    else
        roiBrik = roiBrik + iRoi*roiMask;
    end
end

%% Get ISC in each of these ROIs
% Load it if it already exists
% NOTE: if file exists, it will load it in. So change the filename if you
% change the ROIs or participants.
shenIscFile = sprintf('%s/ShenPairwiseIsc_okReadSubj.mat',constants.dataDir);
if exist(shenIscFile,'file')
    % load it from the .mat file
    fprintf('Loading ISC from %s...\n',shenIscFile)
    iscInRoi = load(shenIscFile);
    iscInRoi = iscInRoi.iscInRoi;

    if (behScoreName ~= "ReadScore")
        % get standard reading scores
        disp('Getting reading scores...')
        [readScores, weights,weightNames,IQs,ages] = GetStoryReadingScores(subjects);
        % sort subjects by their reading score
        [readScore_sorted,order] = sort(readScores,'ascend');
        subj_readsorted = subjects(order); % this is the order of participants (rows/cols) in the file we just loaded

        % fill in lower triangular values for row/col scrambling
        disp('Sorting to match new participant order...')
        iscInRoi_T = permute(iscInRoi,[2,1,3]);
        iscInRoi(isnan(iscInRoi)) = iscInRoi_T(isnan(iscInRoi));
        % Re-sort using new beh score
        fprintf('Re-sorting by %s...\n',behScoreName)
        [~,order] = ismember(subj_sorted,subj_readsorted);
        iscInRoi = iscInRoi(order,order,:);
    end
else
    % otherwise calculate it
    iscInRoi = GetIscInRoi(subj_sorted,roiBrik,1:nRoi);
    % and save it
    fprintf('Saving ISC to %s...\n',shenIscFile)
    save(shenIscFile,'iscInRoi')
end
% update user
disp('Done!')

%% Match upper triangle of behavioral ISC with upper triangle of each ROI ISC
% This is the "RSA": the similarity between brain and behavior across ppl

disp('Calculating RSA...')
% To get the upper triangular values of a symmetric matrix:
uppertri = triu(ones(size(behSim_AnnaK)),1); % get a binary mask that's true for values above the diagonal
behSim_AnnaK_vec = behSim_AnnaK(uppertri==1)'; % get the upper triangular values of the symmetric matrix, convert to column
behSim_NN_vec = behSim_NN(uppertri==1)'; % get the upper triangular values of the symmetric matrix, convert to column
nUpperTri = length(behSim_AnnaK_vec);
% set up
iscInRoi_vec = zeros(nUpperTri,nRoi);
for iRoi = 1:nRoi
    % To get the upper triangular values of a symmetric matrix:
    iscInRoi_this = iscInRoi(:,:,iRoi);
    iscInRoi_vec(:,iRoi) = iscInRoi_this(uppertri==1); % get the upper triangular values of the symmetric matrix
end

% run spearman corr
r_AnnaK = corr(behSim_AnnaK_vec',iscInRoi_vec,'type','Spearman');
r_NN = corr(behSim_NN_vec',iscInRoi_vec,'type','Spearman');

disp('Done!')

