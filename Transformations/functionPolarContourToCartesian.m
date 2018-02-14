function [ X, Y ] = functionPolarContourToCartesian( vectorRadius, vectorAnglesInt, ParametersSet )

X = zeros(size(vectorRadius));
Y = zeros(size(vectorRadius));

for i=1:length(vectorRadius)
    angPos = double(vectorAnglesInt(i));
    r = double(vectorRadius(i));

    alpha = (angPos/ParametersSet.widthPolar) * 2 * pi;
    
    cosA = cos(alpha);
    sinA = sin(alpha);
    
    x = cosA * (r+ParametersSet.radiusInt);
    y = sinA * (r+ParametersSet.radiusInt);
    
    x = x + ParametersSet.centerX;
    y = y + ParametersSet.centerY;
    
    if (x<1); x=1; end
    if (x>ParametersSet.widthStandard); x=ParametersSet.widthStandard; end
    if (y<1); y=1; end
    if (y>ParametersSet.heightStandard); y=ParametersSet.heightStandard; end
    
    X(i) = x;
    Y(i) = y;

end

