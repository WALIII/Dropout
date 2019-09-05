function [pvalD,A1sort,A2sort,Bsort, B_unsort] = DU_PeakSearch(data);

% find peaks in the df/f timeseries for all cells,



% Manual Prams:
thresh = 0.01;
fr = 25; % 25 fps
counter = 1;
frames = 2;
   
   
% zscore data ( use data.all, so it can be seperated into directed, then
% undireledt later..)
for i = 1:size(data.all,3); data.all_z(:,:,i) = (data.all(:,:,i)')';end;


% Identify peaks and putaive spike times in Ca data usein deconvolveCa.m, to constrict where to look
% For regression. Repeat for every day independantly.
for i = 1:size(data.all,3);
    [ c(:,i), s(:,i), options(:,i)] = deconvolveCa(mean(data.all_z(:,:,i),1)-min(mean(data.all_z(:,:,i),1)));
end

 %check it
%   figure();
%     for i = 1: 40;
%       hold on;
%       plot(mean(data.all_z(:,:,i),1)); hold on; plot(s(:,i));
%       pause();
%       clf;
%     end

% Get Peaks in Dff
for i = 1:size(s,2); % for every cell
    clear idx sidx Tidx Gidx
    [pk,idx] = findpeaks(s(:,i),'MinPeakProminence',thresh); % find spike  frame
    %
    for ii = 1:size(idx);
        sidx = idx(ii)./fr; % convert spike to 'time'
        %if idx>frames; % dont go before pad..
        try
            DffHeight(:,counter) = max(squeeze(data.all(:,idx(ii)+1:idx(ii)+frames,i))');%-min(squeeze(data.all(:,:,i))'));
            DffHeight_time(:,counter) = idx(ii);

            for a = 1:size(data.all(:,idx(ii):idx(ii)+frames,i),1);
                x1 = (squeeze(data.all(a,idx(ii):idx(ii)+frames,i))');%-min(squeeze(data.all(a,:,i))'));
                DffIntegrate(a,counter) = trapz(1:length(x1),x1);
            end
        catch
            disp('too close to the end, no pad...');
            DffHeight(:,counter) = max(squeeze(data.all(:,idx(ii):end,i))');%-min(squeeze(data.all(:,:,i))'));
            DffHeight_time(:,counter) = idx(ii);
            for a = 1:size(data.all(:,idx(ii):end,i),1);
                x1 = (squeeze(data.all(a,idx(ii):end,i))');%-min(squeeze(data.all(a,:,i))'));
                DffIntegrate(a,counter) = trapz(1:length(x1),x1);
            end
        end

        %        GIndex(1,counter) = i;
        %        GIndex(2,counter) = ii;
        counter = counter+1;
               % else
      %  end
    end
end

DffHeight = (DffHeight-mean(DffHeight,2));
% Seperate by directed and undirected: 
In_a =  DffHeight(1:size(data.directed,1),:);
In_t =  DffHeight_time(:,:);
In_b =  DffHeight(size(data.directed,1)+1:size(data.all,1),:);
% calculate the variance within each peak time
figure(); hold on; plot(mean(In_a),mean(In_b),'o'); line([-4 4],[-4 4]);



figure(); 
%% Directed
[ta tb] = sort(In_t);
A1 = corr(In_a);
subplot(121)
imagesc(A1(tb,tb),[0 0.7]);
title('Directed peak covariance');

clear  A

%% Undirected
A2 = corr(In_b);
subplot(122)
imagesc(A2(tb,tb),[0 0.7]);
title('Undirected peak covariance');
disp('kk');
% Covariance matrix across songs, for directed and undeirected


figure();

%% Undirected
B= corr(DffHeight);
imagesc(B(tb,tb),[-.0 0.7]);
title('All peak covariance');
disp('kk');


figure();
hold on;
histogram(A1(:),50,'FaceColor','g','Normalization','probability');
histogram(A2(:),50,'FaceColor','m','Normalization','probability');


A1sort = A1(tb,tb);
A2sort = A2(tb,tb);
Bsort = B(tb,tb);
B_unsort = B;

[pvalD,HH1] = ranksum(mean(abs(A1)), mean(abs(A2)));
