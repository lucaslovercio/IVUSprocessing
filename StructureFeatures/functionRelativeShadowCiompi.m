function Ioutput = functionRelativeShadowCiompi( img, TH, widthPolar, heightPolar )

BI = img < TH;%Ciompi 2012 suggest 14
BI = double(BI);

NrNc = double(widthPolar*heightPolar);

Ioutput = double(zeros(heightPolar,widthPolar));

Ioutput(heightPolar,:) = BI(heightPolar,:);

for j = heightPolar-1:-1:1
    
    Ioutput(j,:) =  Ioutput(j+1,:) + double(j) * BI(j,:);
    
end

Ioutput = Ioutput./NrNc;

end

