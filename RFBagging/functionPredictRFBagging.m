function [ prediction, matScores ] =...
    functionPredictRFBagging( RFBagging, matFeatures, NumTrees, nSamples, nClasses, varargin)
nVarargs = length(varargin);
if nVarargs>0
    weights = varargin{1};
else
    weights = ones(1,nClasses);
end

matScores = zeros(nClasses,nSamples);
for j=1:NumTrees
    labels = predict(RFBagging{j},matFeatures');
    idx = sub2ind(size(matScores), labels',1:nSamples);
    matScores(idx) = matScores(idx)+1;
end
matScores = matScores./NumTrees;
matScores = matScores .* repmat(weights',[1 nSamples]);
[~,prediction] = max(matScores);

end

