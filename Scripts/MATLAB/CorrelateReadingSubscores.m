function CorrelateReadingSubscores()
% Take all the subscores used to compute the composite reading scores and
% get their correlations with each other.
% 
% Created 

info = GetStoryConstants();

behTable = readtable(info.behFile);

behTable.readScores = GetStoryReadingScores(behTable.haskinsID);

behTable = behTable(ismember(behTable.haskinsID,info.okReadSubj),:);

%% Get correlations

allReadScores = [behTable.TOWREVerified__SWE_SS,behTable.TOWREVerified__PDE_SS,...
    behTable.WoodcockJohnsonVerified__LW_SS, behTable.WoodcockJohnsonVerified__WA_SS];
weightNames = {'TOWRE Sight-Word','TOWRE Phonemic Decoding','WJ3 Letter-Word ID','WJ3 Word Attack'};
[allReadScoreCorrelations, allPVals] = corr(allReadScores,'type','Spearman','tail','right');

%% Plot correlation matrix

figure(12);
clf;
imagesc(allReadScoreCorrelations);
clim([0,1])
colorbar;
xticks(1:4);
yticks(1:4);
xticklabels(show_symbols(weightNames));
yticklabels(show_symbols(weightNames));

disp('P values:')
allPVals(triu(allPVals,1)~=0)
fprintf('Median Spearman corr between subscores: %.3g\n',median(allReadScoreCorrelations(triu(allReadScoreCorrelations,1)~=0)))

