%Haralick Entropy (9)
%GLCM p(), no totales!!

function valorFeature = functionEntropy( glcm, levels )
%FUNCTIONENTROPY Summary of this function goes here
%   Detailed explanation goes here

mieps=0.00000001;

subtotal = 0;
for i=1:1:levels
    for j=1:1:levels
        if glcm(i,j) >= 1
            subvalor = 0;
        else
            subvalor = glcm(i,j) * log(glcm(i,j)+mieps);
        end
        subtotal = subtotal + subvalor;
    end
end

valorFeature = -subtotal;

end

