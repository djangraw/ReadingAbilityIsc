% RunRoiIscVsBehaviorRsaInLoop.m
%
% Run IS-RSA analysis with each of the reading & behavior subscores individually
%
% Created pre-2023 by DJ.
% Updated 3/2/23 by DJ - added ReadScore, header, comments

% Declare subscores and other behavioral metrics of interest
subscores = {"ReadScore", "TOWREVerified__SWE_SS","TOWREVerified__PDE_SS","WoodcockJohnsonVerified__LW_SS", "WoodcockJohnsonVerified__WA_SS","WASIVerified__Perf_IQ","MRIScans__ProfileAge"};

% run in a loop
for iSubscore = 1:length(subscores)
    behScoreName = subscores{iSubscore};
    RunRoiIscVsBehaviorRsa;
end
