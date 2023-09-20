function [meanXY,stdXY] = CombinedMeanAndStd(meanX,stdX,nX,meanY,stdY,nY)

% calculate means
meanXY = (meanX.*nX + meanY.*nY) ./ (nX+nY);

% convert std devs to variances
varX = stdX.^2;
varY = stdY.^2;

% Calculate new variance using formula from here: https://math.stackexchange.com/a/2971563
varXY = ((nX-1).*varX + (nY-1).*varY) ./ (nX + nY -1) + nX.*nY.*(meanX - meanY).^2 ./ ((nX+nY).*(nX+nY-1));
stdXY = sqrt(varXY);

