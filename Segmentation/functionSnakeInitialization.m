function [ XPolar, YPolar ] = functionSnakeInitialization( scoreMap, numberOfSnakePoints,...
    isEdgeMap, isCircleInCatheter, radio )

[heightPolar,widthPolar] = size(scoreMap);

if not(isCircleInCatheter)
    if not(isEdgeMap)
        binaryImage = scoreMap > 0;
        binaryShiftedInverted = not(circshift(binaryImage, [-1 0]));
        horizontalEdges = binaryImage & binaryShiftedInverted;
    else
        horizontalEdges = scoreMap;
    end
    
    continuity = horzcat(horizontalEdges,horizontalEdges,horizontalEdges);
    YPolarMedian = zeros(1,widthPolar*3);
    
    segments = 8;
    widthMedian = floor(widthPolar/segments);
    
    for i=1:widthMedian:3*widthPolar-widthMedian
        
        rectangleSegment = continuity(:,i:(i+widthMedian));
        [row,col] = find(rectangleSegment);
        hMedian = median(row);
        YPolarMedian(i:(i+widthMedian)) = hMedian;
    end
    
    YPolarMedian = int32(YPolarMedian(widthPolar+1:2*widthPolar));
    YPolarMedian(YPolarMedian<1) = int32(heightPolar/2);
    YPolarMedian(YPolarMedian>=heightPolar) = int32(heightPolar-5);
    
    step = floor(widthPolar/numberOfSnakePoints);
    XPolar = double(1:step:widthPolar);
    YPolar = double(YPolarMedian(XPolar));
    
else
    step = floor(widthPolar/numberOfSnakePoints);
    XPolar = double(1:step:widthPolar);
    YPolar = ones(size(XPolar)) * radio;
end

end