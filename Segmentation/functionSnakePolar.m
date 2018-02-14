function [Xsnake,Ysnake] = functionSnakePolar(scoreMap, balloonForcesScore,...
    gradientForces, tensionCoef, flexuralCoef, inflationCoef, gradientCoef,...
    deltaT, maxIter, nrosVert, Xsnake, Ysnake)

plotear = false;
[sm,sn] = size(scoreMap);

if length(Xsnake)<2
    Ysnake = ones(1,nrosVert) * 15;
    xs = sn / nrosVert;
    Xsnake = int32(1:xs:xs*(nrosVert));
end
radius = 1;

sizeBalloon= size(balloonForcesScore);

if plotear
    [redColorMap,greenColorMap,blueColorMap] = functionLevantarDivergingMapFromCSV();
    colorMap = [redColorMap, greenColorMap, blueColorMap]./256;
    h = figure('Name','Snake');
    hold on;
    caxis([-2,2]);
    [C,h1] = contourf(flipud(scoreMap),120);
    set(h1,'LineColor','none');
    set(gca, 'DataAspectRatio', [1 1 1]);
    colormap(colorMap);
    
    plot(Xsnake,sm-Ysnake,'g');
end

iter=1;
converge = false;
YsnakeOld = ones(size(Ysnake))*(sm-2); %Init
while not(converge) && (iter<maxIter)
    
    %Equation 2 de T-Snakes Tension Force
    tensileForcesY = 2 * Ysnake - circshift(Ysnake,[0 radius]) - circshift(Ysnake,[0 -radius]);
    tensileForces = tensileForcesY;
    
    %Equation 3 de T-Snakes Bending force
    flexuralForces = 2 * tensileForces - circshift(tensileForces,[0 radius]) - circshift(tensileForces,[0 -radius]);
    
    %Equation 4 Inflation force
    indexes = sub2ind(sizeBalloon, int32(Ysnake), int32(Xsnake));
    %indexes(150:3:170)
    %inflationForces = externalForceSVMScores(indexes);
    
    %Equation Pag 215 balloon force Cohen 1991
    vectorGradienteForce = gradientForces(indexes);
    vectorInflation = balloonForcesScore(indexes);

    F =  vectorInflation * inflationCoef +  vectorGradienteForce * gradientCoef;
    
    %Ecuacion 8 de T-Snakes
    Ysnake = Ysnake - deltaT * (tensileForces * tensionCoef + flexuralForces * flexuralCoef - F);
    
    %Overflow and underflow control
    Ysnake(Ysnake<1)=1;
    Ysnake(Ysnake>sm)=sm;
    
    %Plot
    if mod(iter,1000)==0
        converge = ((sum((YsnakeOld-Ysnake).^2))/nrosVert)<0.001;
        YsnakeOld = Ysnake;
        if plotear
            plot(Xsnake,sm-Ysnake,'b');
        end
    end
    iter = iter+1;
    
end

if plotear
    plot(Xsnake,sm-Ysnake,'r');
    hold off;
end

end

