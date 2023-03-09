function info = GetStoryConstants()

% Created 5/15/18 by DJ.
% Updated 2/5/19 by DJ.
% Updated 8/21/19 by DJ - removed subject h1161, who saw 2nd run twice.
% Updated 8/22/19 by DJ - added behFile
% Updated 5/4-19/22 by DJ - added UVM computer file locations
% Updated 5/23/22 by DJ - updated behFile
% Updated 5/26/22 by DJ - made it work off campus, and finds behFile in
% PRJDIR if dataDir is not attached.
% Updated 3/2/23 by DJ - new directory structure
% Updated 3/9/23 by DJ - new beh file

% set PRJDIR to the location of this file's parent's parent directory
scriptPath = mfilename('fullpath');
pathParts = split(scriptPath,'/');
newPath = join(pathParts(1:end-3),'/');
newPath = newPath{1};
info.PRJDIR = newPath; % overall project directory
info.dataDir = [info.PRJDIR '/Data/']; % data directory

% Constants
info.nT = 360; % across all runs

% all subjects with any data in the directory (n=75)
info.subjects = {'h1002' 'h1003' 'h1004' 'h1005' 'h1007' 'h1010' ...
    'h1011' 'h1012' 'h1013' 'h1014' 'h1016' 'h1018' 'h1022' 'h1024' ...
    'h1027' 'h1028' 'h1029' 'h1031' 'h1034' 'h1035' 'h1036' 'h1038' ...
    'h1040' 'h1043' 'h1046' 'h1048' 'h1050' 'h1054' 'h1057' 'h1058' ...
    'h1059' 'h1061' 'h1068' 'h1073' 'h1074' 'h1076' 'h1082' 'h1083' ...
    'h1087' 'h1088' 'h1093' 'h1095' 'h1096' 'h1097' 'h1098' 'h1102' ...
    'h1106' 'h1108' 'h1113' 'h1118' 'h1120' 'h1129' 'h1142' 'h1146' ...
    'h1150' 'h1152' 'h1153' 'h1154' 'h1157' 'h1161' 'h1163' 'h1167' ...
    'h1168' 'h1169' 'h1174' 'h1175' 'h1176' 'h1179' 'h1180' 'h1184' ...
    'h1185' 'h1186' 'h1187' 'h1189' 'h1197'};

% subjects where initial afniproc ran to completion AND <15% TRs censored (n=69) .
info.okSubj = {'h1002' 'h1003' 'h1004' 'h1010' ...
    'h1011' 'h1012' 'h1013' 'h1014' 'h1016' 'h1018' 'h1022' 'h1024' ...
    'h1027' 'h1028' 'h1029' 'h1031' 'h1034' 'h1035' 'h1036' 'h1038' ...
    'h1043' 'h1046' 'h1048' 'h1054' 'h1057' 'h1058' ...
    'h1059' 'h1061' 'h1073' 'h1074' 'h1076' 'h1082' 'h1083' ...
    'h1087' 'h1088' 'h1093' 'h1095' 'h1096' 'h1097' 'h1098' 'h1102' ...
    'h1106' 'h1108' 'h1118' 'h1120' 'h1129' 'h1142' 'h1146' ...
    'h1150' 'h1152' 'h1153' 'h1154' 'h1157' 'h1163' 'h1167' ...
    'h1168' 'h1169' 'h1174' 'h1175' 'h1176' 'h1179' 'h1180' 'h1184' ...
    'h1185' 'h1186' 'h1187' 'h1189' 'h1197'};

% subjects with both behavioral (all reading scores) and valid fMRI data AND <15% TRs censored.
info.okReadSubj = {'h1002' 'h1003' 'h1004' 'h1010' ...
    'h1011' 'h1012' 'h1013' 'h1014' 'h1016' 'h1018' 'h1022' 'h1024' ...
    'h1027' 'h1028' 'h1029' 'h1031' 'h1034' 'h1035' 'h1036' 'h1038' ...
    'h1043' 'h1046' 'h1048' 'h1054' 'h1057' 'h1058' ...
    'h1059' 'h1061' 'h1073' 'h1074' 'h1076' 'h1082' 'h1083' ...
    'h1087' 'h1088' 'h1093' 'h1095' 'h1096' 'h1097' 'h1098' 'h1102' ...
    'h1106' 'h1108' 'h1118' 'h1120' 'h1129' 'h1142' 'h1146' ...
    'h1150' 'h1152' 'h1153' 'h1154' 'h1157' 'h1163' 'h1167' ...
    'h1168' 'h1169' 'h1174' 'h1175' 'h1176' 'h1179' 'h1180' 'h1184' ...
    'h1185' 'h1186' 'h1187' 'h1189' 'h1197'};

% Subset of 40 Subjects chosen for 'matched' IQ between top & bottom reading groups
info.okReadSubj_iqMatched = {'h1003' 'h1004' 'h1010' 'h1011' 'h1012' ...
    'h1013' 'h1014' 'h1024' 'h1027' 'h1029' 'h1034' 'h1035' 'h1036' ...
    'h1046' 'h1048' 'h1058' 'h1061' 'h1076' 'h1082' 'h1083' 'h1088' ...
    'h1097' 'h1098' 'h1102' 'h1108' 'h1120' 'h1129' 'h1142' 'h1150' ...
    'h1152' 'h1168' 'h1169' 'h1174' 'h1175' 'h1179' 'h1185' 'h1186' ...
    'h1187' 'h1189' 'h1197'};

% Get behavior file
% info.behFile = [info.PRJDIR '/A182IncludedSubjectBehavior_2019-01-04.xlsx'];
if exist(info.dataDir,'dir')
    info.behFile = [info.dataDir '/A182IncludedSubjectBehavior_2023-02-28.xlsx'];
else
    info.behFile = [info.PRJDIR '/A182IncludedSubjectBehavior_2023-02-28.xlsx'];
end

% Add afni directory to PATH
PATH = getenv('PATH');
% Add imagemagick directory to PATH
if ~contains(PATH,'local')
    setenv('PATH', [PATH ':/usr/local/bin/']);
end
if ~contains(PATH,'abin')
    username = char(java.lang.System.getProperty('user.name'));
    setenv('PATH', [PATH ':/Users/' username '/abin']);
end
