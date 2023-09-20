function PlotReadScoreVsConfounds()

% PlotReadScoreVsConfounds()
% Plots each participant's composite reading score against their IQ, age,
% handedness, and avg. motion. Includes a fit line and significance test.
%
% Created 8/22/19 by DJ.

info = GetStoryConstants();

behTable = readtable(info.behFile);

behTable.readScores = GetStoryReadingScores(behTable.haskinsID);
behTable.subjMotion = GetStorySubjectMotion(behTable.haskinsID);

behTable_cropped = behTable(ismember(behTable.haskinsID,info.okReadSubj),:);

%% Plot results

figure(823); clf;
set(gcf,'Position',[285  195 1000 800]);
subplot(2,2,1);
lm = fitlm(behTable_cropped.readScores,behTable_cropped.WASIVerified__Perf_IQ);
plot(lm);
xlabel('composite reading score')
ylabel('IQ')
title(sprintf('readScore vs. IQ\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('readScore vs. IQ: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

subplot(2,2,2);
lm = fitlm(behTable_cropped.readScores,behTable_cropped.MRIScans__ProfileAge);
plot(lm);
xlabel('composite reading score')
ylabel('age (years)')
title(sprintf('readScore vs. age\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('readScore vs. age: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

subplot(2,2,3);
lm = fitlm(behTable_cropped.readScores,behTable_cropped.EdinburghHandedness__LiQ);
plot(lm);
xlabel('composite reading score')
ylabel(sprintf('Edinburgh Handedness Score\n<--left  | right-->'))
title(sprintf('readScore vs. handedness\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('readScore vs. handedness: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

subplot(2,2,4);
lm = fitlm(behTable_cropped.readScores,behTable_cropped.subjMotion);
plot(lm);
xlabel('composite reading score')
ylabel(sprintf('subject motion\n(mean framewise displacement)'))
title(sprintf('readScore vs. motion\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('readScore vs. motion: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

saveas(gcf,sprintf('%s/Data/readScoreVsConfounds.eps',info.PRJDIR),'epsc')

%% Plot PAIRWISE factors

figure(824); clf;
set(gcf,'Position',[285  195 1000 400]);

% Get pairwise behavioral metrics
nSubj = size(behTable_cropped,1);
[pairwise_readScores, pairwise_iq, pairwise_motion] = deal(nan(nSubj));
for iSubj = 1:nSubj
    for jSubj = iSubj+1:nSubj
        pairwise_readScores(iSubj,jSubj) = behTable_cropped.readScores(iSubj)+behTable_cropped.readScores(jSubj);
        pairwise_iq(iSubj,jSubj) = behTable_cropped.WASIVerified__Perf_IQ(iSubj)+behTable_cropped.WASIVerified__Perf_IQ(jSubj);
        pairwise_motion(iSubj,jSubj) = behTable_cropped.subjMotion(iSubj)+behTable_cropped.subjMotion(jSubj);
    end
end
% get upper triangular part as a 1D vector
pairwise_readScores = pairwise_readScores(~isnan(pairwise_readScores));
pairwise_iq = pairwise_iq(~isnan(pairwise_iq));
pairwise_motion = pairwise_motion(~isnan(pairwise_motion));


% plot
subplot(1,2,1);
lm = fitlm(pairwise_readScores,pairwise_iq);
plot(lm);
xlabel('composite reading score')
ylabel('IQ')
title(sprintf('PAIRWISE readScore vs. IQ\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('PAIRWISE readScore vs. IQ: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

subplot(1,2,2);
lm = fitlm(pairwise_readScores,pairwise_motion);
plot(lm);
xlabel('composite reading score')
ylabel(sprintf('subject motion\n(mean framewise displacement)'))
title(sprintf('PAIRWISE readScore vs. motion\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('PAIRWISE readScore vs. motion: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

saveas(gcf,sprintf('%s/Data/readScoreVsConfounds_pairwise.eps',info.PRJDIR),'epsc')


%%
% figure(824); clf;
% % set(gcf,'Position',[285  195 1000 800]);
% % subplot(2,2,1);
% lm = fitlm(behTable_cropped.readScores,behTable_cropped.Comprehension__PercentageCorrect);
% plot(lm);
% xlabel('composite reading score')
% ylabel(sprintf('WJ3 passage comprehension score'))
% title(sprintf('readScore vs. WJ3 passage comprehension\np=%.3g',lm.Coefficients.pValue(2)))
% fprintf('readScore vs. WJ3 passage comprehension: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));
% 
% saveas(gcf,sprintf('%s/Data/readScoreVsComprehension.eps',info.PRJDIR),'epsc')

%% IQ-MATCHED SAMPLE
behTable_cropped = behTable(ismember(behTable.haskinsID,info.okReadSubj_iqMatched),:);
% Plot results

figure(823); clf;
set(gcf,'Position',[285  195 1000 800]);
subplot(2,2,1);
lm = fitlm(behTable_cropped.readScores,behTable_cropped.WASIVerified__Perf_IQ);
plot(lm);
xlabel('composite reading score')
ylabel('IQ')
title(sprintf('readScore vs. IQ\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('readScore vs. IQ: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

subplot(2,2,2);
lm = fitlm(behTable_cropped.readScores,behTable_cropped.MRIScans__ProfileAge);
plot(lm);
xlabel('composite reading score')
ylabel('age (years)')
title(sprintf('readScore vs. age\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('readScore vs. age: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

subplot(2,2,3);
lm = fitlm(behTable_cropped.readScores,behTable_cropped.EdinburghHandedness__LiQ);
plot(lm);
xlabel('composite reading score')
ylabel(sprintf('Edinburgh Handedness Score\n<--left  | right-->'))
title(sprintf('readScore vs. handedness\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('readScore vs. handedness: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

subplot(2,2,4);
lm = fitlm(behTable_cropped.readScores,behTable_cropped.subjMotion);
plot(lm);
xlabel('composite reading score')
ylabel(sprintf('subject motion\n(mean framewise displacement)'))
title(sprintf('readScore vs. motion\np=%.3g',lm.Coefficients.pValue(2)))
fprintf('readScore vs. motion: r^2 = %.3g, p = %.3g\n',lm.Rsquared.Ordinary,lm.Coefficients.pValue(2));

saveas(gcf,sprintf('%s/Data/readScoreVsConfounds_iqMatched.eps',info.PRJDIR),'epsc')
