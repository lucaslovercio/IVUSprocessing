function Gsmooth = functionSmoothedGradient( imgPolar, dx, dy )
%FUNCTIONSMOOTHEDGRADIENT Summary of this function goes here
%   Detailed explanation goes here

% Gsmooth Unal Eq. 8
[h,w]=size(imgPolar);
anchoVentana = 2*dx+1;
ventana = ones(dy,anchoVentana);
%Continuidad en los bordes
g = horzcat(imgPolar,imgPolar,imgPolar);
%size(g)
g = functionExpandBorders(g,dy);
%size(g)
suma = conv2(g,ventana,'same');
%size(suma)
suma=suma(dy+1:end-dy,dy+1:end-dy);
%size(suma)
distXYaCentroBox = (dy+1)/2;
distEntreCentroBoxes = 2 * distXYaCentroBox;

%Ahora debo restar en el pixel que representa el centro de la ventana
Gsmooth = circshift(suma,[-distEntreCentroBoxes ,0]) - suma;
Gsmooth = circshift(Gsmooth,[distXYaCentroBox ,0]); 
Gsmooth = Gsmooth/(anchoVentana*dy);
Gsmooth = Gsmooth(:,w+1:2*w);
Gsmooth(1:dy,:)=0;Gsmooth(end-dy:end,:)=0;

end

