function CompareReadScoreAndConfoundIscResults()
% CompareReadScoreAndConfoundIscResults()
%
% Created 7/10/23 by DJ.
% Updated 8/8/23 by DJ - dimensional ISC. Changed name to ...IscResults


%%
info = GetStoryConstants();
resultsDir = sprintf("%s/IscResults/Group/%s",info.dataDir);

% Load reading data
% filename = "3dLME_2Grps_readScoreMedSplit_n68_Automask_top-bot_clust_p0.002_a0.05_bisided_EE.nii.gz";
filename = "3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p0.002_a0.05_bisided_EE.nii.gz";
full_path = sprintf("%s/%s",resultsDir,filename);
temp_path = sprintf("%s/TEMP_readScoreSplit+tlrc",resultsDir);
cmd = sprintf('3dcopy -overwrite %s %s',full_path,temp_path);
fprintf('Running command >> %s...\n',cmd);
system(cmd);
V0 = BrikLoad(temp_path);


confounds = {'iq','motion'};

for iConfound=1:length(confounds)
    confound = confounds{iConfound};

    % Load CLUSTER MASKED motion or IQ data
    % filename = sprintf("3dLME_2Grps_%sMedSplit_n68_Automask_top-bot_clust_p0.002_a0.05_bisided_EE.nii.gz",confound);
    % filename = sprintf("3dLME_2Grps_%sMedSplit_n68_Automask+tlrc",confound);
    filename = sprintf("3dISC_ReadScoreMotionIQ_n68_%s_clust_p0.002_a0.05_bisided_EE.nii.gz",confound);
    full_path = sprintf("%s/%s",resultsDir,filename);
    temp_path = sprintf("%s/TEMP_%sSplit+tlrc",resultsDir,confound);
    cmd = sprintf('3dcopy -overwrite %s %s',full_path,temp_path);
    fprintf('Running command >> %s...\n',cmd);
    system(cmd);
    [err,V1,Info] = BrikLoad(temp_path);
    if length(size(V1))>3
        brick_labs = split(Info.BRICK_LABS);
        isDiff = startsWith(brick_labs,'t~G2-G1~');
        V1 = V1(:,:,:,isDiff);
    end

    % % mask the two
    % mask = (V0~=0) & (V1~=0);
    % V0_masked = V0(mask);
    % V1_masked = V1(mask);
    % 
    % % get correlation between the two
    % [r,p] = corr(V0_masked,V1_masked,'Type','Spearman','tail','right');
    % fprintf('%s: r=%.3g, p=%.3g\n',confound,r,p)

    % Get dice coeff
    dice_coef = dice(V0~=0,V1~=0);
    fprintf('%s: dice = %.3g\n',confound, dice_coef)

    % Get pct of V0 that's in V1
    pct_in_V1 = sum((V0(:)~=0) & (V1(:)~=0))/sum(V0(:)~=0)*100;
    fprintf('%s: pct V0 that is in V1 = %.3g\n',confound, pct_in_V1);

    % Load UNMASKED motion or IQ data
    filename = sprintf("3dLME_2Grps_%sMedSplit_n68_Automask+tlrc",confound);
    full_path = sprintf("%s/%s",resultsDir,filename);    
    [err,V1,Info] = BrikLoad(full_path);
    if length(size(V1))>3
        brick_labs = split(Info.BRICK_LABS);
        isDiff = startsWith(brick_labs,'t~G2-G1~');
        V1 = V1(:,:,:,isDiff);
    end

    mean_V1_in_V0 = mean(V1(V0~=0));
    mean_V1_in_V1 = mean(V1(V1~=0));
    ttest_p = ttest2(V1(V0~=0),V1(V1~=0),'Tail','left');
    fprintf('%s: mean V1(V0~=0) = %.3g, mean V1(V1~=0) = %.3g, p = %.3g\n',confound, mean_V1_in_V0, mean_V1_in_V1, ttest_p);




end


%% Get measures of effect size
% Get 1-grp ISC (with readScore 0)
filename = sprintf("%s/3dISC_ReadScoreMotionIQ_n68_1grp_clust_p0.002_a0.05_bisided_EE.nii.gz",resultsDir);
full_path = sprintf("%s/3dISC_ReadScoreMotionIQ_n68_1grp_clust_p0.002_a0.05_bisided_EE.nii.gz",resultsDir);
temp_path = sprintf("%s/TEMP_readScoreSplit+tlrc",resultsDir);
cmd = sprintf('3dcopy -overwrite %s %s',full_path,temp_path);
system(cmd);
V1grp = BrikLoad(temp_path);
% Get mean significant voxels
V0_sig = V0((V0>0) & (V1grp>0));
V1grp_sig = V1grp((V0>0) & (V1grp>0));
% Print
fprintf('the mean voxel affected by the task and by reading score had:\n');
fprintf(' an ISC of z=%.3g\n',mean(V1grp_sig));
fprintf(' 1std reading score increase raises ISC by z=%.3g to z=%.3g (a %.3g%% increase)\n',mean(V0_sig),mean(V0_sig)+mean(V1grp_sig),mean(V0_sig)/mean(V1grp_sig)*100);
fprintf(' 1std reading score increase raises ISC by %.3g%% (taking %%, then mean)\n',mean(V0_sig./V1grp_sig)*100);
% Plot
figure(354);
clf;
plot(V1grp_sig,V0_sig,'.')
xlabel("1-group ISC (z)");
ylabel("Impact of 1std reading score increase on ISC");