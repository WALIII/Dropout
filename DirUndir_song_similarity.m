
function Fin = DirUndir_song_similarity(DataD,DataU)
% Get Sim Scores

ii = 4;
for i = 1:size(DataD.WARPED_TIME{ii},2) % for all trials
%   Audio Stretch formating
GG_d = DataD.WARPED_TIME{ii}{i}(1,:)-DataD.WARPED_TIME{ii}{i}(2,:); %differences in timing
%GG2_d(counter,:) = diff(GG_d); % Take the derivative of the vector, to get moments of change
GG2_d2(:,i) = (sum(abs(GG_d)));

end;
Fin1(1,:) = GG2_d2; % timing difference vector
Fin1(2,:) = DataD.sim_score{ii}; % spectral difference vector

ii = 4;
for i = 1:size(DataU.WARPED_TIME{ii},2) % for all trials
%   Audio Stretch formating
GG_d = DataU.WARPED_TIME{ii}{i}(1,:)-DataU.WARPED_TIME{ii}{i}(2,:); %differences in timing
%GG2_d(counter,:) = diff(GG_d); % Take the derivative of the vector, to get moments of change
GG2_d2(:,i) = (sum(abs(GG_d)));

end;
Fin2(1,:) = GG2_d2; % timing difference vector
Fin2(2,:) = DataU.sim_score{ii}; % spectral difference vector



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

Fin = 0;