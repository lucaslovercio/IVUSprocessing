function [ edgeScore ] = functionEdgeScores( mapaDeScores )

[h,w]=size(mapaDeScores);
thresholded = mapaDeScores>0;

edgeScore = thresholded & not(circshift(thresholded,[-1 0]));

edgeScore(:,1)=0;
edgeScore(:,w)=0;
edgeScore(1,:)=0;
edgeScore(h,:)=0;

edgeScore = not(edgeScore);

end

