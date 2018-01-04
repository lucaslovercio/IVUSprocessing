function Ioutput = functionShadowCiompi( img, TH, widthPolar, heightPolar )

BI = img < TH;
BI = double(BI);

NrNc = double(widthPolar*heightPolar);

Ioutput = double(zeros(heightPolar,widthPolar));

Ioutput(heightPolar,:) = BI(heightPolar,:);

for j = heightPolar-1:-1:1
    
    Ioutput(j,:) =  Ioutput(j+1,:) + BI(j,:);
    
end

Ioutput = Ioutput./NrNc;

end

