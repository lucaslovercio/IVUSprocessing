function [ slopes,intercepts,lost ] = functionLinearApproxColumn( scoreMap )

[h,w]=size(scoreMap);
slopes = zeros(1,w);
intercepts = zeros(1,w);
lost = zeros(1,w);
for i=1:w
    y = scoreMap(:,i);
    x = 1:h;
    [c,R2] = functionLeastSquareLinear(x,y);
    slopes(i)=c(1);
    intercepts(i)=c(2);
    lost(i)=R2;
end


end

