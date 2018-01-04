function [ forest ] = functionRandomForestBagging( NumTrees, matFeatures,...
    vecLabels, nClasses, nVarToSample, minLeaf, varargin )
nVarargs = length(varargin);
if nVarargs>0
    weights = varargin{1};
else
    weights = ones(1,nClasses);
end

samplesPerTree = cell(NumTrees,1);

for i=1:nClasses
    indexesClassI = find(vecLabels==i);

    foldTrees = crossvalind('Kfold', length(indexesClassI), NumTrees); %K=5

    for t=1:NumTrees
         indexTree = indexesClassI(foldTrees==t);
         ant = samplesPerTree{t};
         samplesPerTree(t)  = {[ant;indexTree]};
    end

end

forest = cell(NumTrees,1);

for t=1:NumTrees
    indexesSamplesTree = samplesPerTree{t};
    labelsTree = vecLabels(indexesSamplesTree);
    wSamples = ones(1,length(labelsTree));
    for l=1:nClasses
        wSamples(labelsTree==l)=weights(l);
    end
    matTree = matFeatures(:,indexesSamplesTree);
    matTree = matTree';
    tree = fitctree(matTree,labelsTree,'MinLeafSize',minLeaf,'NumVariablesToSample',nVarToSample,...
        'CrossVal','off','SplitCriterion','gdi','Weights',wSamples);

    forest(t) = {tree};
end

end

