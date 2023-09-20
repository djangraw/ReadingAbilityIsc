% PlotReadingSubscoreHistos.m
% Plot histograms of each reading subscore or relevant trait, grouped by reading ability.
%
% Created pre-2023 by DJ.
% Updated 3/2/23 by DJ - header.
% Updated 5/2/23 by DJ - only reading scores used in PCA, use_iq_matched option,
%   print stats by group, print table.
% Updated 7/10/23 by DJ - Convert Handedness to LQ by /24 (max possible)
%   *100%. Switched to cutoff of -50% to be considered left-handed.
% Updated 8/4/23 by DJ - switched to 1 group (dimensional analysis)
% Updated 9/18/23 by DJ - added range to 1-group table

% decide whether to use iq-matched subset of subjects
use_iq_matched = false;
lefty_cutoff = -40; % LQ below this value will be considered left-handed.
split_groups = false; % median split into good and poor readers

info = GetStoryConstants();
if use_iq_matched
    subjects = info.okReadSubj_iqMatched;
else
    subjects = info.okReadSubj;
end
% get standard reading scores
[readScores, weights,weightNames,IQs,ages] = GetStoryReadingScores(subjects);

% Read behavior file
behTable = readtable(info.behFile);

%% Use all subjects to get first PC
% Append all reading scores
% allReadScores = [behTable.TOWREVerified__SWE_SS,behTable.TOWREVerified__PDE_SS,behTable.TOWREVerified__TWRE_SS,...
%     behTable.WoodcockJohnsonVerified__BscR_SS, behTable.WoodcockJohnsonVerified__LW_SS, behTable.WoodcockJohnsonVerified__WA_SS,...
%     behTable.WASIVerified__Perf_IQ,behTable.EdinburghHandedness__LiQ,behTable.MRIScans__ProfileAge,strcmp(behTable.gender,'Male')];
% weightNames = {'TOWRE Sight-Word','TOWRE Phonemic Decoding','TOWRE Total Word Reading','WJ3 Basic Reading','WJ3 Letter-Word ID','WJ3 Word Attack','WASI Performance IQ','Edinburgh Handedness LiQ','Age (years)','GenderIsMale'};
allReadScores = [behTable.TOWREVerified__SWE_SS,behTable.TOWREVerified__PDE_SS,...
    behTable.WoodcockJohnsonVerified__LW_SS, behTable.WoodcockJohnsonVerified__WA_SS,...
    behTable.WASIVerified__Perf_IQ,behTable.EdinburghHandedness__LiQ / 24*100 ,behTable.MRIScans__ProfileAge,strcmp(behTable.gender,'Male')];
weightNames = {'TOWRE Sight-Word','TOWRE Phonemic Decoding','WJ3 Letter-Word ID','WJ3 Word Attack','WASI Performance IQ','Edinburgh Handedness LQ (%)','Age (years)','GenderIsMale'};
nReadingScores = sum(startsWith(weightNames,'TOWRE') | startsWith(weightNames,'WJ3'));
isOkSubj = all(~isnan(allReadScores),2);

%% Reorder
readSubj = behTable.haskinsID;
readSubscores = nan(numel(subjects),size(allReadScores,2));
for i=1:numel(subjects)
    readSubscores(i,:) = allReadScores(strcmp(readSubj,subjects{i}),:);
end

%% Plot
figure(521); clf;
set(gcf,'Position',[70 297 738 374]);
readHistEdges = linspace(min(min(readSubscores(:,1:nReadingScores))),max(max(readSubscores(:,1:nReadingScores))),20);
isTop = readScores > median(readScores);
colors = {[1 0 0],[112 48 160]/255};
nTests = size(readSubscores,2);
for i=1:(nTests-1) % -1 for gender
    if i<=nReadingScores
        subplot(3,2,i);
        histEdges = readHistEdges;
    else
        subplot(3,3,i+2);
        histEdges = linspace(min(readSubscores(:,i)),max(readSubscores(:,i)),20);
    end
    if split_groups
        nTop = histcounts(readSubscores(isTop,i),histEdges);
        nBot = histcounts(readSubscores(~isTop,i),histEdges);
        ctrs = (histEdges(1:end-1)+histEdges(2:end))/2; % Calculate the bin centers
        hBar = bar(ctrs, [nBot' nTop'],1,'stacked');
        set(hBar(1),'FaceColor',colors{1});
        set(hBar(1),'FaceColor',colors{2});
    else
        nAll = histcounts(readSubscores(:,i),histEdges);        
        ctrs = (histEdges(1:end-1)+histEdges(2:end))/2; % Calculate the bin centers
        hBar = bar(ctrs, nAll',1,'stacked');
        set(hBar(1),'FaceColor',[0.5 0.5 0.5]);        
    end
    xlabel(weightNames{i},'interpreter','none');
    ylabel('participants');
end
if split_groups
    legend('poor readers','good readers','location','northwest');
end

if use_iq_matched
    MakeFigureTitle('Behavioral Test Distributions (IQ-matched)');
    saveas(gcf,sprintf('%s/ReadingSubtestDistributions_iqMatched.svg',info.dataDir));
else
    MakeFigureTitle('Behavioral Test Distributions');
    saveas(gcf,sprintf('%s/ReadingSubtestDistributions.svg',info.dataDir));
end

%% Print mean, std, range of each
fprintf('========================\n');
if use_iq_matched
    fprintf('====IQ-matched sample===\n');
else
    fprintf('====Unmatched sample====\n');
end
fprintf('========================\n');
fprintf('Test: mean ± std, range min-max\n');
for i=1:nTests
    fprintf('%s ALL: %.0f ± %.0f, range %.0f-%.0f\n',...
        weightNames{i},nanmean(readSubscores(:,i)),nanstd(readSubscores(:,i)),...
        min(readSubscores(:,i)),max(readSubscores(:,i)));
    if split_groups
        fprintf('%s TOP: %.0f ± %.0f, range %.0f-%.0f\n',...
            weightNames{i},nanmean(readSubscores(isTop,i)),nanstd(readSubscores(isTop,i)),...
            min(readSubscores(isTop,i)),max(readSubscores(isTop,i)));
        fprintf('%s BOTTOM: %.0f ± %.0f, range %.0f-%.0f\n',...
            weightNames{i},nanmean(readSubscores(~isTop,i)),nanstd(readSubscores(~isTop,i)),...
            min(readSubscores(~isTop,i)),max(readSubscores(~isTop,i)));
        % test good-poor
        [p,h] = ranksum(readSubscores(~isTop,i),readSubscores(isTop,i));
        fprintf('   top>bot: p=%.3g\n',p)
    end
end
fprintf('========================\n');

%% Print mean, std of each score/demographic in MS Word table form
fprintf('========================\n');
if use_iq_matched
    fprintf('====IQ-matched sample===\n');
else
    fprintf('====Unmatched sample====\n');
end
fprintf('========================\n');
if split_groups
    fprintf('Subtest\tM (SD)good\tM (SD)poor\n');
    % print subtest scores
    for i=1:nTests
        if strcmp(weightNames{i}, 'Edinburgh Handedness LQ (%)')
            continue
        elseif strcmp(weightNames{i}, 'GenderIsMale')
            continue
        else
            fprintf('%s\t%.3g (%.3g)\t%.3g (%.3g)\n',...
                weightNames{i},nanmean(readSubscores(isTop,i)),nanstd(readSubscores(isTop,i)),...
                nanmean(readSubscores(~isTop,i)),nanstd(readSubscores(~isTop,i)));
        end
    end
    % print demographics
    fprintf('Demographic\tN (%%)good\tN (%%)poor\n');
    i = find(strcmp(weightNames,'GenderIsMale'));
    fprintf('%s\t%.0f (%.1f%%)\t%.0f (%.1f%%)\n',...
        'Male',nansum(readSubscores(isTop,i)),nanmean(readSubscores(isTop,i))*100,...
        nansum(readSubscores(~isTop,i)),nanmean(readSubscores(~isTop,i))*100);
    i = find(strcmp(weightNames,'Edinburgh Handedness LQ (%)'));
    fprintf('%s\t%.0f (%.1f%%)\t%.0f (%.1f%%)\n',...
        'Left-Handed',nansum(readSubscores(isTop,i)<lefty_cutoff),nanmean(readSubscores(isTop,i)<lefty_cutoff)*100,...
        nansum(readSubscores(~isTop,i)<lefty_cutoff),nanmean(readSubscores(~isTop,i)<lefty_cutoff)*100);
else
    % print subtest scores
    fprintf('Subtest\tM (SD)\tRange\n');
    for i=1:nTests
        if strcmp(weightNames{i}, 'Edinburgh Handedness LQ (%)')
            continue
        elseif strcmp(weightNames{i}, 'GenderIsMale')
            continue
        else
            fprintf('%s\t%.3g (%.3g)\t%.3g-%.3g\n',...
                weightNames{i},nanmean(readSubscores(:,i)),nanstd(readSubscores(:,i)),nanmin(readSubscores(:,i)),nanmax(readSubscores(:,i)));
        end
    end
    % print demographics
    fprintf('Demographic\tN (%%)\n');
    i = find(strcmp(weightNames,'GenderIsMale'));
    fprintf('%s\t%.0f (%.1f%%)\n',...
        'Male',nansum(readSubscores(:,i)),nanmean(readSubscores(:,i))*100);
    i = find(strcmp(weightNames,'Edinburgh Handedness LQ (%)'));
    fprintf('%s\t%.0f (%.1f%%)\n',...
        'Left-Handed',nansum(readSubscores(:,i)<lefty_cutoff),nanmean(readSubscores(:,i)<lefty_cutoff)*100);
end

fprintf('========================\n');
