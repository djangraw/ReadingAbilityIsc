function Run3dIsc(modelVars,population,centering,isNN,modality)

% get data dir
info = GetStoryConstants();
dataDir = info.dataDir;

% Use model variables
modelPrefix = join(modelVars,'');
model = strcat(join(modelVars,'+'), '+(1|Subj1)+(1|Subj2)');
qVars = join(modelVars,',');

% Build filenames
dataTable = sprintf('StoryPairwiseIscTable_3dISC_%s',population);
prefix = sprintf('%s/IscResults/Group/3dISC_%s_%s',dataDir,modelPrefix,population);
% if NN model, append a suffix to let them know 
if isNN
    dataTable = sprintf('%s_NNmodel',dataTable);
    prefix = sprintf('%s_NNmodel',prefix);
end
% add centering suffix
if ~strcmp(centering, 'population') % population is default and therefore not appended
    dataTable = sprintf('%s_%sCentered',dataTable,centering);
    prefix = sprintf('%s_%sCentered',prefix,centering);
end
if ~strcmp(modality,'all')
    dataTable = sprintf('%s_%s',dataTable,modality);
    prefix = sprintf('%s_%s',prefix,modality);
end
dataTable = sprintf('%s.txt',dataTable);
%dataTable = sprintf('StoryPairwiseIscTable_3dISC_%s_%sCentered.txt',population,centering);

% Write commands to file
cmdFile = 'TEMP_RunIsc.sh';
fid = fopen(cmdFile,'w');

fprintf(fid,'#!/bin/bash \n');
fprintf(fid,'set -e \n');

fprintf(fid,'# Enter Pairwise ISC directory\n');
fprintf(fid,'cd %s/IscResults/Pairwise\n',dataDir);
fprintf(fid,'# Run Group ISC\n');
if strcmp(modality,'aud-vis')
    fprintf(fid,'3dISC -prefix %s -jobs 12 \\\n',prefix); % no -r2z - they're already fisher transformed.
else
    fprintf(fid,'3dISC -prefix %s -jobs 12 -r2z \\\n',prefix);
end
fprintf(fid,'      -mask MNI_mask_epiRes.nii \\\n');
fprintf(fid,'      -model ''%s'' \\\n',model);
fprintf(fid,'      -qVars ''%s'' \\\n',qVars);

% Write GLTs to file
nGlt = length(modelVars)+1;
gltCodes = num2str(eye(nGlt));
fprintf(fid,'      -gltCode ave ''%s'' \\\n',gltCodes(1,:));
for iGlt = 2:nGlt
    fprintf(fid,'      -gltCode %s ''%s'' \\\n',modelVars{iGlt-1},gltCodes(iGlt,:));
end
fprintf(fid,'      -dataTable @%s \n',dataTable);
% Close file
fclose(fid);

%% Run result
cmd = sprintf('bash %s',cmdFile);
fprintf('Running command >> %s...\n',cmd);
% system(cmd);
