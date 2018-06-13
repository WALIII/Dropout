for cells = 1: 53
G = squeeze(data.directed(:,:,cells)'); 
GG_D(cells,:) = (G(:));
clear G

G = squeeze(data.undirected(:,:,cells)'); 
GG_U(cells,:) = (G(:));
clear G

G = squeeze(data_n.directed(:,:,cells)'); 
GG_N(cells,:) = (G(:));
clear G


end
% Calculate SNR


(max(GG_D(1))-min(GG_D(1,:)))./std(GG_D(1,:))
(max(GG_U(1))-min(GG_U(1,:)))./std(GG_U(1,:))
(max(GG_N(1))-min(GG_N(1,:)))./std(GG_N(1,:))
