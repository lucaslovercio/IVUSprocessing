function [ mapScoresLumen, mapScoresBackground ] = functionGetScoreMaps( imgPolar, ParametersSet )

disp('Computing image features');
disp('GLCM Features - Time consuming task!');
window = 15;
haralicks = functionHaralickTextureFeatures( imgPolar, window, ParametersSet.widthPolar, ParametersSet.heightPolar );
haralicks.angularSecondMoment = (haralicks.angularSecondMoment - mean(haralicks.angularSecondMoment(:))) / std(haralicks.angularSecondMoment(:));
haralicks.entropy = (haralicks.entropy - mean(haralicks.entropy(:))) / std(haralicks.entropy(:));

haralicksRadial = functionHaralickTextureFeaturesRadial( imgPolar, window, ParametersSet.widthPolar, ParametersSet.heightPolar );
haralicksRadial.contrastRadial = (haralicksRadial.contrastRadial - mean(haralicksRadial.contrastRadial(:))) / std(haralicksRadial.contrastRadial(:));

disp('Median filter');
window = 7; it = 25;
median_ = functionMedianFilter( imgPolar, window, it, ParametersSet.widthPolar, ParametersSet.heightPolar );
median_ = (median_ - mean(median_(:))) / std(median_(:));

disp('Maximum smoothed intensity');
Unal2008 = functionModifiedIntensity( imgPolar, ParametersSet.widthPolar, ParametersSet.heightPolar );
Unal2008 = (Unal2008 - mean(Unal2008(:))) / std(Unal2008(:));

disp('Distance From Catheter');
columna = 1:1:ParametersSet.heightPolar;
columna = columna';
distanceFromCatheter = double(repmat(columna,1,ParametersSet.widthPolar));
distanceFromCatheter = (distanceFromCatheter - mean(distanceFromCatheter(:))) / std(distanceFromCatheter(:));

%Score maps
wSVMLumenNoLumen = [-0.8093 0.2264 0.1992];
bSVMLumenNoLumen = -0.4526;

wSVMBackground = [-0.7954 -0.3720 0.0781 0.2892 -0.3436 0.2497];
bSVMBackground = -0.1894;

vectorFeaturesLumen = horzcat(Unal2008(:), imgPolar(:), haralicks.angularSecondMoment(:));
scoresLumen = wSVMLumenNoLumen*vectorFeaturesLumen' + bSVMLumenNoLumen;
mapScoresLumen = vec2mat(scoresLumen,ParametersSet.heightPolar)';

vectorFeaturesBackground = horzcat(Unal2008(:), distanceFromCatheter(:), haralicksRadial.contrastRadial(:),...
    imgPolar(:), median_(:), haralicks.entropy(:));
scoresBackground = wSVMBackground*vectorFeaturesBackground' + bSVMBackground;
mapScoresBackground = vec2mat(scoresBackground,ParametersSet.heightPolar)';

functionShowScoreMap( mapScoresLumen, 'Lumen classification' );
functionShowScoreMap( mapScoresBackground, 'Background classification' );

end
