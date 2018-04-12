%Haralick angular second moment (1)
%GLCM p(), no total!!
%Same result as graycoprops(glcm,'Energy'); from MATLAB
function valorFeature = functionAngularSecondMoment( glcm, levels )

subtotal = 0;
for i=1:1:levels
    for j=1:1:levels
        subtotal = subtotal + (glcm(i,j))^2;
    end
end

valorFeature = subtotal;

end

