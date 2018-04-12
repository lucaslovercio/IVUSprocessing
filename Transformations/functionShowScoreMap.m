function hFig = functionShowScoreMap( mapScores, strScoreMap )

    hFig = figure('Name',strScoreMap, 'Position', [100, 100, 1049, 895]);
    set(gca,'FontName', 'Times New Roman');
    set(gcf, 'Color', 'w');

    limit_ = 1.5;
    
    hold on;
    caxis([-limit_,limit_]);
    [C,h] = contourf(flipud(mapScores),120);
    set(h,'LineColor','none');
    set(gca, 'DataAspectRatio', [1 1 1]);
    [redColorMap,greenColorMap,blueColorMap] = functionLoadDivergingMapFromCSV();
    colorMap = [redColorMap, greenColorMap, blueColorMap]./256;
    colormap(colorMap);
    set(gca, 'YTick', []);
    set(gca, 'XTick', []);    
    colorbar;

    hold off;
   

end

