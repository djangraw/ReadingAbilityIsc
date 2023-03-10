% MakeClusterThreshMaskedStats_script.m
%
% Created 3/25/19 by DJ.
% Updated 8/22/19 by DJ - switched to n68, added csim_pthr param
% Updated 3/2/23 by DJ - Use GetStoryConstants for directory

info = GetStoryConstants;
dataDir = info.dataDir;
% csim_pthr = 0.01;
csim_pthr = 0.002;

%% 1-grp Aud-Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_1grp_minus12",[],...
    20,21,'aud-vis',[],'TEMP_AUD-VIS.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Aud+Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_1grp_minus12",[],...
    14,15,'aud+vis',[],'TEMP_AUD+VIS.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Aud, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_1grp_minus12",[],...
    2,3,'aud',[],'TEMP_AUD.tcsh',[],[],[],[],csim_pthr);

%% 1-grp Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_1grp_minus12",[],...
    8,9,'vis',[],'TEMP_VIS.tcsh',[],[],[],[],csim_pthr);



%% 2-grp Aud-Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_2grp_minus12",[],...
    60,61,'aud-vis',[],'TEMP_AUD-VIS.tcsh',[],[],[],[],csim_pthr);

%% 2-grp Aud+Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_2grp_minus12",[],...
    42,43,'aud+vis',[],'TEMP_AUD+VIS.tcsh',[],[],[],[],csim_pthr);

%% 2-grp Aud, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_2grp_minus12",[],...
    6,7,'aud',[],'TEMP_AUD.tcsh',[],[],[],[],csim_pthr);

%% 2-grp Vis, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/GROUP_block_tlrc/",dataDir),...
    "ttest_allSubj_2grp_minus12",[],...
    24,25,'vis',[],'TEMP_VIS.tcsh',[],[],[],[],csim_pthr);


% ====== ISC ======== %

%% 1-grp ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask",[],...
    0,1,'all',[],'TEMP_1GRP.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask",[],...
    10,11,'top-topbot',[],'TEMP_TOP-TOPBOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask",[],...
    8,9,'bot-topbot',[],'TEMP_BOT-TOPBOT.tcsh',[],[],[],[],csim_pthr);



% ====== AUD/VIS ISC ======== %

%% 1-grp AUD ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_aud",[],...
    0,1,'all',[],'TEMP_1GRP.tcsh',[],[],[],[],csim_pthr);

%% 1-grp VIS ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_vis",[],...
    0,1,'all',[],'TEMP_1GRP.tcsh',[],[],[],[],csim_pthr);

%% 1-grp AUD-VIS ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_aud-vis",[],...
    0,1,'all',[],'TEMP_1GRP.tcsh',[],[],[],[],csim_pthr);

%% 1-grp TRANS ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_trans",[],...
    0,1,'all',[],'TEMP_1GRP.tcsh',[],[],[],[],csim_pthr);

%% 1-grp TRANS-AUD ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_trans-aud",[],...
    0,1,'all',[],'TEMP_1GRP.tcsh',[],[],[],[],csim_pthr);

%% 1-grp TRANS-VIS ISC, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_1Grp_n68_Automask_trans-vis",[],...
    0,1,'all',[],'TEMP_1GRP.tcsh',[],[],[],[],csim_pthr);


%% 2-grp AUD ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud",[],...
    8,9,'top-topbot',[],'TEMP_TOP-TOPBOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud",[],...
    10,11,'bot-topbot',[],'TEMP_BOT-TOPBOT.tcsh',[],[],[],[],csim_pthr);


%% 2-grp VIS ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_vis",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp VIS ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_vis",[],...
    8,9,'top-topbot',[],'TEMP_TOP-TOPBOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp VIS ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_vis",[],...
    10,11,'bot-topbot',[],'TEMP_BOT-TOPBOT.tcsh',[],[],[],[],csim_pthr);


%% 2-grp TRANS ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans",[],...
    8,9,'top-topbot',[],'TEMP_TOP-TOPBOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans",[],...
    10,11,'bot-topbot',[],'TEMP_BOT-TOPBOT.tcsh',[],[],[],[],csim_pthr);


% ============= DIFFS ============= %

%% 2-grp AUD-VIS ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD-VIS ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis",[],...
    8,9,'top-topbot',[],'TEMP_TOP-TOPBOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD-VIS ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis",[],...
    10,11,'bot-topbot',[],'TEMP_BOT-TOPBOT.tcsh',[],[],[],[],csim_pthr);




%% 2-grp TRANS-AUD ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-aud",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS-AUD ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-aud",[],...
    8,9,'top-topbot',[],'TEMP_TOP-TOPBOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS-AUD ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-aud",[],...
    10,11,'bot-topbot',[],'TEMP_BOT-TOPBOT.tcsh',[],[],[],[],csim_pthr);




%% 2-grp TRANS-VIS ISC top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-vis",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS-VIS ISC top-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-vis",[],...
    8,9,'top-topbot',[],'TEMP_TOP-TOPBOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp TRANS-VIS ISC bot-topbot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-vis",[],...
    10,11,'bot-topbot',[],'TEMP_BOT-TOPBOT.tcsh',[],[],[],[],csim_pthr);




% ============= AGE/IQ ============= %

%% 2-grp ISC age top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_ageMedSplit_n68_Automask",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC IQ top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_iqMedSplit_n68_Automask",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp VIS ISC IQ top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_iqMedSplit_n68_Automask_vis",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp AUD ISC IQ top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_iqMedSplit_n68_Automask_aud",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

% ============= READSCORE/IQ MATCHED, N=40 ============= %

%% 2-grp ISC ReadScore grps, IQ matched, top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_readScoreMedSplit_n40-iqMatched_Automask",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);

%% 2-grp ISC IQ grps, ReadScore matched top-bot, p<0.01 alpha<0.05
SetUpClusterThreshMaskedStats(sprintf("%s/IscResults/Group/",dataDir),...
    "3dLME_2Grps_iqMedSplit_n40-readMatched_Automask",[],...
    6,7,'top-bot',[],'TEMP_TOP-BOT.tcsh',[],[],[],[],csim_pthr);
