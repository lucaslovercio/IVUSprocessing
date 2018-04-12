function [ imgPolarMarkedContext,imgCartMarkedContext,...
    predictedBifsContext,predictedShadowContext,predictedEPContext, strFeatures] =...
    functionMarkStructures( polarOriginalImage, BaggedEnsemble, ParametersSet, nClasses, markEdgesStructures )

[featureVector,strFeatures,~] =...
    functionFeatureVectorColGray( polarOriginalImage );
polarOriginalImage = polarOriginalImage/255;

[ ~, predictionTestScore ] =...
    functionPredictRFBagging( BaggedEnsemble, featureVector,...
    100, ParametersSet.widthPolar, nClasses );

[ labelsImgOut ] = functionContextScoresRF( predictionTestScore, ParametersSet, 2 );
predictedBifsContext = double(labelsImgOut==1);% 1 Bifurcation
predictedBifsContext(predictedBifsContext<=0) = -1;
predictedShadowContext = double(labelsImgOut==2); % 2 Shadow
predictedShadowContext(predictedShadowContext<=0) = -1;
predictedEPContext = double(labelsImgOut==3); % 3 Echogenic Plaque
predictedEPContext(predictedEPContext<=0) = -1;
%4 No structure

[polarImageMarkedR,polarImageMarkedG,polarImageMarkedB,...
    cartesianImageMarkedR,cartesianImageMarkedG,cartesianImageMarkedB] =...
    functionMarkArtifactsInImage(polarOriginalImage,...
    predictedBifsContext', predictedShadowContext',...
    predictedEPContext', ParametersSet, markEdgesStructures);

imgPolarMarkedContext = cat(3,polarImageMarkedR,polarImageMarkedG,polarImageMarkedB);
figure;
imshow(imgPolarMarkedContext);

imgCartMarkedContext = cat(3,cartesianImageMarkedR,cartesianImageMarkedG,cartesianImageMarkedB);
figure;
imshow(imgCartMarkedContext);

end

