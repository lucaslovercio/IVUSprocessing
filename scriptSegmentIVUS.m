close all;
clear all;
clc;
SetValuesIVUSChallengeSetB;
imgRGB = imread('image2.png');
imgCart = imgRGB(:,:,1);

[ imgPolar ] = functionToPolar( imgCart, ParametersSet );
imgPolar = mat2gray(imgPolar);

[ scoreMapLumen, scoreMapBackground ] = functionGetScoreMaps( imgPolar, ParametersSet );

load('RF_SIPAIM.mat');

[ ~,~,predictedBifs,predictedShadow,predictedEP, strFeatures] =...
    functionMarkStructures( double(imgPolar*255), RFBagging, ParametersSet, 4, false);

[ XLI,YLI,XMA,YMA ] = functionSegment(scoreMapLumen, scoreMapBackground,...
    predictedBifs, predictedShadow, predictedEP, true, ParametersSet );

figure, imshow(imgCart);
hold on;
plot(YLI, XLI,'Color',[1 1 0],'LineWidth',2);
plot(YMA, XMA,'Color',[0 1 0],'LineWidth',2);
hold off;