% MakeSumaImages_script.m
%
% Make lots of whole-brain fMRI results images.
%
% Created 5/29/18 by DJ.
% Updated 5/1/19 by DJ - added trans, made 8-view
% Updated 8/22/19 by DJ - switched to n68, added csim_pthr param
% Updated 3/2/23 by DJ - updated dataDir for sharing, figure numbers for current draft

doPause = false;
% csim_pthr = 0.01;
csim_pthr = 0.002;
constants = GetStoryConstants;
dataDir = constants.dataDir;
dimensional_clim = 0.05;

% %% 1-grp Aud-Vis, q<0.01
% SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD-VIS.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('ttest_allSubj_1grp_minus12+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     20,21,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_1grp_aud-vis_lim0.3_q0.01.jpg',csim_pthr),[],0.3,'0.01 *q','');
%
% %% 1-grp Aud+Vis, q<0.01
% SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD+VIS.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('ttest_allSubj_1grp_minus12+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     14,15,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_1grp_aud+vis_lim0.3_q0.01.jpg',csim_pthr),[],0.3,'0.01 *q','');
%
% %% 1-grp Aud, q<0.01
% SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('ttest_allSubj_1grp_minus12+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     2,3,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_1grp_aud_lim0.3_q0.01.jpg',csim_pthr),[],0.3,'0.01 *q','');
%
% %% 1-grp Vis, q<0.01
% SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_VIS.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('ttest_allSubj_1grp_minus12+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     8,9,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_1grp_vis_lim0.3_q0.01.jpg',csim_pthr),[],0.3,'0.01 *q','');
%
%
%
%
%

% ======= 1-grp Modality Comparisons (NEW, 3dMVM) ====== %

%% 1-grp Aud-Vis, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dMVM_Dimensional_readScore_n68_motionAndIqCovar_aud-vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dMVM_1grp_aud-vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 1-grp Aud+Vis, p<csim_pthr alpha<0.05 (FIG. S4A)
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD+VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dMVM_Dimensional_readScore_n68_motionAndIqCovar_aud+vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dMVM_1grp_aud+vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 1-grp Aud, p<csim_pthr alpha<0.05 (FIG. S5A)
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dMVM_Dimensional_readScore_n68_motionAndIqCovar_aud_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dMVM_1grp_aud_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 1-grp Vis, p<csim_pthr alpha<0.05 (FIG. S5A)
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dMVM_Dimensional_readScore_n68_motionAndIqCovar_vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dMVM_1grp_vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end




% ======= 1-grp Modality Comparisons (OLD, 3dTTEST) ====== %

%% 1-grp Aud-Vis, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('ttest_allSubj_1grp_minus12_aud-vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_1grp_aud-vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 1-grp Aud+Vis, p<csim_pthr alpha<0.05 (FIG. S4A)
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD+VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('ttest_allSubj_1grp_minus12_aud+vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_1grp_aud+vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 1-grp Aud, p<csim_pthr alpha<0.05 (FIG. S5A)
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('ttest_allSubj_1grp_minus12_aud_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_1grp_aud_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 1-grp Vis, p<csim_pthr alpha<0.05 (FIG. S5A)
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('ttest_allSubj_1grp_minus12_vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_1grp_vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end



%% 2-grp Aud-Vis, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('ttest_allSubj_2grp_minus12_aud-vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_2grp_aud-vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 2-grp Aud+Vis, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD+VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('ttest_allSubj_2grp_minus12_aud+vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_2grp_aud+vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 2-grp Aud, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_AUD_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('ttest_allSubj_2grp_minus12_aud_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_2grp_aud_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end
%% 2-grp Vis, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/GROUP_block_tlrc',dataDir),'TEMP_VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('ttest_allSubj_2grp_minus12_vis_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_2grp_vis_lim0.3_p%g_a0.05.jpg',csim_pthr),[],0.3,'0','');
if doPause, pause(60); end



% %% 1-grp ISC, q<0.01
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_1Grp_n68_Automask+tlrc.HEAD','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     0,1,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_1grp_lim0.4_q0.01.jpg',csim_pthr),[],0.4,'0.01 *q','');
%
% if doPause, pause(60); end
%% 1-grp ISC, p<csim_pthr alpha<0.05 (FIG. S4B)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_1GRP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_1Grp_n68_Automask_all_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_1grp_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end
% %% 2-grp ISC top-bot,q<0.01
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     6,7,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_top-bot_lim0.1_q0.01.jpg',csim_pthr),[],0.1,'0.01 *q','');
%
% if doPause, pause(60); end
%% 2-grp ISC top-bot, p<csim_pthr alpha<0.05 (FIG. 3)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end
%% 2-grp ISC top-topbot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD+VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_top-topbot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_top-topbot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end
%% 2-grp ISC bot-topbot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_bot-topbot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_bot-topbot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end
% %% 2-grp ISC top-bot,q<0.05, 20vox clusters
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_G2-G1_q01_20vox-clustermask+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_top-bot_lim0.1_q05_20vox.jpg',csim_pthr),[],0.1,'0','');
%
% if doPause, pause(60); end
% %% 2-grp ISC top-bot, p<csim_pthr alpha<0.05: CLUSTER MASK
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUSTMAP.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_top-bot_clust_p%g_a0.05_bisided_map.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_top-bot_clustmap_p%g_a0.05.jpg',csim_pthr),[],32,'0','roi_i32');



% ====== AUD/VIS/TRANS ISC ======== %

%% 1-grp AUD ISC, p<csim_pthr alpha<0.05 (FIG. S5B)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_1GRP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_1Grp_n68_Automask_aud_all_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_aud_all_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end
%% 1-grp VIS ISC, p<csim_pthr alpha<0.05 (FIG. S5B)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_1GRP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_1Grp_n68_Automask_vis_all_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_vis_all_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end
%% 1-grp TRANS ISC, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_1GRP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_1Grp_n68_Automask_trans_all_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_trans_all_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end

% ====== AUD/VIS/TRANS 1-GROUP ISC DIFFS ======== %

%% 1-grp AUD-VIS ISC, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_1GRP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_1Grp_n68_Automask_aud-vis_all_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_aud-vis_all_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end
%% 1-grp TRANS-AUD ISC, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_1GRP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_1Grp_n68_Automask_trans-aud_all_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_trans-aud_all_lim0.5_p%g_a0.05.jpg',csim_pthr),[],0.5,'0','');

if doPause, pause(60); end
%% 1-grp TRANS-VIS ISC, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_1GRP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_1Grp_n68_Automask_trans-vis_all_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_trans-vis_all_lim0.5_p%g_a0.05.jpg',csim_pthr),[],0.5,'0','');

if doPause, pause(60); end


% ====== AUD/VIS/TRANS 2-GROUP ISC ======== %


% %% 2-grp AUD ISC top-bot,q<0.01
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_aud+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     6,7,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_aud_top-bot_lim0.1_q0.01.jpg',csim_pthr),[],0.1,'0.01 *q','');
%
% if doPause, pause(60); end
%% 2-grp AUD ISC top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_aud_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_aud_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end

% %% 2-grp VIS ISC top-bot,q<0.01
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_vis+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     6,7,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_vis_top-bot_lim0.1_q0.01.jpg',csim_pthr),[],0.1,'0.01 *q','');
%
% if doPause, pause(60); end
%% 2-grp VIS ISC top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_vis_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_vis_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end

% %% 2-grp TRANS ISC top-bot,q<0.01
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_trans+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     6,7,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_trans_top-bot_lim0.1_q0.01.jpg',csim_pthr),[],0.1,'0.01 *q','');
%
% if doPause, pause(60); end
%% 2-grp TRANS ISC top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_trans_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_trans_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end


% ====== AUD/VIS/TRANS 2-GROUP ISC DIFFS ======== %

% %% 2-grp AUD-VIS ISC top-bot,q<0.01
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis+tlrc','suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     6,7,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_aud-vis_top-bot_lim0.6_q0.01.jpg',csim_pthr),[],0.6,'0.01 *q','');
%
% if doPause, pause(60); end
%% 2-grp AUD-VIS ISC top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_aud-vis_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end
% %% 2-grp AUD-VIS ISC top-bot, p<csim_pthr alpha<0.05 CLUSTER MAP
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_aud-vis_top-bot_clust_p%g_a0.05_bisided_map.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_aud-vis_top-bot_clustmap_p%g_a0.05.jpg',csim_pthr),[],32,'0','roi_i32');
%
% if doPause, pause(60); end

%% 2-grp TRANS-AUD ISC top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-aud_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_trans-aud_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end

%% 2-grp TRANS-VIS ISC top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_TOP-BOT_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n68_Automask_trans-vis_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_trans-vis_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end



% ============= AGE & IQ ================= %

%% 2-grp ISC AGE top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_ageMedSplit_n68_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_age-top-bot_lim0.03_p%g_a0.05.jpg',csim_pthr),[],0.03,'0','');

if doPause, pause(60); end

%% 2-grp ISC IQ top-bot, p<csim_pthr alpha<0.05 (FIG. S6B)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_iqMedSplit_n68_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_iq-top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end

%% 2-grp ISC HANDEDNESS top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_handednessMedSplit_n68_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_handedness-top-bot_lim0.03_p%g_a0.05.jpg',csim_pthr),[],0.03,'0','');

if doPause, pause(60); end

%% 2-grp ISC MOTION top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_motionMedSplit_n68_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_motion-top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end

%% 2-grp ISC IQ and ReadScore conjunction (top-bot, p<csim_pthr alpha<0.05)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('Conjunction_readScore-plus-2IQ_p%g_a0.05+tlrc.BRIK.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_Conj_readScorePlus2Iq-top-bot_p%g_a0.05.jpg',csim_pthr),[],32,'0','ROI_i32');

if doPause, pause(60); end

%% 2-grp VIS ISC IQ and ReadScore conjunction (top-bot, p<csim_pthr alpha<0.05)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('Conjunction_readScore-plus-2IQ_vis_p%g_a0.05+tlrc.BRIK.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_Conj_readScorePlus2Iq_vis-top-bot_p%g_a0.05.jpg',csim_pthr),[],32,'0','ROI_i32');

if doPause, pause(60); end

%% 2-grp AUD ISC IQ and ReadScore conjunction (top-bot, p<csim_pthr alpha<0.05)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('Conjunction_readScore-plus-2IQ_aud_p%g_a0.05+tlrc.BRIK.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_Conj_readScorePlus2Iq_aud-top-bot_p%g_a0.05.jpg',csim_pthr),[],32,'0','ROI_i32');

if doPause, pause(60); end

%% 2-grp AUD and VIS ISC conjunction, ReadScore groups (top-bot, p<csim_pthr alpha<0.05)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('Conjunction_readScoreGrps_aud-plus-2vis_p%g_a0.05+tlrc.BRIK.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_Conj_readScoreGrps_audPlus2Vis_top-bot_p%g_a0.05.jpg',csim_pthr),[],32,'0','ROI_i32');

if doPause, pause(60); end

%% 2-grp AUD and VIS ISC conjunction, IQ groups (top-bot, p<csim_pthr alpha<0.05)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('Conjunction_iqGrps_aud-plus-2vis_p%g_a0.05+tlrc.BRIK.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_Conj_iqGrps_audPlus2Vis_top-bot_p%g_a0.05.jpg',csim_pthr),[],32,'0','ROI_i32');

if doPause, pause(60); end


% ========== READSCORE & IQ MATCHED, N=40 ========== %
%% 2-grp ISC Readscore grps, IQ matched, top-bot, p<csim_pthr alpha<0.05 (FIG. 4A, S8A)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n40-iqMatched_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_readScoreGrps_n40-iqMatched_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end

%% 2-grp ISC IQ grps, readScore matched, top-bot, p<csim_pthr alpha<0.05 (FIG. 4B, S8B)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_iqMedSplit_n40-readMatched_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_iqGrps_n40-readScoreMatched_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');

if doPause, pause(60); end

%% 2-grp ISC Readscore grps, IQ matched, top-bot, p<csim_pthr alpha<0.05: CLUSTER MASK (FIG. 5, 7, S9)
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUSTMAP.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_readScoreMedSplit_n40-iqMatched_Automask_top-bot_clust_p%g_a0.05_bisided_map.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_readScoreGrps_n40-iqMatched_top-bot_clustmap_p%g_a0.05.jpg',csim_pthr),[],32,'0','roi_i32');


%% A1 & V1, NeuroSynth
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_AUD-VIS_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('%s/NeuroSynthTerms/primaryaud_primaryvis_mask+tlrc',dataDir),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','','SUMA_IMAGES_2022/suma_8view_primaryaud_primaryvis.jpg',[],32,'0','roi_i32');
if doPause, pause(60); end


%% 2-grp ISC WJ3 passage Comprehension grps, n=60, top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_comprehensionMedSplit_n61_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_comprehensionGrps_n61_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 2-grp ISC Motion grps, n=68, top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dLME_2Grps_motionMedSplit_n68_Automask_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_ISC_motionGrps_n68_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end





%% 2-grp ISC ReadScore grps (quant) Motion covariate, POPULATION centered, n=68, top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_2Grps_readScoreMedSplit_n68_motionCovar_populationCentered_v2_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreGrps_n68_motionCovar_populationCentered_v2_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 2-grp ISC ReadScore grps (dummy) Motion covariate, POPULATION centered, n=68, top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_2Grps_readScoreMedSplit_n68_motionCovar_populationCentered_v3_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreGrps_n68_motionCovar_populationCentered_v3_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 2-grp ISC ReadScore grps (dummy) Motion & IQ covariates, POPULATION centered, n=68, top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_2Grps_readScoreMedSplit_n68_motionAndIqCovar_populationCentered_v3_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreGrps_n68_motionAndIqCovar_populationCentered_v3_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 2-grp ISC ReadScore grps Motion covariate, GROUP centered, n=68, top-bot, p<csim_pthr alpha<0.05
% SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
%     sprintf('3dISC_2Grps_readScoreMedSplit_n68_motionCovar_groupCentered_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
%     0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreGrps_n68_motionCovar_groupCentered_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% % 
% if doPause, pause(60); end

%% 2-grp ISC ReadScore grps (dummy) NO Motion covariate, n=68, top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_2Grps_readScoreMedSplit_n68_v3_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreGrps_n68_v3_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 2-grp ISC ReadScore grps (dummy) Motion covariate, n=40, top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_2Grps_readScoreMedSplit_n40-iqMatched_motionCovar_populationCentered_v3_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreGrps_n40-iqMatched_motionCovar_v3_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 2-grp ISC ReadScore grps (dummy) NO Motion covariate, n=40, top-bot, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_2Grps_readScoreMedSplit_n40-iqMatched_v3_top-bot_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreGrps_n40-iqMatched_v3_top-bot_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end






% ================================= %
% ======= DIMENSIONAL 3dISC ======= %
% ================================= %

%% 3dISC ReadScore Dimensional, Motion & IQ covariates, POPULATION centered, n=68, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional CLUSTER MAP, Motion and IQ covariates, POPULATION centered, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p%g_a0.05_bisided_map.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_ReadScore_clustmap_p%g_a0.05.jpg',csim_pthr),[],32,'0','roi_i32');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional CLUSTER MAP OVERLAP with predefined language ROIs, Motion and IQ covariates, POPULATION centered, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p%g_a0.05_bisided_roioverlap_map.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_ReadScore_roioverlap_clustmap_p%g_a0.05.jpg',csim_pthr),[],9,'0','cb_spiral35');
% 
if doPause, pause(60); end


%% 3dISC ReadScore Dimensional, Motion covariate, POPULATION centered, n=68, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotion_n68_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotion_n68_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional, NO Motion covariate, n=68, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScore_n68_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScore_n68_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end



%% 3dISC ReadScore Dimensional, Motion and IQ covariates, POPULATION centered, n=40 (IQ-matched), ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n40-iqMatched_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n40-iqMatched_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional CLUSTER MAP, Motion and IQ covariates, POPULATION centered, n=40 (IQ-matched), ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n40-iqMatched_ReadScore_clust_p%g_a0.05_bisided_map.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n40-iqMatched_ReadScore_clustmap_p%g_a0.05.jpg',csim_pthr),[],32,'0','roi_i32');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional, Motion covariate, POPULATION centered, n=40 (IQ-matched), ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotion_n40-iqMatched_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotion_n40-iqMatched_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional, NO Motion covariate, n=40 (IQ-matched), ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScore_n40-iqMatched_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScore_n40-iqMatched_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end



% ======= MODALITY-SPECIFIC 3dISC ======= %

%% 3dISC ReadScore Dimensional, AUD, NO Motion covariate, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScore_n68_aud_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScore_n68_aud_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional, VIS, NO Motion covariate, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScore_n68_vis_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreDim_n68_vis_v2_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional, AUD-VIS, NO Motion covariate, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScore_n68_aud-vis_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreDim_n68_aud-vis_v2_ReadScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end



% ======= 1-GROUP MODALITY-SPECIFIC 3dISC ======= %

%% 3dISC 1-GROUP (from ReadScore Dimensional model), Motion & IQ covariates, n=68, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_1grp_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_1grp_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 3dISC 1-GROUP (from ReadScore Dimensional model), AUD, Motion & IQ covariates, n=68, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_aud_1grp_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_aud_1grp_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 3dISC 1-GROUP (from ReadScore Dimensional model), VIS, Motion & IQ covariates, n=68, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_vis_1grp_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_vis_1grp_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end

%% 3dISC 1-GROUP (from ReadScore Dimensional model), AUD-VIS, Motion & IQ covariates, n=68, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_aud-vis_1grp_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_aud-vis_1grp_lim0.1_p%g_a0.05.jpg',csim_pthr),[],0.1,'0','');
% 
if doPause, pause(60); end



% ======= NN Model 3dISC ======= %

%% 3dISC ReadScore Dimensional, NN model, NO Motion covariate, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_Dimensional_readScore_n68_NNmodel_v2_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreDim_n68_NNmodel_v2_readScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC ReadScore Dimensional, NN model, Motion covariate (pouplation centered), n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_Dimensional_readScore_n68_NNmodel_motionCovar_ReadScore_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_readScoreDim_n68_NNmodel_motionCovar_readScore_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end


% ======= IQ 3dISC ======= %

%% 3dISC IQ Dimensional, Motion and ReadScore covariates, POPULATION centered, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_IQ_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_IQ_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC IQ Dimensional, Motion and ReadScore covariates, POPULATION centered, n=40 (IQ-matched), ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n40-iqMatched_IQ_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n40-iqMatched_IQ_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC IQ Dimensional, NO covariates, POPULATION centered, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_IQ_n68_IQ_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_IQ_n68_IQ_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC IQ Dimensional, NO covariates, POPULATION centered, n=40 (IQ-matched), ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_IQ_n40-iqMatched_IQ_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_IQ_n40-iqMatched_IQ_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end


% ======= MOTION 3dISC ======= %

%% 3dISC Motion Dimensional, IQ and ReadScore covariates, POPULATION centered, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n68_Motion_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n68_Motion_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC Motion Dimensional, IQ and ReadScore covariates, POPULATION centered, n=40 (IQ-matched), ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_ReadScoreMotionIQ_n40-iqMatched_Motion_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_ReadScoreMotionIQ_n40-iqMatched_Motion_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC Motion Dimensional, NO covariates, POPULATION centered, n=68, ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_Motion_n68_Motion_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_Motion_n68_Motion_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end

%% 3dISC Motion Dimensional, NO covariates, POPULATION centered, n=40 (IQ-matched), ReadScore, p<csim_pthr alpha<0.05
SetUpSumaMontage_8view(sprintf('%s/IscResults/Group',dataDir),'TEMP_CLUST.tcsh','MNI152_2009_SurfVol.nii',...
    sprintf('3dISC_Motion_n40-iqMatched_Motion_clust_p%g_a0.05_bisided_EE.nii.gz',csim_pthr),'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,0,'./SUMA_IMAGES_2022','',sprintf('SUMA_IMAGES_2022/suma_8view_3dISC_Motion_n40-iqMatched_Motion_lim%g_p%g_a0.05.jpg',dimensional_clim,csim_pthr),[],dimensional_clim,'0','');
% 
if doPause, pause(60); end






