
function Fin = DirUndir_song_similarity(DataD,DataU)
% Get Sim Scores

counter = 1;
for ii = 1:4;
for i = 1:size(DataD.WARPED_TIME{ii},2) % for all trials
%   Audio Stretch formating
GG_d = DataD.WARPED_TIME{ii}{i}(1,:)-DataD.WARPED_TIME{ii}{i}(2,:); %differences in timing
%GG2_d(counter,:) = diff(GG_d); % Take the derivative of the vector, to get moments of change
GG2_d2(:,counter) = (sum(abs(GG_d)));
counter = counter+1;
end;
end
Fin1(1,:) = GG2_d2; % timing difference vector
Fin1(2,:) = cat(2,DataD.sim_score{1:4}); % spectral difference vector

counter = 1;
for ii = 1:4
for i = 1:size(DataU.WARPED_TIME{ii},2) % for all trials
%   Audio Stretch formating
GG_d = DataU.WARPED_TIME{ii}{i}(1,:)-DataU.WARPED_TIME{ii}{i}(2,:); %differences in timing
%GG2_d(counter,:) = diff(GG_d); % Take the derivative of the vector, to get moments of change
GG2_d2(:,counter) = (sum(abs(GG_d)));
counter = counter+1;
end;
end;



Fin2(1,:) = GG2_d2; % timing difference vector
Fin2(2,:) = cat(2,DataU.sim_score{1:4}); % spectral difference vector



figure();
hold on;
for i = 4
  plot(Fin1(1,:),Fin1(2,:),'*');
end


figure();
hold on;
g = colormap(hsv(10));
for i = 4
  scatter(Fin1(1,:),Fin1(2,:),[],'m','Marker','*');
  scatter(Fin2(1,:),Fin2(2,:),[],'g','Marker','o');
end
xlim([ 0 150])


figure();
hold on;
edges = [-10 0:100:150 400];

h1 = histogram(Fin1(1,:),edges);
h2 = histogram(Fin2(1,:),edges);

h1.Normalization = 'probability';
h1.BinWidth = 7;
h2.Normalization = 'probability';
h2.BinWidth = 7;
xlim([ 0 150])


figure();
hold on;

% optional Cutoff
T1 = Fin1(Fin1(2,:)<=0.4) = [])
T2 = Fin2(Fin1(2,:)<=0.4) = [])

h3 = histogram(T1);
h4 = histogram(T2);

h3.Normalization = 'probability';
h3.BinWidth = 0.025;
h4.Normalization = 'probability';
h4.BinWidth = 0.025;

xlim([ 0.4 0.7])

Fin = 0;
