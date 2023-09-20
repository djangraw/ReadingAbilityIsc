% CopyA182Data_v2.m
%
% Take data from subjects included in the Reading Ability ISC
% analysis and copy to the appropriate new folders.
%
% Created 1/4/19 by DJ.
% Updated 3/2/23 by DJ - new directory structure.
% Updated 3/17/23 by DJ - removed extra copy of brain.nii

%% Read behavior spreadsheet
info = GetStoryConstants;
behFile = [info.dataDir '/A182IncludedSubjectBehavior_2023-02-28.xlsx'];

behData = readtable(behFile);

%% For each subject, create a new folder and move the anat, story, and fastloc data into it
basedir = info.dataDir; % transfer TO
transferdir = '/Volumes/DJ_Transfer/a182_v2/a182_ALLH'; % transfer FROM
freesurferDir = '/Users/djangraw/Documents/Research/HaskinsReadingIsc/Data/freesurfer'; % transfer FROM
nSubj = size(behData,1);
fprintf('Making freesurfer directory...')
fprintf('Copying data for %d subjects...\n',nSubj);
tic;
for i=1:nSubj
    fprintf('subject %d/%d (%s)...\n',i,nSubj,behData.haskinsID{i})
    % Make directories
    mkdir(basedir,behData.haskinsID{i});    
    cd(sprintf('%s/%s',basedir,behData.haskinsID{i}));
    mkdir('stim_times');
    mkdir('anat');
    mkdir('freesurfer');
    % document this
%     fid = fopen(sprintf('%s.history.txt',behData.haskinsID{i}),'w');
%     fprintf(fid,'mkdir(%s,%s);\n',basedir,behData.haskinsID{i});
%     fprintf(fid,'cd(''%s/%s'');\n',basedir,behData.haskinsID{i});
%     fprintf(fid,'mkdir(''stim_times'');\n');
%     fprintf(fid,'mkdir(''anat'');\n');
%     fprintf(fid,'mkdir(''freesurfer'');\n');
    % copy data into this folder
    copyfile(sprintf('%s/%s/SUMA/brain.nii',freesurferDir,behData.haskinsID{i}),'anat');
    copyfile(sprintf('%s/%s/SUMA/aparc.a2009s+aseg_rank.nii',freesurferDir,behData.haskinsID{i}),'freesurfer');
    copyfile(sprintf('%s/%s/SUMA/FSmask_vent.nii',freesurferDir,behData.haskinsID{i}),'freesurfer');
    copyfile(sprintf('%s/%s/SUMA/FSmask_WM.nii',freesurferDir,behData.haskinsID{i}),'freesurfer');
%     try
%         copyfile(sprintf('%s/%s/anat/Sag3DMPRAGE*',transferdir,behData.haskinsID{i}),'anat')
%         fprintf(fid,'copyfile(''%s/%s/Sag3DMPRAGE*'',''anat'');\n',transferdir,behData.haskinsID{i});
%     catch
%         fprintf('  Anat not found in haskinsID folder. Copying from rest folder instead.\n')
%         copyfile(sprintf('%s/%s/Sag3DMPRAGE*',transferdir,behData.restID{i}),'anat')
%         fprintf(fid,'copyfile(''%s/%s/Sag3DMPRAGE*'',''anat'');\n',transferdir,behData.restID{i});
%     end
    copyfile(sprintf('%s/%s/func_story',transferdir,behData.haskinsID{i}),'func_story')
    copyfile(sprintf('%s/%s/stim_times/stim_times_story',transferdir,behData.haskinsID{i}),'stim_times/stim_times_story')
% 
%     fprintf(fid,'copyfile(''%s/%s/func_story'',''func_story'');\n',transferdir,behData.haskinsID{i});
%     fprintf(fid,'copyfile(''%s/%s/stim_times/stim_times_story'',''stim_times/stim_times_story'');\n',transferdir,behData.haskinsID{i});
%     fclose(fid);
end
fprintf('Done! Took %.1f seconds.\n',toc);

%% do quality check
isBad = false(1,nSubj);
for i=1:nSubj
    fprintf('subject %d/%d (%s)...\n',i,nSubj,behData.haskinsID{i})
    cd(sprintf('%s/%s',basedir,behData.haskinsID{i}));
    if length(dir('anat'))<1
        disp("no anat")
    end
    if length(dir('func_story'))<2
        disp("missing story data")
        isBad(i) = true;
    end
    if length(dir('stim_times'))<2
        disp("missing stim times")
        isBad(i) = true;
    end
end
fprintf('%d/%d subjects ok.\n',sum(~isBad),nSubj)
