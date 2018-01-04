function imgExpanded = functionExpandBorders( img, cantPixeles )
%FUNCTIONEXPANDBORDERS Summary of this function goes here
%   Detailed explanation goes here

imgExpanded = padarray(img,[0 cantPixeles],'symmetric','pre');
%figure('Name','Expand1');
%imshow(imgExpanded/255);

imgExpanded = padarray(imgExpanded,[cantPixeles 0],'symmetric','pre');
%figure('Name','Expand2');
%imshow(imgExpanded/255);

imgExpanded = padarray(imgExpanded,[cantPixeles 0],'symmetric','post');
%figure('Name','Expand3');
%imshow(imgExpanded/255);

imgExpanded = padarray(imgExpanded,[0 cantPixeles],'symmetric','post');
%figure('Name','Expand3');
%imshow(imgExpanded/255);

end

