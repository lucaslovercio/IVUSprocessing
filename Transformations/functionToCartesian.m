
function cartesiana = functionToCartesian(aCartesiana, ParametersSet)
cartesiana = zeros(ParametersSet.heightStandard, ParametersSet.widthStandard);
for x=1:1:ParametersSet.widthStandard
    for y=1:1:ParametersSet.heightStandard
        
        x2 = x-ParametersSet.centerX;
        y2 = y-ParametersSet.centerY;
        
        r = sqrt(x2*x2+y2*y2);
        r2= r - ParametersSet.radiusInt;
        
        seno = y2/r;
        ang = asin(seno);
        
        if (x2<=0 && y2>=0) %quadrant 2
            ang = pi - ang;
        else
            if (x2<=0 && y2<=0) %quadrant 3
                ang = pi - ang;
            else %quadrant 4
                if (x2>=0 && y2<=0)
                    ang = 2*pi + ang;
                end
            end
        end
        
        i = ceil(ang/ParametersSet.stepAngle);
        j = ceil(r2/ParametersSet.stepRadius);
        if (i>0 && j>0 && i<=ParametersSet.widthPolar && j<=ParametersSet.heightPolar)
            rgb = aCartesiana(j,i);
            if(x2<=ParametersSet.widthStandard && y2<=ParametersSet.heightStandard)
                cartesiana(x,y)=rgb;
            end
        end
        
    end
end

end