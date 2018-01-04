function valorMean = functionMeanGLCM( glcm, levels )

subtotal = 0;
for i=1:1:levels  
    grey = i/levels;
    subTotalCol = sum(glcm(i,:));
    subtotal = subtotal + subTotalCol * grey;
end

valorMean = subtotal;

end

