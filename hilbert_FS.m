% for i = 1: size(Tally);
%     
% envelope = abs(hilbert(Tally(i,:)'));
% yupper = tsmovavg(envelope','s',10)*10000;
% 
% Tally2(i,:) = yupper;
% 
% clear envelope;
% clear yupper;
% 
% end


% linkage
Tally3 = Tally2(1:45,10:1.4e5);% 1.5e5

l = linkage(Tally3, 'average', 'correlation');
% find clusters
clusters = cluster(l, 'maxclust', 6);


[~, idx] = sort(clusters);

Tally4 = Tally3(idx, :);
figure(); 
subplot(2,1,1);
imagesc(Tally3);
subplot(2,1,2);
imagesc(Tally4);



%
% [~, idx] = sort(clusters);
%   
% [Ind] = mean(Tally3, 2);
% [dummy, index] = sort(Ind);
% 
% Tally4  = Tally3(index, :);



