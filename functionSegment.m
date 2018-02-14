function [ inicSnakeXLI, inicSnakeYLI ] = functionSegment(scoreMapLumen, scoreMapBackground,...
    predictedBifs, predictedShadow, predictedEP, detectStructures, ParametersSet )

[ polarLI ] = functionEdgeScores( scoreMapLumen );
[ polarMA ] = functionEdgeScores( scoreMapBackground );

if detectStructures
    
    predictedBifs(predictedBifs<=0) = -1;
    predictedShadow(predictedShadow<=0) = -1;
    predictedEP(predictedEP<=0) = -1;
    
    colsBifurcation = repmat(predictedBifs,ParametersSet.heightPolar,1);
    colsShadows = repmat(predictedShadow,ParametersSet.heightPolar,1);
    colsEP = repmat(predictedEP,ParametersSet.heightPolar,1);
    
else
    predictEmpty = ones(1,ParametersSet.widthPolar) * -1;%Matrix of -1s
    colsBifurcation = repmat(predictEmpty,ParametersSet.heightPolar,1);
    colsShadows = repmat(predictEmpty,ParametersSet.heightPolar,1);
    colsEP = repmat(predictEmpty,ParametersSet.heightPolar,1);
    
end

%----------------------- LUMEN INTIMA ------------------------

%Delete edge in Bifs
polarLI(colsBifurcation>0)=1;
scoreMapLumen(colsBifurcation>0)=0;

%Connected components
CC = bwconncomp(not(polarLI));

for i=1:1:CC.NumObjects
    conected = CC.PixelIdxList{i};
    if length(conected)<4
        polarLI(conected) = 1;
    end
end

%Gradient
gaussDevCoef = 2.5;
polarLIFiltered = imgaussfilt(double(polarLI),gaussDevCoef); %gaussian gradient
GsmoothAbs = abs(polarLIFiltered); % |gradImg|
[~, Derive2] = imgradientxy(GsmoothAbs, 'CentralDifference'); Derive2(1,:)=0; Derive2(end,:)=0;
Derive2 = Derive2.*(-1);

%Snake
tensionCoefLI = 2;
inflationCoefLI = 0.15;
flexuralCoef = 0;
gradientCoef = 1;

gradientForces = Derive2;
deltaT = 0.1;
maxIter = 200000;
numberOfSnakePoints = ParametersSet.widthPolar;

[ inicSnakeXLI, inicSnakeYLI ] =...
    functionSnakeInitialization( not(polarLI), numberOfSnakePoints, true, false, 40 );

[XsnakeLI,YsnakeLI] = functionSnakePolar(polarLI, scoreMapLumen, gradientForces,...
    tensionCoefLI, flexuralCoef, inflationCoefLI ,gradientCoef, deltaT, maxIter,...
    numberOfSnakePoints, inicSnakeXLI, inicSnakeYLI);

%----------------------- MEDIA ADVENTICIA ------------------------

%LI region
LIidx = sub2ind(size(polarLI), int32(YsnakeLI), int32(XsnakeLI));
polarLIRegion = false(size(polarLI));
polarLIRegion(LIidx) = true;
elemStruc = ones(21,21);
polarLIRegion = imdilate(polarLIRegion,elemStruc);

%Erase edge in structures
polarMA(colsBifurcation>0)=1;
polarMA(colsShadows>0)=1;
polarMA(colsEP>0 & polarLIRegion>0)=1;

scoreMapBackground(colsShadows>0)=0;
scoreMapBackground(colsBifurcation>0)=0;

%Connected components
CC = bwconncomp(not(polarMA));
for i=1:1:CC.NumObjects
    conected = CC.PixelIdxList{i};
    if length(conected)<5 %esta solito, lo elimino
        polarMA(conected) = 1;
    end
end

%Gradient
polarMAFiltered = imgaussfilt(double(polarMA),gaussDevCoef);
GsmoothAbs = abs(polarMAFiltered); % |gradImg|
[~, Derive2] = imgradientxy(GsmoothAbs, 'CentralDifference'); Derive2(1,:)=0; Derive2(end,:)=0;
Derive2 = Derive2.*(-1);

%Snake
tensionCoefMA = 0.7;
inflationCoefMA = 0.005;

gradientForces = Derive2;

[ inicSnakeXMA, inicSnakeYMA ] = functionSnakeInitialization( not(polarMA), numberOfSnakePoints, true, false, 40 );

[XsnakeMA,YsnakeMA] = functionSnakePolar(polarMA, scoreMapBackground, gradientForces,...
    tensionCoefMA, flexuralCoef, inflationCoefMA,gradientCoef, deltaT, maxIter,...
    numberOfSnakePoints, inicSnakeXMA, inicSnakeYMA);

%--------------TRANSFORMATIONS---------------

[ XContourLI, YContourLI ] =...
    functionPolarContourToCartesian( YsnakeLI, 1:ParametersSet.widthPolar, ParametersSet );
[ XContourMA, YContourMA ] =...
    functionPolarContourToCartesian( YsnakeMA, 1:ParametersSet.widthPolar, ParametersSet );

%Interpolation
dmin=0.4;
dmax=1;
[XContourLIinterp,YContourLIinterp] = snakeinterp(XContourLI,YContourLI,dmax,dmin);
[XContourMAinterp,YContourMAinterp] = snakeinterp(XContourMA,YContourMA,dmax,dmin);
