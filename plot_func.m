close all
for j=1:1:18
imagesc(squeeze(H(:,:,1,j)))
set(gca, 'YDir', 'normal')
 set(gca, 'XTick', 1:12)
 set(gca, 'YTick', 1:12)
 set(gca, 'XTickLabels', electrodes_cut)
 set(gca, 'YTickLabels', electrodes_cut)
title(1+j)
pause(10)
end


 set(gca, 'XTickLabels', 1:5)
 set(gca, 'YTickLabels', 1:5)