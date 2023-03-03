% RunRoiIscVsBehaviorRsa.m
%
% Run a representational similarity analysis (RSA) comparing the behavioral
% similarity of each subject pair with the ISC of each subject pair (in
% various ROIs).
%
% For details, see comment from Emily Finn in draft 3.1 of Haskins Story
% ISC paper, which cites her 2020 NeuroImage paper explaining details:
% https://www.sciencedirect.com/science/article/pii/S1053811920303153
%
% Created 5/18-19/22 by DJ.
% Updated 5/23/22 by DJ - updated ROI name/numbers from recent paper draft.
% Updated 5/27/22 by DJ - made a draft of code implementing the to-do list
% Updated 5/31/22 by DJ - allowed behScoreName to change so we can
%   investigate specific sub-scores
% Updated 7/11/22 by HS - incorporated permutation test code from HS
% Updated 7/11/22 by DJ - completed to-do list, cropped, added comments
# Updated 3/2/23 by DJ - updated file structure for sharing

% behScoreName = "ReadScore";
% behScoreName = "MRIScans__ProfileAge";

%% Get behavior scores (from PlotReadingSubscoreHistos.m)

constants = GetStoryConstants();
subjects = constants.okReadSubj;

%% SORT BY BEH SCORE

if (behScoreName == "ReadScore")
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

    % SORT behTable
%     behTable_sorted = behTable(1:length(subj_sorted),:);
%     for i =1:length(subj_sorted)
%         behTable_sorted(i,:) = behTable(strcmp(behTable.haskinsID,subj_sorted{i}),:);
%     end
%     % Append all reading scores
%     allReadScores = [behTable_sorted.TOWREVerified__SWE_SS,behTable_sorted.TOWREVerified__PDE_SS,...
%         behTable_sorted.WoodcockJohnsonVerified__LW_SS, behTable_sorted.WoodcockJohnsonVerified__WA_SS,...
%         behTable_sorted.WASIVerified__Perf_IQ,behTable_sorted.MRIScans__ProfileAge];
%     % weightNames = {'TOWRE_SWE_SS','TOWRE_PDE_SS','TOWRE_TWRE_SS','WJ3_BscR_SS','WJ3_LW_SS','WJ3_WA_SS'};
%     weightNames = {'TOWRE Sight-Word','TOWRE Phoenetic Decoding','WJ3 Letter-Word ID','WJ3 Word Attack','WASI Performance IQ','Age (years)'};


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

%% Get ISC in clusters (from GetPairwiseIscInClusters.m)


% roiMapFile = sprintf('%s/IscResults/Group/3dLME_2Grps_readScoreMedSplit_n69_Automask_top-bot_clust_p0.01_a0.05_bisided_EE.nii.gz',constants.dataDir);
% roiMapFile =
%sprintf('%s/IscResults/Group/3dLME_2Grps_readScoreMedSplit_n40-iqMatched_Automask_top-bot_clust_p0.002_a0.05_bisided_map.nii.gz',constants.dataDir); % clusters with iq-matched top-bot reader pair diffs
roiMapFile = sprintf('%s/shen_268_epiRes_masked+tlrc.BRIK.gz',constants.dataDir); % all Shen atlas regions

nRoi = 268;
roiIndices = 1:nRoi; % all Shen atlas regions

%roiNames =
% {'lITG/lFus','lSPL/lPrecun','lMidFG/lSFG','lMidOG','rSPL/rPostCG','lAG','rIOG/rITG','lParaCL/rParaCL','lPrecun/rCG','lSMG/lIPL','lSMedG/lSFG'}; % full names from MATLAB bar plots
% roiNames = {'lITG','lSPL','lSFG','lMidOG','rSPL','lAG','rIOG','paraCL','Precun','lSMG','lSMedG'};% names from powerpoint results summaries (and paper draft) % clusters with iq-matched top-bot reader pair diffs
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

%% Plot ISC matrices next to each other
% disp('Plotting ISC and Beh Similarity...')
%
% nBot = sum(readScore_sorted<=median(readScore_sorted));
%
% figure(246); clf;
% nPlots = nRoi+2;
% nCols = ceil(sqrt(nPlots));
% nRows = ceil(nPlots/nCols);
% set(246,'Position',[10,10,1400,1000]);
% for iRoi = 1:nRoi
%     % plot pairwise ISC
%     subplot(nRows,nCols,iRoi); cla; hold on;
%     imagesc(iscInRoi(:,:,iRoi));
%     title(roiNames{iRoi});
% end
% % Add behavioral similarity matrices at the end
% subplot(nRows,nCols,nRoi+1); cla; hold on;
% imagesc(behSim_AnnaK);
% title('behSim_AnnaK')
% subplot(nRows,nCols,nRoi+2); cla; hold on;
% imagesc(behSim_NN);
% title('behSim_NN')
%
% % annotate plots
% for iPlot = 1:nPlots
%      subplot(nRows,nCols,iPlot);
% %     plot([nBot,nBot,nSubj,nSubj,nBot]+1.5,[0,nBot,nBot,0,0]-0.5,'g-','LineWidth',2);
%     plot([0,nBot,nBot,0]+0.5,[0,nBot,0,0]+0.5,'-','color',[112 48 160]/255,'LineWidth',2);
%     plot([nBot,nSubj,nSubj,nBot]+0.5,[nBot,nSubj,nBot,nBot]+0.5,'r-','LineWidth',2);
%
%     % annotate plot
%     axis square
%     xlabel(sprintf('better reader-->'))
%     ylabel(sprintf('participant\nbetter reader-->'))
%     set(gca,'ydir','normal');
%     set(gca,'xtick',[],'ytick',[]);
%
%     if iPlot<=nRoi
%         set(gca,'clim',[-.075 .075]);
%     end
%     xlim([1 nSubj]-0.5)
%     ylim([1 nSubj]-0.5)
% %     colormap jet
%     colorbar
%
% end

% save figure
%saveas(246,sprintf('%s/IscResults/Group/SUMA_IMAGES/readScoreSplit_n40-iqMatched_top-bot_p0.002_a0.05_clusterRois_pairwiseIsc.png',constants.dataDir));


%% TODO: Match upper triangle of behavioral ISC with upper triangle of each ROI ISC
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

% statistically test difference between the two
[p,h,stats] = signrank(r_AnnaK,r_NN);
fprintf('signrank test of r_AnnaK vs. r_NN: z=%.3g, p=%.3g\n',stats.zval,p)

% plot results
figure(234); clf; hold on;
set(gcf,'Position',[500,500,400,300])
plot(r_AnnaK,r_NN,'b.');
xlimits = get(gca,'xlim');
ylimits = get(gca,'ylim');
new_lim = [min(xlimits(1),ylimits(1)), max(xlimits(2),ylimits(2))];
plot(new_lim,new_lim,'k')
xlabel('AnnaK model')
ylabel('NN model')
legend('Shen ROIs','1:1')
title(sprintf('Spearman r: %s beh similarity vs. ISC',behScoreName))
% save figure
outFile = sprintf('%s/%s_RsaModelComparison_n68_ShenRois.eps',constants.dataDir,behScoreName);
fprintf('Saving figure as %s...\n',outFile)
saveas(gcf,outFile,'epsc')
disp('Done!')

%% TODO: Calculate statistics
% Shuffle brain-behavior mappings many times to get a null distribution
% Compare actual values to this null distribution
% NOTE: if file exists, it will load it in. So change the filename if you
% change the behavioral similarity matrix.
randPermFile = sprintf('%s/%s_ShenRSA_randPerms_okReadSubj.mat',constants.dataDir,behScoreName);
if exist(randPermFile,'file')
    fprintf('Loading %s...\n',randPermFile)
    randPerms = load(randPermFile);
    r_AnnaK_rand = randPerms.r_AnnaK_rand;
    r_NN_rand = randPerms.r_NN_rand;
else
    nRand = 10000;
    [r_AnnaK_rand, r_NN_rand] = deal(nan(nRoi,nRand));
    fprintf('Running %d permutations...\n',nRand);
    tic;
    for iRand=1:nRand
        if mod(iRand,1000)==0
            fprintf('Running permutation %d/%d...\n',iRand,nRand);
        end
        % permute both rows and cols (the same way) of behavioral similarity matrices
        thisRand = randperm(nSubj);
        behSim_AnnaK_rand = behSim_AnnaK(thisRand,thisRand);
        behSim_NN_rand = behSim_NN(thisRand,thisRand);
        % put back into vector form
        behSim_AnnaK_vec_rand = behSim_AnnaK_rand(uppertri==1)'; % get the upper triangular values of the symmetric matrix, convert to column
        behSim_NN_vec_rand = behSim_NN_rand(uppertri==1)'; % get the upper triangular values of the symmetric matrix, convert to column
        % run spearman corr
        r_AnnaK_rand(:,iRand) = corr(behSim_AnnaK_vec_rand',iscInRoi_vec,'type','Spearman')';
        r_NN_rand(:,iRand) = corr(behSim_NN_vec_rand',iscInRoi_vec,'type','Spearman')';
    end
    fprintf('Saving as %s...\n',randPermFile)
    save(randPermFile,'r_AnnaK_rand','r_NN_rand')
    fprintf('Done! Took %.1f seconds.\n',toc);
end

%% TODO: Get statistics from these permutation tests
% what fraction of random r values were greater than actual r values
% (1-sided test)
[p_AnnaK_rand,p_NN_rand] = deal(nan(1,nRoi));
for iRoi = 1:nRoi
    % calculate for this ROI
    p_AnnaK_rand(iRoi) = mean(r_AnnaK_rand(iRoi,:) > r_AnnaK(iRoi));
    p_NN_rand(iRoi) = mean(r_NN_rand(iRoi,:) > r_NN(iRoi));
    % print results
    fprintf('%s: p_AnnaK_rand = %.3g\n', roiNames{iRoi}, p_AnnaK_rand(iRoi))
    fprintf('%s: p_NN_rand = %.3g\n', roiNames{iRoi}, p_NN_rand(iRoi))

end
% FDR-correct
q = 0.05;
[h, crit_p, adj_ci_cvrg, p_NN_rand_fdr] = fdr_bh(p_NN_rand(:),q,'dep','no'); % use 'dep' b/c values are not expected to be independent.
[h, crit_p, adj_ci_cvrg, p_AnnaK_rand_fdr] = fdr_bh(p_AnnaK_rand(:),q,'dep','no'); % use 'dep' b/c values are not expected to be independent.
% cap to max 1
p_NN_rand_fdr(p_NN_rand_fdr>1) = 1;
p_AnnaK_rand_fdr(p_AnnaK_rand_fdr>1) = 1;
% p_AnnaK_rand_fdr = mafdr(p_AnnaK_rand(:),'bhfdr',true);
% p_NN_rand_fdr = mafdr(p_NN_rand(:),'bhfdr',true);


%% TODO: Make AFNI brik with each ROI's values corresponding to its r value and p value
% get bricks with R values and Q values in proper places
outBrik_r = zeros(size(roiBrik));
outBrik_q = zeros(size(roiBrik));
for iRoi = 1:nRoi
    outBrik_r(roiBrik==iRoi) = r_AnnaK(iRoi);
    outBrik_q(roiBrik==iRoi) = 1-p_AnnaK_rand_fdr(iRoi);
end
% combine
outBrik = cat(4,outBrik_r,outBrik_q);
% write to file
outFile = sprintf('%s/IscResults/Group/%s_RSA_AnnaK_shen_268+tlrc',constants.dataDir,behScoreName);
fprintf('Writing %s...\n',outFile);
Opt = struct('Prefix',outFile,'OverWrite','y');
WriteBrik(outBrik,Info,Opt);
disp('Done!')

% Do the same with NN rs and qs
outBrik_r = zeros(size(roiBrik));
outBrik_q = zeros(size(roiBrik));
for iRoi = 1:nRoi
    outBrik_r(roiBrik==iRoi) = r_NN(iRoi);
    outBrik_q(roiBrik==iRoi) = 1-p_NN_rand_fdr(iRoi);
end
% combine
outBrik = cat(4,outBrik_r,outBrik_q);
% write to file
outFile = sprintf('%s/IscResults/Group/%s_RSA_NN_shen_268+tlrc',constants.dataDir,behScoreName);
fprintf('Writing %s...\n',outFile);
Opt = struct('Prefix',outFile,'OverWrite','y');
WriteBrik(outBrik,Info,Opt);
disp('Done!')

%% TODO: Turn into SUMA image montage

resultsDir = sprintf('%s/IscResults/Group',constants.dataDir);
inFile = sprintf('SUMA_IMAGES_2022/%s_RSA_AnnaK_shen_268+tlrc',behScoreName); % brick you want to save

% make SUMA montage with q=0.05 cutoff
outFile = sprintf('suma_8view_%s_RSA_AnnaK_shen_268_lim0.4_q0.05.jpg',behScoreName);
SetUpSumaMontage_8view(resultsDir,'TEMP_RSA_AnnaK.tcsh','MNI152_2009_SurfVol.nii',...
    inFile,'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,1,'./SUMA_IMAGES_2022','',outFile,[],0.4,0.95,'');

% make SUMA montage with q=0.025 cutoff
outFile = sprintf('SUMA_IMAGES_2022/suma_8view_%s_RSA_AnnaK_shen_268_lim0.4_q0.025.jpg',behScoreName);
SetUpSumaMontage_8view(resultsDir,'TEMP_RSA_AnnaK.tcsh','MNI152_2009_SurfVol.nii',...
    inFile,'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,1,'./SUMA_IMAGES_2022','',outFile,[],0.4,0.975,'');

% make SUMA montage with q=0.01 cutoff
outFile = sprintf('SUMA_IMAGES_2022/suma_8view_%s_RSA_AnnaK_shen_268_lim0.4_q0.01.jpg',behScoreName);
SetUpSumaMontage_8view(resultsDir,'TEMP_RSA_AnnaK.tcsh','MNI152_2009_SurfVol.nii',...
    inFile,'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,1,'./SUMA_IMAGES_2022','',outFile,[],0.4,0.99,'');
