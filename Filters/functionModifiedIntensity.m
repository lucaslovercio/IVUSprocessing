function Imodified = functionModifiedIntensity( img, widthPolar, heightPolar )

Imodified = zeros(heightPolar,widthPolar);

for x=1:1:widthPolar
    for y=1:1:heightPolar
        
        %coeficientes
        ises = double(1:1:y)';
        denoms = ones(y,1)*double(y);
        coefs = double((denoms-ises)+ones(y,1));
        coefs = coefs.^(-1.);
        
        %sumatorias
        sumatorias = zeros(y,1);
        for j=1:1:y
            
            k=j;
            sumatoria = sum(img(k:y,x));
            sumatorias(j) = double(sumatoria);
            
        end
        
        %coef * sum
        ponderado = sumatorias.*coefs;
        
        maximum = max(ponderado);
        
        Imodified(y,x) = maximum;
        
    end
end

Imodified = ( Imodified - min(Imodified(:)) ) / ( max(Imodified(:)) - min(Imodified(:)) );

end

