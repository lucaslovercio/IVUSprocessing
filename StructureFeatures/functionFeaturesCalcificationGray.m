function [medianUnderMaximum,RatioDong2013, stdShadow, candidatesCalcificationOtsu] =...
    functionFeaturesCalcificationGray( imgPolarOriginal )
[h,w] = size(imgPolarOriginal);
[values,positions] = max(imgPolarOriginal);
depthCalc = 15;

medianUnderMaximum = zeros(1,w);
stdShadow = zeros(1,w);
for i=1:w
    if positions(i)<0
        medianUnderMaximum(i) = 1;
    else
        inicBack = positions(i)+depthCalc;
        if inicBack>h
            inicBack = h;
        end
        col = imgPolarOriginal(inicBack:h,i);
        if isempty(col) || (sum(isnan(col)>0))
            medianUnderMaximum(i) = -1;
            stdShadow(i) = 0;
        else
            medianUnderMaximum(i) = median(col);
            stdShadow(i) = std(col);
        end
    end
end


RatioDong2013 = medianUnderMaximum./values;

%Otsu as DosSantos2013

%2 times Adaptative threshold
imgPolarOriginal = imgPolarOriginal/255; %MATLAB impose normalization
level1 = graythresh(imgPolarOriginal); %Otsu
mask1 = im2bw(imgPolarOriginal,level1);

%Second time
pixelesHalfHistograma = imgPolarOriginal(mask1);
level2 = graythresh(pixelesHalfHistograma);
mask2 = im2bw(imgPolarOriginal,level2);

pixelesHalfHistograma = imgPolarOriginal(mask2);
level3 = graythresh(pixelesHalfHistograma);
mask3 = im2bw(imgPolarOriginal,level3);

candidatesCalcificationOtsu = zeros(1,w);

for i=1:w
    col = mask3(:,i);
    candidatesColumn = find(col,1);
    if isempty(candidatesColumn)
        candidatesCalcificationOtsu(i) = -1;
    else
        candidatesColumn = find(col);
        candidatesCalcificationOtsu(i) = length(candidatesColumn);
    end
end

end

