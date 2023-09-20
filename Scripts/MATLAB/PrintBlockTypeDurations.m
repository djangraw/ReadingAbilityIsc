% PrintBlockTypeDurations.m
%
% Print durations of each block type for reporting in the Haskins Reading ISC paper.
%
% Created 7/11/22 by DJ.

% From RunStoryPairwiseIscSwarm_VisAud.sh:
% 3dTcat -overwrite -prefix $visOut $fileIn'[35..54, 93..117, 248..268, 305..327]' # in samples, with onsets delayed 12s for HRF ramp-up
% 3dTcat -overwrite -prefix $audOut $fileIn'[60..87, 123..148, 216..242, 274..299]' # in samples, with onsets delayed 12s for HRF ramp-up
% 3dTcat -overwrite -prefix $transOut $fileIn'[30..34, 55..59, 88..92, 118..122, 149..153, 211..215, 243..247, 269..273, 300..304, 328..332]' # in samples, 2-10s after block offset

% Calculate total times from the TRs used above
TR = 2;
durVis = (54-35 + 117-93 + 268-248 + 327-305 + 4)*TR; % +4 for inclusive
durAud = (87-60 + 148-123 + 242-216 + 299-274 + 4)*TR; % +4 for inclusive
durTrans = (34-30 + 59-55 + 92-88 + 122-118 + 153-149 + 215-211 + 247-243 + 273-269 + 304-300 + 332-328 + 10)*TR; % +10 for inclusive
% Report results in both seconds and TRs
fprintf('durVis = %d s (%d TRs)\ndurAud = %d s (%d TRs)\ndurTrans = %d s (%d TRs)\n',durVis,durVis/TR,durAud, durAud/TR, durTrans, durTrans/TR)

% For figure, plot times of actual starts (NO ramp-up delays)
tVis = [35, 54; 93, 117; 248, 268; 305, 327]*TR;
tVis(:,1) = tVis(:,1)-12; % subtract ramp-up delays
tAud = [60, 87; 123, 148; 216, 242; 274, 299]*TR;
tAud(:,1) = tAud(:,1)-12; % subtract ramp-up delays
runDur = 360; % duration of 372s scan after removing first 6 TRs
figure(6);
set(gcf,'position',[-348 1601 731 253])
clf;
axis([-20,runDur+20,0.2,2.2])
hold on;
xlabel('time (s)')
ylabel('run')
set(gca,'ydir','reverse','ytick',[1,2])
grid on
plot([0,runDur,nan,0,runDur],[1,1,nan,2,2],'k.-')
width = 20;
for iBlock = 1:size(tVis,1)
    if tVis(iBlock,1)<runDur
        plot(tVis(iBlock,:),[1,1],'linewidth',width,'color','c')
        plot(tAud(iBlock,:),[1,1],'linewidth',width,'color','m')
    else
        plot(tVis(iBlock,:)-runDur,[2,2],'linewidth',width,'color','c')
        plot(tAud(iBlock,:)-runDur,[2,2],'linewidth',width,'color','m')
    end
end
legend('Baseline','Visual','Auditory')
