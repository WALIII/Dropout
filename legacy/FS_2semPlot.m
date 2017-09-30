function FS_2semPlot(Dat,indX) % index

% use 'data'from [data] = FS_Format_Directed(directed, undirected)

% Dat.undirected = zscore(Dat.undirected(:,:,:),1,2);
% Dat.directed = zscore(Dat.directed,1,2);

figure();
shift = 4.5;
counter = 1;
for i = indX(1:end)' 
cell = i;%index(i);
hold on;



G = Dat.undirected;

data = squeeze(G(:,1:end,cell));
L = size(data,2)
se = std(data)/2;%sqrt(length(data));
mn = mean(data)-counter*shift;

plot(mn,'m');
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],'m'); alpha(.5)
set(h,'EdgeColor','None');
hold on;


G = Dat.directed;
data = squeeze(G(:,1:end,cell));
L = size(data,2)
se = std(data)/2;%sqrt(length(data));
mn = mean(data)-counter*shift;

hold on;
plot(mn,'g');
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],'g'); alpha(.5)
set(h,'EdgeColor','None');

counter = counter+1;

end
axis off;
