%function [r_AnnaK1,r_AnnaK2] = CompareIsRsas(behScoreName1,behScoreName2)

if ~exist("doPlot","var")
    doPlot = false;
end

%% Get behavior scores (from PlotReadingSubscoreHistos.m)

constants = GetStoryConstants();
subjects = constants.okReadSubj;

%% GET BEH SCORES
% read behavior table
behTable = readtable(constants.behFile);
nSubj = length(subjects);
disp('Getting reading scores...')
[readScores, weights,weightNames,IQs,ages] = GetStoryReadingScores(subjects);

% Get other behaviors
if strcmp(behScoreName1,"ReadScore")
    behScore1 = readScores;
else
    behScore1 = zeros(1,nSubj);
    for i = 1:nSubj
        behScore1(i) = behTable.(behScoreName1)(strcmp(behTable.haskinsID,subjects{i}));
    end
end
if strcmp(behScoreName2,"ReadScore")
    behScore2 = readScores;
else
    behScore2 = zeros(1,nSubj);
    for i = 1:nSubj
        behScore2(i) = behTable.(behScoreName2)(strcmp(behTable.haskinsID,subjects{i}));
    end
end

% sort by behScore1
[behScore1,order] = sort(behScore1,'ascend');
behScore2 = behScore2(order);
subj_sorted = subjects(order);

isOk = ~isnan(behScore1) & ~isnan(behScore2);
if any(~isOk)
    behScore1 = behScore1(isOk);
    behScore2 = behScore2(isOk);
    subj_sorted = subj_sorted(isOk);
    fprintf('%d/%d subjects removed for lacking Comprehension score.\n',nSubj-length(behScore2),nSubj);
end

% TODO: In place of behScore_sorted, try each of these other scores that we might
% hypothesize match the function of a certain ROI

%% TODO: Get & Plot "ISC" matrices from behavioral scores
% (i.e., how much does each pair's behavioral profile match?)
disp('Getting behavioral similarity matrices...')
nSubj = length(subj_sorted);
% Anna Karenina model
behSim_AnnaK1 = zeros(nSubj);
for i = 1:nSubj
    for j = 1:nSubj
        behSim_AnnaK1(i,j) = mean(behScore1([i,j]));
    end
end

behSim_AnnaK2 = zeros(nSubj);
for i = 1:nSubj
    for j = 1:nSubj
        behSim_AnnaK2(i,j) = mean(behScore2([i,j]));
    end
end

%% Get ISC in clusters (from GetPairwiseIscInClusters.m)

% Load & name Shen atlas regions
roiMapFile = sprintf('%s/shen_268_epiRes_masked+tlrc.BRIK.gz',constants.dataDir); % all Shen atlas regions
nRoi = 268;
roiIndices = 1:nRoi; % all Shen atlas regions
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

    % sort subjects by their reading score
    [readScore_sorted,order] = sort(readScores,'ascend');
    subj_readsorted = subjects(order); % this is the order of participants (rows/cols) in the file we just loaded

    % fill in lower triangular values for row/col scrambling
    disp('Sorting to match new participant order...')
    iscInRoi_T = permute(iscInRoi,[2,1,3]);
    iscInRoi(isnan(iscInRoi)) = iscInRoi_T(isnan(iscInRoi));
    % Re-sort using new beh score
    fprintf('Re-sorting by %s...\n',behScoreName1)
    [~,order] = ismember(subj_sorted,subj_readsorted);
    iscInRoi = iscInRoi(order,order,:);
else
    % otherwise calculate it
    iscInRoi = GetIscInRoi(subj_sorted,roiBrik,1:nRoi);
    % and save it
    fprintf('Saving ISC to %s...\n',shenIscFile)
    save(shenIscFile,'iscInRoi')
end
% update user
disp('Done!')

%% Match upper triangle of behavioral ISC with upper triangle of each ROI ISC
% This is the "RSA": the similarity between brain and behavior across ppl

disp('Calculating RSA...')
% To get the upper triangular values of a symmetric matrix:
uppertri = triu(ones(size(behSim_AnnaK1)),1); % get a binary mask that's true for values above the diagonal
behSim_AnnaK1_vec = behSim_AnnaK1(uppertri==1)'; % get the upper triangular values of the symmetric matrix, convert to column
behSim_AnnaK2_vec = behSim_AnnaK2(uppertri==1)'; % get the upper triangular values of the symmetric matrix, convert to column
nUpperTri = length(behSim_AnnaK1_vec);
% set up
iscInRoi_vec = zeros(nUpperTri,nRoi);
for iRoi = 1:nRoi
    % To get the upper triangular values of a symmetric matrix:
    iscInRoi_this = iscInRoi(:,:,iRoi);
    iscInRoi_vec(:,iRoi) = iscInRoi_this(uppertri==1); % get the upper triangular values of the symmetric matrix
end

% run spearman corr
r_AnnaK1 = corr(behSim_AnnaK1_vec',iscInRoi_vec,'type','Spearman');
r_AnnaK2 = corr(behSim_AnnaK2_vec',iscInRoi_vec,'type','Spearman');

fprintf('%s: IS-RSA r_s = %.3g\n',behScoreName1,r_AnnaK1(1))
fprintf('%s: IS-RSA r_s = %.3g\n',behScoreName2,r_AnnaK2(1))
disp('Done!')

%% Run Permutation Tests to get statistics
% Shuffle brain-behavior mappings many times to get a null distribution
% Compare actual values to this null distribution
% NOTE: if file exists, it will load it in. So change the filename if you
% change the behavioral similarity matrix.
randPermFile = sprintf('%s/%s-%s_ShenRSA_randPerms_okReadSubj.mat',constants.dataDir,behScoreName1,behScoreName2);
if exist(randPermFile,'file')
    fprintf('Loading %s...\n',randPermFile)
    randPerms = load(randPermFile);
    r_AnnaK1_rand = randPerms.r_AnnaK1_rand;
    r_AnnaK2_rand = randPerms.r_AnnaK2_rand;
else
    % initialize random number generator
    rng('default');
    rng(12345); % use an arbitrary seed of 12345
    % set up
    nRand = 10000;
    [r_AnnaK1_rand, r_AnnaK2_rand] = deal(nan(nRoi,nRand));
    fprintf('Running %d permutations...\n',nRand);
    tic;
    for iRand=1:nRand
        if mod(iRand,1000)==0
            fprintf('Running permutation %d/%d...\n',iRand,nRand);
        end
        % permute both rows and cols (the same way) of behavioral similarity matrices
        thisRand = randperm(nSubj);
        behSim_AnnaK1_rand = behSim_AnnaK1(thisRand,thisRand);
        behSim_AnnaK2_rand = behSim_AnnaK2(thisRand,thisRand);
        % put back into vector form
        behSim_AnnaK1_vec_rand = behSim_AnnaK1_rand(uppertri==1)'; % get the upper triangular values of the symmetric matrix, convert to column
        behSim_AnnaK2_vec_rand = behSim_AnnaK2_rand(uppertri==1)'; % get the upper triangular values of the symmetric matrix, convert to column
        % run spearman corr
        r_AnnaK1_rand(:,iRand) = corr(behSim_AnnaK1_vec_rand',iscInRoi_vec,'type','Spearman')';
        r_AnnaK2_rand(:,iRand) = corr(behSim_AnnaK2_vec_rand',iscInRoi_vec,'type','Spearman')';
    end
    fprintf('Saving as %s...\n',randPermFile)
    save(randPermFile,'r_AnnaK1_rand','r_AnnaK2_rand')
    fprintf('Done! Took %.1f seconds.\n',toc);
end

%% Get statistics from these permutation tests
% what fraction of random r values were greater than actual r values
% (1-sided test)
[p_AnnaK_rand] = nan(1,nRoi);
for iRoi = 1:nRoi
    % calculate for this ROI
    p_AnnaK_rand(iRoi) = mean((r_AnnaK1_rand(iRoi,:)-r_AnnaK2_rand(iRoi,:)) > (r_AnnaK1(iRoi)-r_AnnaK2(iRoi)));    
    
    % print results
    fprintf('%s: p_AnnaK_rand = %.3g\n', roiNames{iRoi}, p_AnnaK_rand(iRoi))
end
p_AnnaK_rand(p_AnnaK_rand>0.5) = 1-p_AnnaK_rand(p_AnnaK_rand>0.5);
p_AnnaK_rand = p_AnnaK_rand * 2; % adjust for 2-sided test?

% FDR-correct
q = 0.05;
[h, crit_p, adj_ci_cvrg, p_AnnaK_rand_fdr] = fdr_bh(p_AnnaK_rand(:),q,'dep','no'); % use 'dep' b/c values are not expected to be independent.
% cap to max 1
p_AnnaK_rand_fdr(p_AnnaK_rand_fdr>1) = 1;
% p_AnnaK_rand_fdr = mafdr(p_AnnaK_rand(:),'bhfdr',true);
% p_NN_rand_fdr = mafdr(p_NN_rand(:),'bhfdr',true);


%% Make AFNI brik with each ROI's values corresponding to its r value and p value
% get bricks with R values and Q values in proper places
outBrik_r = zeros(size(roiBrik));
outBrik_q = zeros(size(roiBrik));
for iRoi = 1:nRoi
    outBrik_r(roiBrik==iRoi) = r_AnnaK1(iRoi)-r_AnnaK2(iRoi);
    outBrik_q(roiBrik==iRoi) = 1-p_AnnaK_rand_fdr(iRoi);
    % outBrik_q(roiBrik==iRoi) = 1-p_AnnaK_rand(iRoi);
end
% combine
outBrik = cat(4,outBrik_r,outBrik_q);
% write to file
outFile = sprintf('%s/IscResults/Group/%s-%s_RSA_AnnaK_shen_268+tlrc',constants.dataDir,behScoreName1,behScoreName2);
% outFile = sprintf('%s/IscResults/Group/%s-%s_RSA_AnnaK_shen_268_PNOTQ+tlrc',constants.dataDir,behScoreName1,behScoreName2);
fprintf('Writing %s...\n',outFile);
Opt = struct('Prefix',outFile,'OverWrite','y');
WriteBrik(outBrik,Info,Opt);
disp('Done!')

%% Turn results into SUMA image montage

resultsDir = sprintf('%s/IscResults/Group',constants.dataDir);
inFile = sprintf('%s-%s_RSA_AnnaK_shen_268+tlrc',behScoreName1,behScoreName2); % brick you want to save
% inFile = sprintf('%s-%s_RSA_AnnaK_shen_268_PNOTQ+tlrc',behScoreName1,behScoreName2); % brick you want to save

% make SUMA montage with q=0.05 cutoff
outFile = sprintf('SUMA_IMAGES_2022/suma_8view_%s-%s_RSA_AnnaK_shen_268_lim0.1_q0.05.jpg',behScoreName1,behScoreName2);
% outFile = sprintf('SUMA_IMAGES_2022/suma_8view_%s-%s_RSA_AnnaK_shen_268_lim0.1_p0.05.jpg',behScoreName1,behScoreName2);
SetUpSumaMontage_8view(resultsDir,'TEMP_RSA_AnnaK.tcsh','MNI152_2009_SurfVol.nii',...
    inFile,'suma_MNI152_2009/MNI152_2009_both.spec','MNI152_2009_SurfVol.nii',...
    0,1,'./SUMA_IMAGES_2022','',outFile,[],0.1,0.95,'');

