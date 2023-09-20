% MakeClusterThreshMaskedStats_script.m
%
% Created 3/25/19 by DJ.
% Updated 8/22/19 by DJ - switched to n68, added csim_pthr param
% Updated 3/2/23 by DJ - Use GetStoryConstants for directory
% Updated 7/10/23 by DJ - added motion split results

info = GetStoryConstants;
dataDir = info.dataDir;
% csim_pthr = 0.01;
csim_pthr = 0.002;
csim_pthr = 0.00001;


% ======= 1-grp Modality Comparisons (NEW, 3dMVM) ====== %

%% 1-grp Aud-Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "3dMVM_Dimensional_readScore_n68_motionAndIqCovar_populationCentered_v2",[],...
    32,33,'aud-vis',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Aud+Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "3dMVM_Dimensional_readScore_n68_motionAndIqCovar_populationCentered_v2",[],...
   8,9,'aud+vis',[],'TEMP_CLUST+VIS.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Aud, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "3dMVM_Dimensional_readScore_n68_motionAndIqCovar_populationCentered_v2",[],...
    24,25,'aud',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "3dMVM_Dimensional_readScore_n68_motionAndIqCovar_populationCentered_v2",[],...
    16,17,'vis',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


% ======= 1-grp Modality Comparisons (OLD, 3dTTEST) ====== %

%% 1-grp Aud-Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_1grp_minus12",[],...
    20,21,'aud-vis',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Aud+Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_1grp_minus12",[],...
    14,15,'aud+vis',[],'TEMP_CLUST+VIS.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Aud, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_1grp_minus12",[],...
    2,3,'aud',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_1grp_minus12",[],...
    8,9,'vis',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);



%% 2-grp Aud-Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_2grp_minus12",[],...
    60,61,'aud-vis',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp Aud+Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_2grp_minus12",[],...
    42,43,'aud+vis',[],'TEMP_CLUST+VIS.tcsh',[],[],[],[],csim_pthr);

%% 2-grp Aud, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_2grp_minus12",[],...
    6,7,'aud',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_2grp_minus12",[],...
    24,25,'vis',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


% ====== ISC ======== %

%% 1-grp ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask",[],...
    0,1,'all',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask",[],...
    10,11,'top-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask",[],...
    8,9,'bot-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);



% ====== AUD/VIS ISC ======== %

%% 1-grp AUD ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_aud",[],...
    0,1,'all',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp VIS ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_vis",[],...
    0,1,'all',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp AUD-VIS ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_aud-vis",[],...
    0,1,'all',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp TRANS ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_trans",[],...
    0,1,'all',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp TRANS-AUD ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_trans-aud",[],...
    0,1,'all',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 1-grp TRANS-VIS ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_trans-vis",[],...
    0,1,'all',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


%% 2-grp AUD ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud",[],...
    8,9,'top-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud",[],...
    10,11,'bot-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


%% 2-grp VIS ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_vis",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp VIS ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_vis",[],...
    8,9,'top-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp VIS ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_vis",[],...
    10,11,'bot-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


%% 2-grp TRANS ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans",[],...
    8,9,'top-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans",[],...
    10,11,'bot-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


% ============= DIFFS ============= %

%% 2-grp AUD-VIS ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD-VIS ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis",[],...
    8,9,'top-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD-VIS ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis",[],...
    10,11,'bot-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);




%% 2-grp TRANS-AUD ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-aud",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS-AUD ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-aud",[],...
    8,9,'top-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS-AUD ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-aud",[],...
    10,11,'bot-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);




%% 2-grp TRANS-VIS ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-vis",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS-VIS ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-vis",[],...
    8,9,'top-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS-VIS ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-vis",[],...
    10,11,'bot-topbot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);




% ============= AGE/IQ ============= %

%% 2-grp ISC age top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_ageMedSplit_n68_Automask",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC IQ top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_iqMedSplit_n68_Automask",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp VIS ISC IQ top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_iqMedSplit_n68_Automask_vis",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD ISC IQ top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_iqMedSplit_n68_Automask_aud",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

% ============= READSCORE/IQ MATCHED, N=40 ============= %

%% 2-grp ISC ReadScore grps, IQ matched, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n40-iqMatched_Automask",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC IQ grps, ReadScore matched top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_iqMedSplit_n40-readMatched_Automask",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

% ============= MOTION GROUPED, N=68 ============= %

%% 2-grp ISC Motion grps, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_motionMedSplit_n68_Automask",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


% ================================= %
% ============= 3dISC ============= %
% ================================= %

% ============= READSCORE GROUPED, W/ or W/O MOTION & IQ COVARIATES, N=68 ============= %

%% 2-grp ISC ReadScore grps (quant've), Motion Covariate centered on POPULATION mean, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_2Grps_readScoreMedSplit_n68_motionCovar_populationCentered_v2",[],...
    2,3,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC ReadScore grps (dummy), Motion Covariate centered on POPULATION mean, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_2Grps_readScoreMedSplit_n68_motionCovar_populationCentered_v3",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC ReadScore grps, Motion Covariate centered on GROUP mean, full cohort, top-bot, p<0.01 alpha<0.05
% SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
%     "3dISC_2Grps_readScoreMedSplit_n68_motionCovar_groupCentered",[],...
%     2,3,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC ReadScore grps (quant), NO Motion Covariate, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_2Grps_readScoreMedSplit_n68_v2",[],...
    2,3,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC ReadScore grps (dummy), NO Motion Covariate, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_2Grps_readScoreMedSplit_n68_v3",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC ReadScore grps (dummy), NO Motion Covariate, IQ-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_2Grps_readScoreMedSplit_n40-iqMatched_v3",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC ReadScore grps (dummy), YES Motion Covariate, IQ-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_2Grps_readScoreMedSplit_n40-iqMatched_motionCovar_populationCentered_v3",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC ReadScore grps (dummy), Motion and IQ Covariates centered on POPULATION mean, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_2Grps_readScoreMedSplit_n68_motionAndIqCovar_populationCentered_v3",[],...
    6,7,'top-bot',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);



% ================================= %
% ======= DIMENSIONAL 3dISC ======= %
% ================================= %

% ======== ReadScore Dimensional ISC, Full Cohort ========= %

%% ISC ReadScore Dimensional, Motion and IQ Covariates centered on POPULATION mean, full cohort, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC ReadScore Dimensional, Motion Covariate centered on POPULATION mean, full cohort, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotion_n68",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC ReadScore Dimensional, NO Covariates, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScore_n68",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);



% ======== ReadScore Dimensional ISC, IQ-matched Cohort ========= %

%% ISC ReadScore Dimensional, Motion and IQ Covariates centered on POPULATION mean, IQ-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n40-iqMatched",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC ReadScore Dimensional, Motion Covariate centered on POPULATION mean, IQ-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotion_n40-iqMatched",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC ReadScore Dimensional, NO Covariates, IQ-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScore_n40-iqMatched",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


% ======== IQ Dimensional ISC, both cohorts ========= %

%% ISC IQ Dimensional, Motion and ReadScore Covariates centered on POPULATION mean, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68",[],...
    6,7,'IQ',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC IQ Dimensional, Motion and ReadScore Covariates centered on POPULATION mean, readScore-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n40-iqMatched",[],...
    6,7,'IQ',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC IQ Dimensional, NO Covariates centered on POPULATION mean, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_IQ_n68",[],...
    2,3,'IQ',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC IQ Dimensional, NO Covariates centered on POPULATION mean, readScore-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_IQ_n40-iqMatched",[],...
    2,3,'IQ',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

% ======== Motion Dimensional ISC, both cohorts ========= %

%% ISC Motion Dimensional, ReadScore and IQ Covariates centered on POPULATION mean, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68",[],...
    4,5,'Motion',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC Motion Dimensional, ReadScore and IQ Covariates centered on POPULATION mean, IQ-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n40-iqMatched",[],...
    4,5,'Motion',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC Motion Dimensional, NO Covariates, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_Motion_n68",[],...
    2,3,'Motion',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC Motion Dimensional, NO Covariates, readScore-matched cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_Motion_n40-iqMatched",[],...
    2,3,'Motion',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);




% ======== Modality-specific ReadScore ISC ========= %

%% ISC ReadScore Dimensional AUD, Motion & IQ Covariates, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68_aud",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC ReadScore Dimensional VIS, Motion & IQ Covariates Covariates, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68_vis",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC ReadScore Dimensional AUD-VIS, Motion & IQ Covariates Covariates, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68_aud-vis",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);



% ======== NN Model ========= %

%% ISC ReadScore Dimensional, NN model, NO Covariates, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScore_n68_NNmodel",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC ReadScore Dimensional, NN model, motion Covariates, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotion_n68_NNmodel",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC ReadScore Dimensional, NN model, motion & IQ Covariates, full cohort, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68_NNmodel",[],...
    2,3,'ReadScore',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);


% ======== 1-GROUP ISC BY MODALITY ========= %

%% ISC 1-GROUP (from ReadScore/Motion/IQ Dimensional model), full cohort, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68",[],... 
    0,1,'1grp',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC AUD 1-GROUP (from ReadScore/Motion/IQ Dimensional model), full cohort, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68_aud",[],...
    0,1,'1grp',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC VIS 1-GROUP (from ReadScore/Motion/IQ Dimensional model), full cohort, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68_vis",[],...
    0,1,'1grp',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

%% ISC AUD-VIS 1-GROUP (from ReadScore/Motion/IQ Dimensional model), full cohort, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dISC_ReadScoreMotionIQ_n68_aud-vis",[],...
    0,1,'1grp',[],'TEMP_CLUST.tcsh',[],[],[],[],csim_pthr);

