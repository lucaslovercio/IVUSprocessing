radiusInt = 20;
radiusExt = 193;
stepRadius = 1;
widthPolar = 512;
x2pi = 2*pi;
stepAngle = x2pi/widthPolar;
widthStandard = 384;
heightStandard = 384;
centerX = widthStandard/2;
centerY = heightStandard/2;
noSnakePoint = -1;
heightPolar = int32(ceil((radiusExt - radiusInt) / stepRadius));

ParametersSet = struct('radiusInt',radiusInt,'radiusExt',radiusExt,...
    'stepRadius',stepRadius,'stepAngle',stepAngle,'widthPolar',widthPolar,...
    'heightPolar', heightPolar, 'widthStandard', widthStandard,...
    'heightStandard', heightStandard, 'centerX', centerX, 'centerY', centerY);

listClear = {'radiusInt','radiusExt','stepRadius','stepAngle','widthPolar',...
    'heightPolar', 'widthStandard','heightStandard', 'centerX', 'centerY'};

clear(listClear{:}); clear listClear;