function PlotPairwiseIsc(iscInRoi,roiName)

% get subject numbers
nSubj = size(iscInRoi,1);
nBot = ceil(nSubj/2); % assumes there's not >1 subject with the median score.

% plot pairwise ISC
cla; hold on;
imagesc(iscInRoi);
% plot([nBot,nBot,nSubj,nSubj,nBot]+1.5,[0,nBot,nBot,0,0]-0.5,'g-','LineWidth',2);
plot([0,nBot,nBot,0]+0.5,[0,nBot,0,0]+0.5,'-','color',[112 48 160]/255,'LineWidth',2);
plot([nBot,nSubj,nSubj,nBot]+0.5,[nBot,nSubj,nBot,nBot]+0.5,'r-','LineWidth',2);

% annotate plot
axis square
xlabel(sprintf('better reader-->'))
ylabel(sprintf('participant\nbetter reader-->'))
set(gca,'ydir','normal');
set(gca,'xtick',[],'ytick',[]);
title(roiName)
% Set color limits (by ROI or default)
if ismember(roiName,{'STG (Aud)','lSTG','rSTG'})
    set(gca,'clim',[-.3 .3]);
elseif ismember(roiName,{'CalcGyr (Vis)','rIOG','lIOG','rCalG'})
    set(gca,'clim',[-.25 .25]);
elseif ismember(roiName,{'WholeBrain'})
    set(gca,'clim',[-.01 .01]);
else
    set(gca,'clim',[-.15 .15]);
end
ylim([1 nSubj]-0.5)
xlim([1 nSubj]-0.5)
%     colormap jet
colorbar