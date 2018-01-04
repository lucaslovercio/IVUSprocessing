function valueFeature = functionVariance( glcm, levels )
%Haralick sum of squares (4)
subtotal = 0;
meanValue = functionMeanGLCM(glcm,levels);
for i=1:1:levels
    gris = i/levels;
    for j=1:1:levels
        subtotal = subtotal + glcm(i,j)*((gris-meanValue)^2);
    end
end

valueFeature = subtotal;

end

