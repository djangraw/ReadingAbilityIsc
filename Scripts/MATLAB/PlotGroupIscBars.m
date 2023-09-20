function PlotGroupIscBars(iscInRoi,roiName,pTTmTB,pTBmBB,pTTmBB)

% split in half
nSubj = size(iscInRoi,1);
nBot = ceil(nSubj/2);
isTop = 1:nSubj>nBot;
isBot = ~isTop;

% Get means
iscInRoi_z = atanh(iscInRoi);
meanTopTop_r = tanh(squeeze(nanmean(nanmean(iscInRoi_z(isTop,isTop),1),2)));
meanTopBot_r = tanh(squeeze(nanmean(nanmean(iscInRoi_z(isBot,isTop),1),2)));
meanBotBot_r = tanh(squeeze(nanmean(nanmean(iscInRoi_z(isBot,isBot),1),2)));

% Make bars
cla; hold on;
bar(1,meanTopTop_r,'r');
bar(2,meanTopBot_r,'y');%'faceColor',[184 24 80]/255);
bar(3,meanBotBot_r,'faceColor',[112 48 160]/255);
%     errorbar([meanTopTop_r(iRoi),meanTopBot_r(iRoi),meanBotBot_r(iRoi)], [steTopTop(iRoi),steTopBot(iRoi),steBotBot(iRoi)],'k.');
% Add stars
if pTTmTB<0.05
    plot([1,1,2,2],[0,0.01,0.01,0]+(meanTopTop_r+0.01),'k-');
    plot(1.5,meanTopTop_r+0.03,'k*');
end
if pTBmBB<0.05
    plot([2,2,3,3],[0,0.01,0.01,0]+(meanTopBot_r+0.01),'k-');
    plot(2.5,meanTopBot_r+0.03,'k*');
end
if pTTmBB<0.05
    plot([1,1,3,3],[0,0.01,0.01,0]+(meanTopTop_r+0.03),'k-');
    plot(2,meanTopTop_r+0.05,'k*');
end
% Annotate plot
set(gca,'xtick',1:3,'xticklabels',{'good','mixed','poor'});
xlabel('Reader Pair Type');
ylabel('ISC in ROI');
title(roiName);
% set color limits differently if it's an auditory area
if ismember(roiName,{'STG (Aud)','lSTG','rSTG'})
    ylim([0,0.3])
else
    ylim([0,0.18]);
end
grid on;