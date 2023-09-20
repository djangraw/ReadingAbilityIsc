% PlotWindowedIscAndTc_roiFile.m
%
% Created 4/11/19 by DJ.
% Updated 4/17/19 by DJ - added loop
% Updated 5/22/19 by DJ - switched from NeuroSynth to atlas
% Updated 8/23/19 by DJ - added ste back in, switched to ROI input file.
% Updated 7/7/22 by DJ - fixed roiIndices and roiNames for IQ-matched
% reading group difference clusters, save to IscResults/Group/SUMA2022
% Updated 3/2/23 by DJ - new data structure
% Updated 8/4/23 by DJ - new dimensional 3dISC analyses

constants = GetStoryConstants();

figure(523); clf;
% set(523,'Position',[4 200 1914 862])
set(523,'Position',[4 200 638 287])

% roiMask = BrikLoad(sprintf('%s/IscResults/Group/3dLME_2Grps_readScoreMedSplit_n68_Automask_top-bot_clust_p0.002_a0.05_bisided_map.nii.gz',constants.dataDir));
% roiIndices = 1:8;
% roiNames = {'lITC+lHC+thalamus','lMidTG+AngGyr','ACC','rCer','lIns+lTempPole','mPFC','lMidFG','lIFG'};

% roiMask = BrikLoad(sprintf('%s/IscResults/Group/3dLME_2Grps_readScoreMedSplit_n40-iqMatched_Automask_top-bot_clust_p0.002_a0.05_bisided_map.nii.gz',constants.dataDir));
% roiIndices = 1:11; % new iq-matched reading clusters
% roiNames = {'lITG','lSPL','lSFG','lMidOG','rSPL','lAG','rIOG','paraCL','Precun','lSMG','lSMedG'};% names from powerpoint results summaries (and paper draft) % clusters with iq-matched top-bot reader pair diffs

% % 3dISC dimensional, matched cohort (n=40)
% fileBase = '3dISC_ReadScoreMotionIQ_n40-iqMatched_ReadScore_clust_p0.002_a0.05';
% roiMask = BrikLoad(sprintf('%s/IscResults/Group/%s_bisided_map.nii.gz',constants.dataDir,fileBase));
% roiIndices = 1:16;
% roiNames = {'lSTG','rSTG','lIOG','lSFG','ACC','rCun','lCun','rIOG','rCalG','rLingG','lSMA','lMidFG','CerVer','lPreCG','rpCun','WholeBrain'};
% wholeBrainMask = BrikLoad(sprintf('%s/IscResults/Pairwise/MNI_mask_epiRes.nii',constants.dataDir));
% outFilePrefix = sprintf('%s/IscResults/Group/SUMA_IMAGES_2022/3dISC_ReadScore_n40',constants.dataDir);

% % 3dISC dimensional, full cohort (n=68)
% fileBase = '3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p0.002_a0.05';
% roiMask = BrikLoad(sprintf('%s/IscResults/Group/%s_bisided_map.nii.gz',constants.dataDir,fileBase));
% roiIndices = 1:14;
% roiNames = {'Language','lPreCG','lIFG-pOper/pTri','ACC','SMA','lIPL/lSMG','Precun','rPreCG','lMidFG','lSPL/lIPL','lPrecun/lSPL','CerVer','lIFG-pOrb','WholeBrain'};
% wholeBrainMask = BrikLoad(sprintf('%s/IscResults/Pairwise/MNI_mask_epiRes.nii',constants.dataDir));
% outFilePrefix = sprintf('%s/IscResults/Group/SUMA_IMAGES_2022/3dISC_ReadScore_n68',constants.dataDir);

% 3dISC dimensional, full cohort (n=68), overlap with language ROIs
fileBase = '3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p0.002_a0.05';
roiMask = BrikLoad(sprintf('%s/IscResults/Group/%s_bisided_roioverlap_map.nii.gz',constants.dataDir,fileBase));
roiIndices = 1:10;
roiNames = {'lSTG','lMTG','lAG','lSMG','lFusG','lITG','lIFG-pOpe','lIFG-pTri','lIFG-pOrb','WholeBrain'};
wholeBrainMask = BrikLoad(sprintf('%s/IscResults/Pairwise/MNI_mask_epiRes.nii',constants.dataDir));
outFilePrefix = sprintf('%s/IscResults/Group/SUMA_IMAGES_2022/3dISC_ReadScore_n68_roioverlap',constants.dataDir);


% Uncomment for control regions (A1 and V1)
% roiMask = BrikLoad(sprintf('%s/NeuroSynthTerms/primaryaud_primaryvis_mask+tlrc',constants.dataDir));
% roiIndices = 1:2; % new iq-matched reading clusters
% roiNames = {'A1','V1'};% names from powerpoint results summaries (and paper draft) % clusters with iq-matched top-bot reader pair diffs


[iAud,iVis,iBase] = GetStoryBlockTiming();
colors = {[1 0 0],[112 48 160]/255}; % group colors
%%
for iRoi=1:length(roiIndices)
    fprintf('===ROI %d/%d...\n',iRoi,length(roiIndices));

    % extract ROI info
    roiName = roiNames{iRoi};
    if strcmp(roiName,'WholeBrain')
        isInRoi = wholeBrainMask>0;
    else
        isInRoi = (roiMask==roiIndices(iRoi));
    end
    nVoxels = sum(isInRoi(:));

    fprintf('%d voxels in mask %s.\n',nVoxels,roiName);
    mapName = sprintf('ROI%02d: %s (%d voxels)',iRoi,roiName,nVoxels);


    % Get ISC in ROI
    winLength = 15;
    TR = 2;
    clear iscInRoi
    topResult = sprintf('%s/IscResults/Group/SlidingWindowIsc_win15_toptop+tlrc',constants.dataDir);
    iscInRoi(:,1) = GetTimecourseInRoi(topResult,isInRoi);
    botResult = sprintf('%s/IscResults/Group/SlidingWindowIsc_win15_botbot+tlrc',constants.dataDir);
    iscInRoi(:,2) = GetTimecourseInRoi(botResult,isInRoi);
    % add STERR
    clear iscInRoi_ste
    topResult = sprintf('%s/IscResults/Group/SlidingWindowIsc_win15_toptop_ste+tlrc',constants.dataDir);
    iscInRoi_ste(:,1) = GetTimecourseInRoi(topResult,isInRoi);
    botResult = sprintf('%s/IscResults/Group/SlidingWindowIsc_win15_botbot_ste+tlrc',constants.dataDir);
    iscInRoi_ste(:,2) = GetTimecourseInRoi(botResult,isInRoi);

%     tIsc = ((1:length(iscInRoi)) + winLength/2)*TR; % center of window
%     tIsc = ((1:length(iscInRoi)))*TR; % start of window
    tIsc = ((1:length(iscInRoi)) + winLength)*TR; % end of window

    % Get timecourse in ROI
    clear tcInRoi
    topResult = sprintf('%s/MeanErrtsFanaticor_top+tlrc',constants.dataDir);
    tcInRoi(:,1) = GetTimecourseInRoi(topResult,isInRoi);
    botResult = sprintf('%s/MeanErrtsFanaticor_bot+tlrc',constants.dataDir);
    tcInRoi(:,2) = GetTimecourseInRoi(botResult,isInRoi);
    % Add STDERR
    clear tcInRoi_ste
    topResult = sprintf('%s/SteErrtsFanaticor_top+tlrc',constants.dataDir);
    tcInRoi_ste(:,1) = GetTimecourseInRoi(topResult,isInRoi);
    botResult = sprintf('%s/SteErrtsFanaticor_bot+tlrc',constants.dataDir);
    tcInRoi_ste(:,2) = GetTimecourseInRoi(botResult,isInRoi);

    % Set up plots
    t = (1:length(tcInRoi))*TR;
    figure(523); clf;
    % Plot timecourse
    subplot(2,1,1);
    PlotTimecoursesWithConditions(t,tcInRoi,tcInRoi_ste,colors)
    ylabel(sprintf('Mean BOLD\nsignal change (%%)'))
    xlabel('time (sec)')
%     title(mapName);
    xlim([0,t(end)])

    % Plot ISC
    subplot(2,1,2);
    PlotTimecoursesWithConditions(tIsc,iscInRoi,iscInRoi_ste,colors)
    ylabel('mean ISC')
%     xlabel('time of window center (sec)')
%     xlabel('time of window start (sec)')
    xlabel('time of window end (sec)')
%     title(mapName);
    xlim([0,t(end)])

    % Add legend (comment out for final figures)
    % if iRoi==1
    %     MakeLegend(colors,{'Good Readers','Poor Readers'},[2,2],[0.28,0.9]);
    % end


    % Save figure
    % print(sprintf('%s/IscResults/Group/SUMA_IMAGES_2022/ROI%02d_%s_%ds-win-isc+tc.png',constants.dataDir,iRoi,strrep(roiName,'/','-'),winLength*TR),'-dpng','-r300')
    % print(sprintf('%s/IscResults/Group/SUMA_IMAGES_2022/3dISC_ReadScore_n40_ROI%02d_%s_%ds-win-isc+tc.png',constants.dataDir,iRoi,strrep(roiName,'/','-'),winLength*TR),'-dpng','-r300')
    print(sprintf('%s_ROI%02d_%s_%ds-win-isc+tc.png',outFilePrefix,iRoi,strrep(roiName,'/','-'),winLength*TR),'-dpng','-r300')


end
