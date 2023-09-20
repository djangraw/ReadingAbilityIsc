% function MakeRoiMaps(regions,shorthands,clusterMap)

% Created 8/10/23 by DJ.

info = GetStoryConstants;
dataDir = info.dataDir;

regions = {'Left_Superior_Temporal_Gyrus','Left_Middle_Temporal_Gyrus','Left_Angular_Gyrus', ...
    'Left_Supramarginal_Gyrus','Left_Fusiform_Gyrus','Left_Inferior_Temporal_Gyrus', ...
    'Left_Inferior_Frontal_Gyrus_(p._Opercularis)','Left_Inferior_Frontal_Gyrus_(p._Triangularis)','Left_Inferior_Frontal_Gyrus_(p._Orbitalis)',};
shorthands = {'lSTG','lMTG','lAG','lSMG','lFusG','lITG','lIFG-pOpe','lIFG-pTri','lIFG-pOrb'};
clusterMap = sprintf('%s/IscResults/Group/3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p0.002_a0.05_bisided_map.nii.gz',dataDir);% cluster file whose overlap with ROIs you want to find
olapClusterMap = sprintf('%s/IscResults/Group/3dISC_ReadScoreMotionIQ_n68_ReadScore_clust_p0.002_a0.05_bisided_roioverlap_map.nii.gz',dataDir);

% open script
filename = 'TEMP_MakeRoiMaps.sh';
fid = fopen(filename,'w');
fprintf(fid,'#!/bin/bash\n')
fprintf(fid,'set -e\n')

for iRegion=1:length(regions)
    region = regions{iRegion};
    shorthand = shorthands{iRegion};
    prefix = sprintf('%s/atlasRois/atlas_%s',dataDir,shorthand);
    fprintf(fid, 'whereami -mask_atlas_region ''CA_ML_18_MNI::%s'' -prefix %s -overwrite\n',region,prefix); % get atlas region
    fprintf(fid, '3dresample -inset %s+tlrc -master %s -prefix %s_epiRes -overwrite\n',prefix,clusterMap,prefix); % resample to EPI resolution
    fprintf(fid, '3dcalc -a %s_epiRes+tlrc -b %s -prefix %s_epiRes_olap -expr ''step(a)*step(b)'' -overwrite\n',prefix,clusterMap,prefix); % resample to EPI resolution
    fprintf(fid,'rm %s+tlrc.* %s_epiRes+tlrc.*\n',prefix,prefix); % remove temporary files
    if iRegion == 1
        fprintf(fid, '3dcopy %s_epiRes_olap+tlrc %s -overwrite\n',prefix,olapClusterMap); % resample to EPI resolution
    else
        fprintf(fid, '3dcalc -a %s -b %s_epiRes_olap+tlrc -prefix %s -expr ''a+%d*b'' -overwrite\n',olapClusterMap,prefix,olapClusterMap,iRegion); % resample to EPI resolution    
    end
    fprintf(fid,'echo ''ROI %d (%s) voxel count:''\n',iRegion,shorthand);
    fprintf(fid,'3dBrickStat -count -non-zero %s_epiRes_olap+tlrc\n\n',prefix);

end

% clean up
fclose(fid);
cmd = sprintf('bash %s',filename);
fprintf('run in terminal: >> %s\n',cmd);
% system(cmd);