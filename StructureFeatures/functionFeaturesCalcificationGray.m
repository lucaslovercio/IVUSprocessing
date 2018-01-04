function [medianUnderMaximo,RatioDong2013, stdShadow, candidatesCalcificationOtsu] =...
    functionFeaturesCalcificationGray( imgPolarOriginal )
[h,w] = size(imgPolarOriginal);
[values,positions] = max(imgPolarOriginal);
profundidadCalcificacion = 15;

medianUnderMaximo = zeros(1,w);
stdShadow = zeros(1,w);
for i=1:w
    if positions(i)<0
        medianUnderMaximo(i) = 1;
    else
        inicBack = positions(i)+profundidadCalcificacion;
        if inicBack>h
            inicBack = h;
        end
        col = imgPolarOriginal(inicBack:h,i);
        if isempty(col) || (sum(isnan(col)>0))
            medianUnderMaximo(i) = -1;
            stdShadow(i) = 0;
        else
            medianUnderMaximo(i) = median(col);
            stdShadow(i) = std(col);
        end
    end
end


RatioDong2013 = medianUnderMaximo./values;

%Otsu as DosSantos2013

%2 times Adaptative threshold
imgPolarOriginal = imgPolarOriginal/255; %MATLAB impose normalization
level1 = graythresh(imgPolarOriginal); %Otsu
mask1 = im2bw(imgPolarOriginal,level1);

%Second time
pixelesMitadHistograma = imgPolarOriginal(mask1);
level2 = graythresh(pixelesMitadHistograma);
mask2 = im2bw(imgPolarOriginal,level2);

pixelesMitadHistograma = imgPolarOriginal(mask2);
level3 = graythresh(pixelesMitadHistograma);
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

