function [ labelsImgOut ] = functionContextScoresRF( predictionTestScore, ParametersSet, sigma )
%'functionContextScoresRF'
[nClasses,nSamples] = size(predictionTestScore);
w = ParametersSet.widthPolar;
nImgs = round(nSamples/w);
h = fspecial('gaussian', [1 30], sigma);
labelsImgOut = zeros(1,nSamples);
for iImg=1:nImgs
    
    imageStructScores = predictionTestScore(:,(iImg-1)*w+1:iImg*w);
    imageStructScoresConcat = horzcat(imageStructScores,imageStructScores,imageStructScores);

    imageStructScoresConcat = imfilter(imageStructScoresConcat,h,'same');
    imageStructScores = imageStructScoresConcat(:,w+1:2*w);

    [values, labelsImg] = max(imageStructScores);

    labelsImgOut((iImg-1)*w+1:iImg*w)=labelsImg;
end

end

