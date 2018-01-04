function [ gradientCol, gradienteAnt,...
    gradientePosterior,maxGradienteAbs, maxGradienteAbsScaled, normalizedCantPositivosCol ] =...
    functionPositiveClassProfile( mapScores, grayscaleInput, th )

[h,w] = size(mapScores);

if not(grayscaleInput)
mapScoresPositive = mapScores>0;
else
    mapScoresPositive = mapScores>th;
end

cantPositivosCol = sum(horzcat(mapScoresPositive,mapScoresPositive,...
    mapScoresPositive));

cantPositivosColMedian = medfilt1(cantPositivosCol,19); %Erase extreme values

%smooth the curve
sigma = 9;
sizeG = 70;
x = linspace(-sizeG / 2, sizeG / 2, sizeG);
gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
gaussFilter = gaussFilter / sum (gaussFilter);
cantPositivosColFiltered = conv (cantPositivosColMedian, gaussFilter, 'same');

%Derivo
cantPositivosColFilteredDerivada = cantPositivosColFiltered - circshift(cantPositivosColFiltered,[0 2]);

%Las puntas son un problema
cantPositivosColFilteredDerivada(1:2)=0; cantPositivosColFilteredDerivada((3*w-2):3*w)=0;

distanceToStartOrFinishOfFeature = 4;

gradientCol = cantPositivosColFilteredDerivada(:,w+1:2*w);
gradienteAnt = circshift(gradientCol,[0 distanceToStartOrFinishOfFeature]);
gradientePosterior = circshift(gradientCol,[0 -distanceToStartOrFinishOfFeature]);

maxGradienteAbs = max([abs(gradientCol);abs(gradienteAnt);abs(gradientePosterior)]);

maxGradienteAbsScaled = (maxGradienteAbs-mean(maxGradienteAbs))/std(maxGradienteAbs);

%Inspired by Unal2008
cantPositivosColMedian = cantPositivosColMedian(:,w+1:2*w);
normalizedCantPositivosCol =...
    (cantPositivosColMedian - mean(cantPositivosColMedian))./std(cantPositivosColMedian);

end

