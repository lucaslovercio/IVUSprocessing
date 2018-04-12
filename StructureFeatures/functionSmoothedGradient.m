function Gsmooth = functionSmoothedGradient( imgPolar, dx, dy )

% Gsmooth Unal et al Eq. 8
[h,w]=size(imgPolar);
anchoVentana = 2*dx+1;
ventana = ones(dy,anchoVentana);

g = horzcat(imgPolar,imgPolar,imgPolar);

g = functionExpandBorders(g,dy);

suma = conv2(g,ventana,'same');

suma=suma(dy+1:end-dy,dy+1:end-dy);

distXYtoCenterBox = (dy+1)/2;
distBetCentreBoxes = 2 * distXYtoCenterBox;

%Central pixel
Gsmooth = circshift(suma,[-distBetCentreBoxes ,0]) - suma;
Gsmooth = circshift(Gsmooth,[distXYtoCenterBox ,0]); 
Gsmooth = Gsmooth/(anchoVentana*dy);
Gsmooth = Gsmooth(:,w+1:2*w);
Gsmooth(1:dy,:)=0;Gsmooth(end-dy:end,:)=0;

end

