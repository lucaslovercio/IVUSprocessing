function valueFeature = functionContrast( glcm, levels )
%FUNCTIONCONTRAST Summary of this function goes here
%   Detailed explanation goes here

subtotal = 0;
for i=1:1:levels
    grisI = i/levels;
    for j=1:1:levels
        grisJ = j/levels;
        subtotal = subtotal + (grisI-grisJ)^2 * glcm(i,j);
    end
end

valueFeature = subtotal;


end

