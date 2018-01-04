function [ firstMaxGradientCol, firstMinGradientCol,secondMaxGradientCol, secondMinGradientCol,...
    scoreAboveFirstMaxGradientCol,scoreAboveFirstMinGradientCol,scoreAboveSecondMaxGradientCol,...
    scoreAboveSecondMinGradientCol,scoreBelowFirstMaxGradientCol,scoreBelowFirstMinGradientCol,scoreBelowSecondMaxGradientCol,...
    scoreBelowSecondMinGradientCol,posMaxs1,posMins1,posMaxs2,posMins2, sumMinGradient, sumMaxGradient] = functionGradientsCol( scoreMap )

[h,w] = size(scoreMap);
dx = 5; dy = 7;
Gsmooth = functionSmoothedGradient( scoreMap, dx, dy );
[firstMaxGradientCol, posMaxs1] = max(Gsmooth(dy:end-dy,:));
[firstMinGradientCol, posMins1] = min(Gsmooth(dy:end-dy,:));
posMaxs1 = posMaxs1 + dy;
posMins1 = posMins1 + dy;
window=10;
scoreAboveFirstMaxGradientCol = zeros(1,w); scoreAboveFirstMinGradientCol = zeros(1,w);
scoreBelowFirstMaxGradientCol = zeros(1,w); scoreBelowFirstMinGradientCol = zeros(1,w);
for i=1:w
    posMax = posMaxs1(i); posMaxInic = max(1,posMax-window);
    columnAbove = scoreMap(posMaxInic:posMax,i);
    scoreAboveFirstMaxGradientCol(i) = median(columnAbove);
    posMaxFin = min(h,posMax+window);
    columnAbove = scoreMap(posMax:posMaxFin,i);
    scoreBelowFirstMaxGradientCol(i) = median(columnAbove);
end
for i=1:w
    posMin = posMins1(i); posMinInic = max(1,posMin-window);
    columnAbove = scoreMap(posMinInic:posMin,i);
    scoreAboveFirstMinGradientCol(i) = median(columnAbove);
    posMinFin = min(h,posMin+window);
    columnAbove = scoreMap(posMin:posMinFin,i);
    scoreBelowFirstMinGradientCol(i) = median(columnAbove);
end

%Delete until gradient equals 0
for i=1:w
    
    %Backward
    pos = posMaxs1(i);
    grad = firstMaxGradientCol(i);
    while grad>0 && pos<h && pos>0
        Gsmooth(pos,i)=0;
        pos = pos-1;
        grad=Gsmooth(pos,i);
    end
    
    %Forward
    pos = posMaxs1(i);
    grad = firstMaxGradientCol(i);
    while grad>0 && pos<h && pos>0
        Gsmooth(pos,i)=0;
        pos = pos+1;
        grad=Gsmooth(pos,i);
    end
    
    %Backward
    pos = posMins1(i);
    grad = firstMinGradientCol(i);
    while grad<0 && pos<h && pos>0
        Gsmooth(pos,i)=0;
        pos = pos-1;
        grad=Gsmooth(pos,i);
    end
    
    %Forward
    pos = posMins1(i);
    grad = firstMinGradientCol(i);
    while grad<0 && pos<h && pos>0
        Gsmooth(pos,i)=0;
        pos = pos+1;
        grad=Gsmooth(pos,i);
    end
    
end

[secondMaxGradientCol, posMaxs2] = max(Gsmooth(dy:end-dy,:));
[secondMinGradientCol, posMins2] = min(Gsmooth(dy:end-dy,:));
posMaxs2 = posMaxs2 + dy;
posMins2 = posMins2 + dy;

sumMinGradient = firstMinGradientCol+secondMinGradientCol;
sumMaxGradient = firstMaxGradientCol+secondMaxGradientCol;

scoreAboveSecondMaxGradientCol = zeros(1,w); scoreAboveSecondMinGradientCol = zeros(1,w);
scoreBelowSecondMaxGradientCol = zeros(1,w); scoreBelowSecondMinGradientCol = zeros(1,w);
for i=1:w
    posMax = posMaxs2(i); posMaxInic = max(1,posMax-window);
    columnAbove = scoreMap(posMaxInic:posMax,i);
    scoreAboveSecondMaxGradientCol(i) = median(columnAbove);
    posMaxFin = min(h,posMax+window);
    columnAbove = scoreMap(posMax:posMaxFin,i);
    scoreBelowSecondMaxGradientCol(i) = median(columnAbove);
end
for i=1:w
    posMin = posMins2(i); posMinInic = max(1,posMin-window);
    columnAbove = scoreMap(posMinInic:posMin,i);
    scoreAboveSecondMinGradientCol(i) = median(columnAbove);
    posMinFin = min(h,posMin+window);
    columnAbove = scoreMap(posMin:posMinFin,i);
    scoreBelowSecondMinGradientCol(i) = median(columnAbove);
end


end

