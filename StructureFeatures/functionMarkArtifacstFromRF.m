function [ imgPolarMarked,imgCartMarked,predictedBifs,...
    predictedCalcs,predictedHP,...
    imgPolarMarkedContext,imgCartMarkedContext,predictedBifsContext,...
    predictedCalcsContext,predictedHPContext] =...
    functionMarkArtifacstFromRF( polarOriginalImage, BaggedEnsemble, ParametersSet,...
    flagNormalized, isRFbagging, nClasses, markEdgesStructures, varargin )


    [featureVector,strFeatures,featureVectorNorm] =...
        functionFeatureVectorColGray( polarOriginalImage );
    polarOriginalImage = polarOriginalImage/255;
    
[nFeatures, nSamples] = size(featureVector);

if not(isempty(varargin))
    FS = varargin{1};
else
    FS = 1:nFeatures;
end

if isRFbagging
    [ prediction, predictionTestScore ] =...
        functionPredictRFBagging( BaggedEnsemble, featureVector,...
        100, ParametersSet.widthPolar, nClasses );
    predictedBifs = double(prediction==1);
    predictedBifs(predictedBifs<=0) = -1;
    predictedCalcs = double(prediction==2);
    predictedCalcs(predictedCalcs<=0) = -1;
    predictedHP = double(prediction==3);
    predictedHP(predictedHP<=0) = -1;
    predictedSV = double(prediction==5);
    predictedSV(predictedSV<=0) = -1;
else
    if flagNormalized
        [predictionTestCell,predictionTestScore] = predict(BaggedEnsemble,featureVectorNorm(FS,:)');
    else
        [predictionTestCell,predictionTestScore] = predict(BaggedEnsemble,featureVector(FS,:)');
    end
    predictedBifs = double(strcmp(predictionTestCell,'1'));
    predictedBifs(predictedBifs<=0) = -1;
    predictedCalcs = double(strcmp(predictionTestCell,'2'));
    predictedCalcs(predictedCalcs<=0) = -1;
    predictedHP = double(strcmp(predictionTestCell,'3'));
    predictedHP(predictedHP<=0) = -1;
    predictedSV = double(strcmp(predictionTestCell,'5'));
    predictedSV(predictedSV<=0) = -1;
end

[polarImageMarkedR,polarImageMarkedG,polarImageMarkedB,...
    cartesianImageMarkedR,cartesianImageMarkedG,cartesianImageMarkedB] =...
    functionMarkArtifactsInImage(polarOriginalImage,...
    predictedBifs', predictedCalcs',...
    predictedHP', ParametersSet, markEdgesStructures, predictedSV');

imgPolarMarked = cat(3,polarImageMarkedR,polarImageMarkedG,polarImageMarkedB);
%figure('Name',strcat('Img',num2str(nroImg)));
%imshow(imgPolarMarked);

Rcart = functionToCartesian(polarImageMarkedR,ParametersSet);
Gcart = functionToCartesian(polarImageMarkedG,ParametersSet);
Bcart = functionToCartesian(polarImageMarkedB,ParametersSet);

imgCartMarked = cat(3,Rcart,Gcart,Bcart);
figure;
imshow(imgCartMarked);

[ labelsImgOut ] = functionContextScoresRF( predictionTestScore, ParametersSet, 2 );
predictedBifsContext = double(labelsImgOut==1);
predictedBifsContext(predictedBifsContext<=0) = -1;
predictedCalcsContext = double(labelsImgOut==2);
predictedCalcsContext(predictedCalcsContext<=0) = -1;
predictedHPContext = double(labelsImgOut==3);
predictedHPContext(predictedHPContext<=0) = -1;
predictedSVContext = double(labelsImgOut==5);
predictedSVContext(predictedSVContext<=0) = -1;

[polarImageMarkedR,polarImageMarkedG,polarImageMarkedB,...
    cartesianImageMarkedR,cartesianImageMarkedG,cartesianImageMarkedB] =...
    functionMarkArtifactsInImage(polarOriginalImage,...
    predictedBifsContext', predictedCalcsContext',...
    predictedHPContext', ParametersSet, markEdgesStructures, predictedSVContext');

imgPolarMarkedContext = cat(3,polarImageMarkedR,polarImageMarkedG,polarImageMarkedB);
%figure('Name',strcat('Img',num2str(nroImg),'-Context'));
%imshow(imgPolarMarkedContext);

Rcart = functionToCartesian(polarImageMarkedR,ParametersSet);
Gcart = functionToCartesian(polarImageMarkedG,ParametersSet);
Bcart = functionToCartesian(polarImageMarkedB,ParametersSet);

imgCartMarkedContext = cat(3,Rcart,Gcart,Bcart);
figure;
imshow(imgCartMarkedContext);

end

