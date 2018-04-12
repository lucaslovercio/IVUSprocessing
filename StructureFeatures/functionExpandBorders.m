function imgExpanded = functionExpandBorders( img, cantPixeles )
%FUNCTIONEXPANDBORDERS Summary of this function goes here
%   Detailed explanation goes here

imgExpanded = padarray(img,[0 cantPixeles],'symmetric','pre');

imgExpanded = padarray(imgExpanded,[cantPixeles 0],'symmetric','pre');

imgExpanded = padarray(imgExpanded,[cantPixeles 0],'symmetric','post');

imgExpanded = padarray(imgExpanded,[0 cantPixeles],'symmetric','post');

end

