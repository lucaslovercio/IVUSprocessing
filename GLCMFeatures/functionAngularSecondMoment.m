%Haralick angular second moment (1)
%GLCM p(), no totales!!
%Da igual al graycoprops(glcm,'Energy'); de MATLAB
function valorFeature = functionAngularSecondMoment( glcm, levels )
%FUNCTIONANGULARSECONDMOMENT Summary of this function goes here
%   Detailed explanation goes here

subtotal = 0;
for i=1:1:levels
    for j=1:1:levels
        subtotal = subtotal + (glcm(i,j))^2;
    end
end

valorFeature = subtotal;

end

