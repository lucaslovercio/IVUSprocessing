function [polarImageMarkedRout,polarImageMarkedGout,polarImageMarkedBout,...
    cartesianImageMarkedR,cartesianImageMarkedG,cartesianImageMarkedB] =...
    functionMarkArtifactsInImage(polarOriginalImage,...
    branchCandidate, shadows, colsEchoPlaque, ParametersSet, markBorder)

red = [180 0 0]./255; green = [0 180 0]./255;
lightblue = [50 50 180]./255;

[hL,wL] = size(branchCandidate);
if hL>wL %traspose
    branchCandidate = branchCandidate';
    shadows = shadows';
    colsEchoPlaque = colsEchoPlaque';
end

branchCandidate = repmat(branchCandidate,ParametersSet.heightPolar,1);
shadows = repmat(shadows,ParametersSet.heightPolar,1);
colsEchoPlaque = repmat(colsEchoPlaque,ParametersSet.heightPolar,1);

polarImageMarkedR = polarOriginalImage; polarImageMarkedRout = polarOriginalImage;
polarImageMarkedG = polarOriginalImage; polarImageMarkedGout = polarOriginalImage;
polarImageMarkedB = polarOriginalImage; polarImageMarkedBout = polarOriginalImage;

if not(markBorder)
    
    %Bifurcations -> red
    polarImageMarkedRout(branchCandidate>0) = polarImageMarkedR(branchCandidate>0).*1.3 + 0.1;
    
    %Shadows -> green
    polarImageMarkedGout(shadows>0) = polarImageMarkedG(shadows>0).*1.3 + 0.1;
    
    %EP -> blue
    polarImageMarkedBout(colsEchoPlaque>0) = polarImageMarkedB(colsEchoPlaque>0).*1.3 + 0.1;
    
else
       %Different color map! SIPAIM 2016
    border3 = edge(colsEchoPlaque>0,'Canny');
    border3(end,:) = colsEchoPlaque(end,:)>0;
    border3(end-1,:) = colsEchoPlaque(end,:)>0;
    border3(1,:) = colsEchoPlaque(1,:)>0;
    polarImageMarkedRout(border3) = green(1);
    polarImageMarkedGout(border3) = green(2);
    polarImageMarkedBout(border3) = green(3);
    
    border1 = edge(branchCandidate>0,'Canny');
    border1(end,:) = branchCandidate(end,:)>0;
    border1(end-1,:) = branchCandidate(end,:)>0;
    border1(1,:) = branchCandidate(1,:)>0;
    polarImageMarkedRout(border1) = red(1);
    polarImageMarkedGout(border1) = red(2);
    polarImageMarkedBout(border1) = red(3);
    
    border2 = edge(shadows>0,'Canny');
    border2(end,:) = shadows(end,:)>0;
    border2(end-1,:) = shadows(end,:)>0;
    border2(1,:) = shadows(1,:)>0;
    polarImageMarkedRout(border2) = lightblue(1);
    polarImageMarkedGout(border2) = lightblue(2);
    polarImageMarkedBout(border2) = lightblue(3);
    
end

polarImageMarkedRout(polarImageMarkedRout>1)=1;
polarImageMarkedGout(polarImageMarkedGout>1)=1;
polarImageMarkedBout(polarImageMarkedBout>1)=1;

cartesianImageMarkedR = functionToCartesian(polarImageMarkedRout, ParametersSet);
cartesianImageMarkedG = functionToCartesian(polarImageMarkedGout, ParametersSet);
cartesianImageMarkedB = functionToCartesian(polarImageMarkedBout, ParametersSet);

end

