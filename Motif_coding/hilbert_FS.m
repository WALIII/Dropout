function [Tally2 idx] = hilbert_FS(Tally);

for i = 1: size(Tally);
Tally_f = FS_audio_filter(Tally(i,:));
envelope = abs(hilbert(Tally_f'));
yupper = tsmovavg(envelope','s',100);
clear Tally_f;
Tally2(i,:) = yupper;

clear envelope;
clear yupper;

end


% linkage
Tally3 = Tally2(1:size(Tally2,1),3e4:end-2e4);% 1.5e5


l = linkage(Tally3, 'ward', 'correlation');
% find clusters
clusters = cluster(l, 'maxclust', 5);


[~, idx] = sort(clusters);

Tally4 = Tally3(idx, :);
figure(); 
subplot(2,1,1);
imagesc(zscore(Tally3,1,2));
subplot(2,1,2);
 imagesc(Tally4);
 colormap(hot);



%
% [~, idx] = sort(clusters);
%   
% [Ind] = mean(Tally3, 2);
% [dummy, index] = sort(Ind);
% 
% Tally4  = Tally3(index, :);



