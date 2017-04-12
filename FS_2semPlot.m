function FS_2semPlot(Dat) % index

% use 'data'from [data] = FS_Format_Directed(directed, undirected)
figure(); 

for i = 1:15; 
cell = i;%index(i);
hold on;



G = Dat.undirected;

data = squeeze(G(:,3:end,cell));
L = size(data,2)
se = std(data)/2;%sqrt(length(data));
mn = mean(data)+i*2;
 
plot(mn,'m');
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],'m'); alpha(.5)
set(h,'EdgeColor','None');
hold on;


G = Dat.directed;
data = squeeze(G(:,3:end,cell));
L = size(data,2)
se = std(data)/2;%/sqrt(length(data));
mn = mean(data)+i*2;

hold on;
plot(mn,'g');
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],'g'); alpha(.5)
set(h,'EdgeColor','None');



end
axis off;

