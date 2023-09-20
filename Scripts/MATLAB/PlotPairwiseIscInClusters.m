% PlotPairwiseIscInClusters.m
%
% Plot Pairwise ISC matrices in clusters defined by statistical results.
%
% Created pre-2022 by DJ.
% Updated 3/2/23 by DJ - header, comments, Tc->Timecourse
% Updated 8/4/23 by DJ - new dimensional results, fileBase variable

% Set up
SAVE_FIGURES = true;
constants = GetStoryConstants();
[readScores, IQs,weights,weightNames] = GetStoryReadingScores(constants.okReadSubj);
[readScore_sorted,order] = sort(readScores,'ascend');
subj_sorted = constants.okReadSubj(order);
nSubj = numel(subj_sorted);

%% Get cluster maps

% Declare files and cluster names
% groupDiffMaps = {sprintf('%s/IscResults/Group/3dLME_2Grps_readScoreMedSplit_n68_Automask_top-bot_clust_p0.01_a0.05_bisided_EE.nii.gz',constants.dataDir), ''};
% roiTerms = {'anteriorcingulate','dlpfc','inferiorfrontal','inferiortemporal','supramarginalgyrus','primaryauditory','primaryvisual','frontaleye'};
% roiNames = {'ACC','DLPFC','IFG','ITG','SMG','A1','V1','FEF'};

% groupDiffMaps = {sprintf('%s/IscResults/Group/3dLME_2Grps_readScoreMedSplit_n40-iqMatched_Automask_top-bot_clust_p0.002_a0.05_bisided_map.nii.gz',constants.dataDir)};
% roiIndices = 1:14;
% roiNames = {'IFG-pTri/MidFG','lITG/lMidTG','lSPL/Precun','rSPL/rPostCG','rCer(V1/Crus1)','lIns','lSMedG/lSFG','rMidTG','lPrec/lCalcG','midbrain/VTA','lMidTG/lSTG','laSTG','lMidFG/lSFG','rIOG/rITG'};

% Dimensional ISC w/ covariates, IQ-matched cohort (n=40)
% fileBase = '3dISC_ReadScoreMotionIQ_n40-iqMatched_ReadScore_clust_p0.002_a0.05';
% groupDiffMaps = {sprintf('%s/IscResults/Group/%s_bisided_map.nii.gz',constants.dataDir,fileBase)};
% roiIndices = 1:15;
% roiNames = {'lSTG','rSTG','lIOG','lSFG','ACC','rCun','lCun','rIOG','rCalG','rLingG','lSMA','lMidFG','CerVer','lPreCG','rpCun'};

% Dimensional ISC w/ covariates, full cohort (n=68)
% fileBase = '3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p0.002_a0.05';
% groupDiffMaps = {sprintf('%s/IscResults/Group/%s_bisided_map.nii.gz',constants.dataDir,fileBase)};
% roiIndices = 1:13;
% roiNames = {'Language','lPreCG','lIFG-pOper-pTri','ACC','SMA','lIPL-lSMG','Precun','rPreCG','lMidFG','lSPL-lIPL','lPrecun-lSPL','CerVer','lIFG-pOrb'};
% outFilePrefix = sprintf('%s/IscResults/Group/SUMA_IMAGES_2022/3dISC_ReadScore_n68',constants.dataDir);

% Dimensional ISC w/ covariates, full cohort (n=68), OVERLAP w/ language ROIs
fileBase = '3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p0.002_a0.05';
groupDiffMaps = {sprintf('%s/IscResults/Group/%s_bisided_roioverlap_map.nii.gz',constants.dataDir,fileBase)};
roiIndices = 1:9;
roiNames = {'lSTG','lMTG','lAG','lSMG','lFusG','lITG','lIFG-pOpe','lIFG-pTri','lIFG-pOrb'};
outFilePrefix = sprintf('%s/IscResults/Group/SUMA_IMAGES_2022/3dISC_ReadScore_n68_roioverlap',constants.dataDir);



% sides={'r','l',''};
sides = {''};


nRoi = numel(roiNames);

mapName = cell(1,nRoi);
for i=1:length(groupDiffMaps)
    groupDiffMap = groupDiffMaps{i};
    roiMap = BrikLoad(groupDiffMap);
    for j=1:length(roiNames)
        fprintf('===ROI %d/%d...\n',j,length(roiNames));
        neuroSynthMask = roiMap==roiIndices(j);
        for k=1:numel(sides)

            roiName = sprintf('%s%s',sides{k},roiNames{j});


            olap = GetMaskOverlap(neuroSynthMask);

            % handle hemisphere splits
            if roiName(1)=='r'
                midline = size(olap,1)/2;
                olap(1:midline,:,:) = false;
            elseif roiName(1)=='l'
                midline = size(olap,1);
                olap(midline:end,:,:) = false;
            end
            nVoxels = sum(olap(:));
            fprintf('%d voxels in mask %s.\n',nVoxels,roiName);
            if isempty(groupDiffMap)
                mapName{j} = sprintf('cluster %d: %s (%d voxels)',roiIndices(j),roiName,nVoxels);
            else
                mapName{j} = sprintf('cluster %d: %s * top-bot p<0.01, a<0.05 (%d voxels)',roiIndices(j),roiName,nVoxels);
            end

            if j==1
                roiBrik = olap;
            else
                roiBrik = roiBrik + j*olap;
            end
        end
    end
end
%% Get ISC in ROIs
% tcInRoi = GetTimecourseInRoi(subj_sorted,roiBrik,1:nRoi);
iscInRoi = GetIscInRoi(subj_sorted,roiBrik,1:nRoi);

% CALCULATE WHOLE-BRAIN ROI
wholeBrainRoi = roiBrik*0+1;
iscInWholeBrain = GetIscInRoi(subj_sorted,wholeBrainRoi,1);

% ADD WHOLE-BRAIN ROI
iscInRoi = cat(3,iscInRoi,iscInWholeBrain);
roiNames = [roiNames,{'WholeBrain'}];
nRoi = nRoi + 1;


%% Plot ISC matrices next to each other
nBot = sum(readScore_sorted<=median(readScore_sorted));

figure(246); clf;
nCols = ceil(sqrt(nRoi));
nRows = ceil(nRoi/nCols);
set(246,'Position',[10,10,1400,1000]);
for iRoi = 1:nRoi
    subplot(nRows,nCols,iRoi);
    PlotPairwiseIsc(iscInRoi(:,:,iRoi),roiNames{iRoi});
    
end
fontsize(18, "points")
% saveas(246,sprintf('%s/IscResults/Group/SUMA_IMAGES/readScoreSplit_n40-iqMatched_top-bot_p0.002_a0.05_clusterRois_pairwiseIsc.png',constants.dataDir));
if SAVE_FIGURES
    saveas(246,sprintf('%s_pairwiseIsc.png',outFilePrefix));
end



%% Run permutation tests to get stats
iscInRoi_z = atanh(iscInRoi);

isTop = (readScore_sorted>median(readScore_sorted));
isBot = ~isTop;
meanTopTop = squeeze(nanmean(nanmean(iscInRoi_z(isTop,isTop,:),1),2));
meanTopBot = squeeze(nanmean(nanmean(iscInRoi_z(isBot,isTop,:),1),2));
meanBotBot = squeeze(nanmean(nanmean(iscInRoi_z(isBot,isBot,:),1),2));

tic;
nRand = 10000;
[meanTopTop_rand,meanTopBot_rand,meanBotBot_rand] = deal(nan(nRoi,nRand));
for i=1:nRand
    if mod(i,1000)==0
        fprintf('running permutation %d/%d...\n',i,nRand);
    end
    isTop = isTop(randperm(nSubj));
    isBot = ~isTop;
    meanTopTop_rand(:,i) = squeeze(nanmean(nanmean(iscInRoi_z(isTop,isTop,:),1),2));
    meanTopBot_rand(:,i) = squeeze(nanmean(nanmean(iscInRoi_z(isBot,isTop,:),1),2));
    meanBotBot_rand(:,i) = squeeze(nanmean(nanmean(iscInRoi_z(isBot,isBot,:),1),2));
end
fprintf('Done! Took %.1f seconds.\n',toc);

%% Get perm test result
[pTopTop,pTopBot,pBotBot,pTTmTB,pTBmBB,pTTmBB] = deal(nan(1,nRoi));
for i = 1:nRoi
    pTopTop(i) = mean(meanTopTop_rand(i,:)>meanTopTop(i));
    pTopBot(i) = mean(meanTopBot_rand(i,:)>meanTopBot(i));
    pBotBot(i) = mean(meanBotBot_rand(i,:)>meanBotBot(i));
    pTTmTB(i) = mean((meanTopTop_rand(i,:)-meanTopBot_rand(i,:))>(meanTopTop(i)-meanTopBot(i)));
    pTBmBB(i) = mean((meanTopBot_rand(i,:)-meanBotBot_rand(i,:))>(meanTopBot(i)-meanBotBot(i)));
    pTTmBB(i) = mean((meanTopTop_rand(i,:)-meanBotBot_rand(i,:))>(meanTopTop(i)-meanBotBot(i)));
end

%% Make barplots with stars
isTop = (readScore_sorted>median(readScore_sorted));
isBot = (readScore_sorted<=median(readScore_sorted));

meanTopTop_r = tanh(squeeze(nanmean(nanmean(iscInRoi_z(isTop,isTop,:),1),2)));
meanTopBot_r = tanh(squeeze(nanmean(nanmean(iscInRoi_z(isBot,isTop,:),1),2)));
meanBotBot_r = tanh(squeeze(nanmean(nanmean(iscInRoi_z(isBot,isBot,:),1),2)));
% steTopTop = squeeze(nanstd(nanstd(iscInRoi(isTop,isTop,:),[],1),[],2)./sqrt(sum(sum(~isnan(iscInRoi(isTop,isTop,:))))));
% steTopBot = squeeze(nanstd(nanstd(iscInRoi(isBot,isTop,:),[],1),[],2)./sqrt(sum(sum(~isnan(iscInRoi(isBot,isTop,:))))));
% steBotBot = squeeze(nanstd(nanstd(iscInRoi(isBot,isBot,:),[],1),[],2)./sqrt(sum(sum(~isnan(iscInRoi(isBot,isBot,:))))));


nCols = ceil(sqrt(nRoi));
nRows = ceil(nRoi/nCols);
figure(247); clf;
set(247,'Position',[10,10,1400,1000]);
for iRoi = 1:nRoi
    subplot(nRows,nCols,iRoi);
    PlotGroupIscBars(iscInRoi(:,:,iRoi),roiNames{iRoi},pTTmTB(iRoi),pTBmBB(iRoi),pTTmBB(iRoi));
end
fontsize(18, "points")
% saveas(247,sprintf('%s/IscResults/Group/SUMA_IMAGES/readScoreSplit_n40-iqMatched_top-bot_p0.002_a0.05_clusterRois_groupIscBars.png',constants.dataDir));
if SAVE_FIGURES 
    saveas(247,sprintf('%s_groupIscBars.png',outFilePrefix));
end


%% Plot the two together for each ROI
if SAVE_FIGURES 
    figure(248);
    set(248,'Position',[10   400   667   233])
    fontsize(18, "points")
    for iRoi = 1:nRoi
        % plot pairwise and group ISC next to each other
        subplot(1,2,1); cla;
        PlotPairwiseIsc(iscInRoi(:,:,iRoi),roiNames{iRoi});
        % title('Pairwise')
        subplot(1,2,2); cla;
        PlotGroupIscBars(iscInRoi(:,:,iRoi),roiNames{iRoi},pTTmTB(iRoi),pTBmBB(iRoi),pTTmBB(iRoi));
        % title('Group')
        % save result
        outFile = sprintf('%s_ROI%d_%s_pairwiseAndGroupIsc.png',outFilePrefix,iRoi,roiNames{iRoi});
        saveas(248,outFile);
    end
end

%% Do dimensional analyis within each group
iscInRoi_z_sym = UnvectorizeFc(VectorizeFc(iscInRoi_z),0,true);

meanIscWithAllOthers = squeeze(mean(iscInRoi_z_sym(:,:,:),1));

nCols = ceil(sqrt(nRoi));
nRows = ceil(nRoi/nCols);
figure(249); clf;
set(249,'Position',[10,10,1400,1000]);
[rTop,pTop,rBot,pBot,rAll,pAll] = deal(nan(1,nRoi));
for iRoi = 1:nRoi
    subplot(nRows,nCols,iRoi); cla; hold on;
    [rTop(iRoi),pTop(iRoi)] = corr(readScore_sorted(isTop)',meanIscWithAllOthers(isTop,iRoi));
    [rBot(iRoi),pBot(iRoi)] = corr(readScore_sorted(isBot)',meanIscWithAllOthers(isBot,iRoi));
    [rAll(iRoi),pAll(iRoi)] = corr(readScore_sorted',meanIscWithAllOthers(:,iRoi));
    % plot(find(isTop),meanIscWithAllOthers(isTop,iRoi),'r.');
    % plot(find(isBot),meanIscWithAllOthers(isBot,iRoi),'b.');
    % xlabel('reading rank (1=low)')
    plot(readScore_sorted(isTop),meanIscWithAllOthers(isTop,iRoi),'r.');
    plot(readScore_sorted(isBot),meanIscWithAllOthers(isBot,iRoi),'b.');
    xlabel('reading score')    
    ylabel('mean ISC with all others (z)')
    title(roiNames{iRoi})
    fprintf('ROI %d (%s): pTop=%.1g, pBot=%.1g, pAll=%.1g\n',iRoi,roiNames{iRoi},pTop(iRoi),pBot(iRoi),pAll(iRoi));
    fprintf('   <0: [%s]\n',num2str(find(meanIscWithAllOthers(:,iRoi)<0)'));
end
legend('good reader','poor reader')
figure(250); clf; hold on;
plot(pTop,'.-');
plot(pBot,'.-');
plot(pAll,'.-');
PlotHorizontalLines(0.05,'k--');
legend('top readers','bottom readers','all readers')
grid on;
ylabel('p value of readScore-meanIsc correlation');
set(gca,'xtick',1:nRoi,'xticklabel',roiNames);
xticklabel_rotate;


%% GROUP ROIs
% roiGroups = {[1,2],[3,6,7,8,9,14],[4,5,10,12,13],[14,15],[16]};
% roiGroupNames = {'Aud','Vis','Frontal','Other','WholeBrain'};
% nCols = 4;
% nRows = 1;
% figure(251); clf;
% set(251,'Position',[10,10,1400,1000]);
% 
% subplot(1,2,1); cla; hold on;
% [rAll,pAll] = deal(nan(1,nRoi));
% for iRoi= 1:nRoi  
%     if ismember(iRoi,roiGroups{3})
%         [rAll(iRoi),pAll(iRoi)] = corr(readScore_sorted',meanIscWithAllOthers(:,iRoi));
%         % plot(find(isTop),meanIscWithAllOthers(isTop,iRoi),'r.');
%         % plot(find(isBot),meanIscWithAllOthers(isBot,iRoi),'b.');
%         % xlabel('reading rank (1=low)')
%         plot(readScore_sorted,meanIscWithAllOthers(:,iRoi),'.-');
%         fprintf('ROI %d (%s): pAll=%.1g\n',iRoi,roiNames{iRoi},pAll(iRoi));  
%     end
% end
% xlabel('reading score')    
% ylabel('mean ISC with all others (z)')
% legend(roiNames(roiGroups{3}))
% 
% 
% subplot(1,2,2); cla; hold on;
% [rAll,pAll] = deal(nan(1,length(roiGroups)));
% for iGroup = 1:length(roiGroups)
%     meanIscWithAllOthers_group = mean(meanIscWithAllOthers(:,roiGroups{iGroup}),2);
%     [rAll(iGroup),pAll(iGroup)] = corr(readScore_sorted',meanIscWithAllOthers_group);
%     % plot(find(isTop),meanIscWithAllOthers(isTop,iRoi),'r.');
%     % plot(find(isBot),meanIscWithAllOthers(isBot,iRoi),'b.');
%     % xlabel('reading rank (1=low)')
%     plot(readScore_sorted,meanIscWithAllOthers_group,'.-');
%     fprintf('ROI Group %d (%s): pAll=%.1g\n',iGroup,roiGroupNames{iGroup},pAll(iGroup));  
% end
% xlabel('reading score')    
% ylabel('mean ISC with all others (z)')
% legend(roiGroupNames)
