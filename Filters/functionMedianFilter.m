function salida = functionMedianFilter( img, window, iter, widthPolar, heightPolar )

g = horzcat(img,img,img);

for it = 1:1:iter
    g = medfilt2(g,[window window],'symmetric');
end

salida = g(:,widthPolar+1:2*widthPolar);

end

