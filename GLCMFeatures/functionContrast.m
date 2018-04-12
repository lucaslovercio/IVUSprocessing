function valueFeature = functionContrast( glcm, levels )

subtotal = 0;
for i=1:1:levels
    greyI = i/levels;
    for j=1:1:levels
        greyJ = j/levels;
        subtotal = subtotal + (greyI-greyJ)^2 * glcm(i,j);
    end
end

valueFeature = subtotal;


end

