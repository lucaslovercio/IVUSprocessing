function [ imgPolar ] = functionToPolar( toPolar, ParametersSet )

imgPolar = zeros(ParametersSet.heightPolar,ParametersSet.widthPolar,'double');

for u = 0:ParametersSet.stepAngle:2*pi
    for v = ParametersSet.radiusInt:ParametersSet.stepRadius:ParametersSet.radiusExt
        x = v * cos(u);
        y = v * sin(u);
        x = uint32(x + ParametersSet.centerX);
        y = uint32(y + ParametersSet.centerY);
        if x>=0 && y>=0 && x<ParametersSet.heightStandard && y<ParametersSet.widthStandard
            rgb = toPolar(x+1,y+1);
            u2 = u / ParametersSet.stepAngle;
            v2 = (v-ParametersSet.radiusInt)/ParametersSet.stepRadius;
            if u2>=0 && u2<ParametersSet.widthPolar && v2>=0 && v2<ParametersSet.heightPolar
                imgPolar(uint32(v2+1),uint32(u2+1))=rgb; 
            end    
        end
    end
end

end

