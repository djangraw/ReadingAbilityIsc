function MakeWordFormattedTableOfClusters(filename)

% MakeWordFormattedTableOfClusters(filename)
%
% Print table of clusters that can be entered into Excel/Word/Ppt.
%
% Created pre-8/3/23 by DJ.
% Updated 9/18/23 by DJ - added ROI labels.


%%
info = GetStoryConstants();
resultsDir = [info.dataDir '/IscResults/Group/'];
% filename = [resultsDir '3dLME_2Grps_readScoreMedSplit_n68_Automask_top-bot_clust_p0.002_a0.05_bisided_report.txt'];
% filename = [resultsDir '3dLME_2Grps_readScoreMedSplit_n40-iqMatched_Automask_top-bot_clust_p0.002_a0.05_bisided_report.txt'];
% filename = [resultsDir '3dLME_2Grps_iqMedSplit_n40-readMatched_Automask_top-bot_clust_p0.002_a0.05_bisided_report.txt'];

% === ISC VERSIONS
% filename = [resultsDir '3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p0.002_a0.05_bisided_report.txt'];
% roiNames = {'Language','lPreCG','lIFG-pOper-pTri','ACC','SMA','lIPL-lSMG','Precun','rPreCG','lMidFG','lSPL-lIPL','lPrecun-lSPL','CerVer','lIFG-pOrb'};
filename = [resultsDir '3dISC_ReadScoreMotionIQ_n40-iqMatched_ReadScore_clust_p0.002_a0.05_bisided_report.txt'];
roiNames = {'lSTG','rSTG','lIOG','lSFG','ACC','rCun','lCun','rIOG','rCalG','rLingG','lSMA','lMidFG','CerVer','lPreCG','rpCun'};
% filename = [resultsDir '3dISC_ReadScoreMotionIQ_n40-iqMatched_IQ_clust_p0.002_a0.05_bisided_report.txt'];

clusterTable = readtable(filename,'FileType','text','CommentStyle','#');
clusterTable.Properties.VariableNames = {'Volume','CM_RL','CM_AP','CM_IS','minRL','maxRL','minAP','maxAP','minIS','maxIS','Mean','SEM','Max_Int','MI_RL','MI_AP','MI_IS'};

clusterTable = clusterTable(:,[1,14,15,16]);
% writetable(clusterTable,'TEMP_TEST')

fprintf('=== INSTRUCTIONS ===\n')
fprintf('Copy the following into Excel, then copy from there into Ppt.\n')
fprintf('This will preserve the column structure.\n')
fprintf('====================\n')

fprintf('Cluster\tLabel\tVolume\tPeak (x,y,z)\n')
for i=1:size(clusterTable,1)
    fprintf('%d\t%s\t%d\t(%g,%g,%g)\n',i,roiNames{i},clusterTable.Volume(i),clusterTable.MI_RL(i),clusterTable.MI_AP(i),clusterTable.MI_IS(i))
end
