function [ XPolar, YPolar ] = functionSnakeInitializationFourier( scoreMap, numberOfSnakePoints,...
    isEdgeMap, isCircleInCatheter, radio )

[heightPolar,widthPolar] = size(scoreMap);

if not(isCircleInCatheter)
    if not(isEdgeMap)
        binaryImage = scoreMap > 0;
        binaryShiftedInverted = not(circshift(binaryImage, [-1 0]));
        bordesHorz = binaryImage & binaryShiftedInverted;
    else
        bordesHorz = scoreMap;
    end
    stepX = floor(widthPolar/numberOfSnakePoints);
    XPolar = double(1:stepX:widthPolar);
    XPolarValid = [];
    step = 2*pi / widthPolar;
    timevec=0:step:2*pi;
    xSinAux=timevec(1:widthPolar);
    YPolarMedian = [];
    xSin = [];
    for i=1:widthPolar
        [row] = find(bordesHorz(:,i));
        if not(isempty(row))
            hMedian = median(row);
            YPolarMedian = [YPolarMedian,hMedian];
            xSin = [xSin,xSinAux(i)];
            XPolarValid = [XPolarValid,i];
        end
    end
    
    warning off;
    [fitresult, gof] = functionFourier1(xSin, YPolarMedian);
    warning on;
    YPolar = fitresult(xSinAux);
    YPolar(YPolar<1)=1;
    YPolar(YPolar>heightPolar-1)=heightPolar-1;
    YPolar = YPolar';
    
else
    step = floor(widthPolar/numberOfSnakePoints);
    XPolar = double(1:step:widthPolar);
    YPolar = ones(size(XPolar)) * radio;
end

end