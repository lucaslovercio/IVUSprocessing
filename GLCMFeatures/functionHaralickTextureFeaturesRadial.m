function [out] = functionHaralickTextureFeaturesRadial( img, window, widthPolar, heightPolar )
%FUNCTIONHARALICKTEXTUREFEATURESRADIAL Summary of this function goes here
%   Detailed explanation goes here

out.sumOfSquaresRadial = zeros(heightPolar,widthPolar);
out.angularSecondMomentRadial = zeros(heightPolar,widthPolar);
out.entropyRadial = zeros(heightPolar,widthPolar);
out.contrastRadial = zeros(heightPolar,widthPolar);
out.inverseDifferenceMomentRadial = zeros(heightPolar,widthPolar);

levels = 50; %ancho alto de la glcm. 255 de lado tal vez sea mucho
l = floor(window/2);

for i=1:1:heightPolar%Recorre alto
    for j=1:1:widthPolar %recorre ancho
        
        rect = [j-l i-l window window]; %Recordar que imcrop cambia las coords respecto a la matriz
        subimg = imcrop(img, rect);
        %figure, imshow(subimg);
        
        glcm1 = graycomatrix(subimg, 'NumLevels', levels, 'offset', [-1 0], 'Symmetric', true);
        glcm2 = graycomatrix(subimg, 'NumLevels', levels, 'offset', [1 0], 'Symmetric', true);
        glcm3 = graycomatrix(subimg, 'NumLevels', levels, 'offset', [-2 0], 'Symmetric', true);
        glcm4 = graycomatrix(subimg, 'NumLevels', levels, 'offset', [2 0], 'Symmetric', true);
        
        glcm = glcm1 + glcm2 + glcm3 + glcm4;
        samples = sum(glcm(:));
        glcmProb = glcm ./ samples;
        
        %Sum of Squares o Varianza
        variancePixel = functionVariance(glcmProb,levels);
        out.sumOfSquaresRadial(i,j)= variancePixel;
        
        %Mi Angular Second Moment
        angularSecondMomentPixel = functionAngularSecondMoment(glcmProb,levels);
        out.angularSecondMomentRadial(i,j) = angularSecondMomentPixel;
        
        %entropia
        entropiaPixel = functionEntropy(glcmProb,levels);
        out.entropyRadial(i,j) = entropiaPixel;
        
        %contrast
        contrastPixel = functionContrast(glcmProb,levels);
        out.contrastRadial(i,j) = contrastPixel;
        
        %Inverse Difference Moment
        invDifMomPixel = functionInverseDifferenceMoment(glcmProb,levels);
        out.inverseDifferenceMomentRadial(i,j) = invDifMomPixel;
        
    end
end


end

