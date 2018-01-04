function [ nuj, totalRadialEnergy, totalRadialEnergyScaled] = functionRadialCumulativeMeanGil( scoreMap )
[height,width] = size(scoreMap);

nuj = zeros(size(scoreMap));
for j=1:width
    for i=1:height
        numerador = sum(scoreMap(i:height,j));
        denominador = height-i+1;
        nuj(i,j) = numerador / denominador;
    end
end

totalRadialEnergy = sum(nuj);
totalRadialEnergyScaled = (totalRadialEnergy - mean(totalRadialEnergy))/std(totalRadialEnergy);

end

