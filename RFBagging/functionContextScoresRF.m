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
%     if iImg==1
%         'scores concat'
%         size(imageStructScoresConcat)
%     end
    imageStructScoresConcat = imfilter(imageStructScoresConcat,h,'same');
    imageStructScores = imageStructScoresConcat(:,w+1:2*w);
    %if iImg==1
    %    'scores concat filtered'
    %    size(imageStructScores)
    %    min(imageStructScores(:))
    %    max(imageStructScores(:))
    %end
    [values, labelsImg] = max(imageStructScores);
    %labelsImg(2:3)
    labelsImgOut((iImg-1)*w+1:iImg*w)=labelsImg;
end

end

