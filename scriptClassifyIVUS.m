close all;
clear all;
clc;
SetValuesIVUSChallengeSetB;
imgRGB = imread('image1.png');
imgCart = imgRGB(:,:,1);

[ imgPolar ] = functionToPolar( imgCart, ParametersSet );
imgPolar = mat2gray(imgPolar);

[ scoreMapLumen, scoreMapBackground ] = functionGetScoreMaps( imgPolar, ParametersSet );

load('RF_SIPAIM.mat');

[ ~,~,predictedBifs,predictedShadow,predictedEP, strFeatures] =...
    functionMarkStructures( double(imgPolar*255), RFBagging, ParametersSet, 4, false);