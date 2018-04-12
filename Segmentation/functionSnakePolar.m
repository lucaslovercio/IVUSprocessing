function [Xsnake,Ysnake] = functionSnakePolar(edgesPolar, inflationForces,...
    gradientForces, tensionCoef, flexuralCoef, inflationCoef, gradientCoef,...
    deltaT, maxIter, nrosVert, Xsnake, Ysnake)

doPlot = false;
[sm,sn] = size(edgesPolar);

if length(Xsnake)<2
    Ysnake = ones(1,nrosVert) * 15;
    xs = sn / nrosVert;
    Xsnake = int32(1:xs:xs*(nrosVert));
end
radius = 1;

sizeBalloon= size(inflationForces);

if doPlot
    hFigure = functionShowScoreMap( inflationForces, 'Inflation force' );
    hold on; plot(Xsnake,sm-Ysnake,'g','LineWidth',1.5);
end

iter=1;
converge = false;
YsnakeOld = ones(size(Ysnake))*(sm-2); %Init
while not(converge) && (iter<maxIter)
    
    %Equation 2 - T-Snakes Tension Force
    tensileForcesY = 2 * Ysnake - circshift(Ysnake,[0 radius]) - circshift(Ysnake,[0 -radius]);
    tensileForces = tensileForcesY;
    
    %Equation 3 - T-Snakes Bending force
    flexuralForces = 2 * tensileForces - circshift(tensileForces,[0 radius]) - circshift(tensileForces,[0 -radius]);
    
    %Equation 4 Inflation force
    indexes = sub2ind(sizeBalloon, int32(Ysnake), int32(Xsnake));
    
    %Equation Page 215 balloon force Cohen 1991
    vectorGradienteForce = gradientForces(indexes);
    vectorInflation = inflationForces(indexes);

    F =  vectorInflation * inflationCoef +  vectorGradienteForce * gradientCoef;
    
    %Ecuacion 8 T-Snakes
    Ysnake = Ysnake - deltaT * (tensileForces * tensionCoef + flexuralForces * flexuralCoef - F);
    
    %Overflow and underflow control
    Ysnake(Ysnake<1)=1;
    Ysnake(Ysnake>sm)=sm;
    
    if mod(iter,maxIter/5)==0
        converge = ((sum((YsnakeOld-Ysnake).^2))/nrosVert)<0.001;
        YsnakeOld = Ysnake;
        if doPlot
            plot(Xsnake,sm-Ysnake,'b');
        end
    end
    iter = iter+1;
    
end

if doPlot
    plot(Xsnake,sm-Ysnake,'r');
    hold off;
end

end

