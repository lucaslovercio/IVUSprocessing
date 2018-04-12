%Haralick Entropy (9)
%GLCM p(), no totals!!

function valorFeature = functionEntropy( glcm, levels )

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

