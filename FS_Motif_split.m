
function Tally = FS_Motif_split()


N=1024;
NOVERLAP=1e3;
DOWNSAMPLE=5;
fs = 48000;


DIR = pwd;
load(fullfile(DIR,'cluster_results.mat'),'sorted_syllable');
counter = 1;
% Tally = zeros(10,100000);







% Get Mic Data
cd ../
mov_listing=dir(fullfile(pwd,'*.mat'));
mov_listing={mov_listing(:).name};

counter2 = 1;
for i=1:length(mov_listing)
load(mov_listing{i},'audio')
mic_data{i} = audio.data;
clear audio.data
end


      
for i = 1:59;
    
     try
St_cut = (sorted_syllable{i}(1)*((N-NOVERLAP)*DOWNSAMPLE)-N);
      catch
          continue
     end
    
GG = find(diff(sorted_syllable{i})>500);
GG = GG+1;

try
if St_cut == GG(1);
    GG(1) = [];
end
catch
end


if size(GG,1) >= 1;
M_cuts = (sorted_syllable{i}(GG)*((N-NOVERLAP)*DOWNSAMPLE)-N)

% } = mic_data{i}(St_cut:M_cuts(1));
% %Tally(counter,1:size(})) = };
% Tally{counter} = };

CUTS = horzcat(St_cut,M_cuts');
clear St_cut;
for ii = 1:size(CUTS,2);
    try
    temp = mic_data{i}(CUTS(ii):CUTS(ii+1));
    %Tally(counter,1:size(temp)) = temp;
    Tally{counter} = temp';

    clear temp
    counter = counter+1;
    catch
        temp = mic_data{i}(CUTS(ii):end);
        %Tally(counter,1:size(temp)) = temp;
        Tally{counter} = temp';

        clear temp
        counter = counter+1;
    end
end

else % if only one detection,
    try
    temp = mic_data{i}(St_cut:end);
    %Tally(counter,1:size(temp)) = temp;
    Tally{counter} = temp';

    clear temp
    counter = counter+1; 
    catch
        continue
    end;
end
end

%figure(); imagesc(Tally(1:10000));



% very simple example
% assumes each entry in a is a row vector
a = Tally;

% figure out longest
max_length = max(cellfun(@length, a));

% extend
a_extended = cellfun(@(x) [x zeros(1, max_length - length(x))], a, 'UniformOutput', false);

% concatenate
a_matrix = cat(1, a_extended{:});
clear Tally
Tally = a_matrix;


% Z = linkage(meas,'ward','euclidean');
% c = cluster(Z,'maxclust',4);

% linkage





% mic_data = abs(hilbert(mic_data));
% y = tsmovavg(mic_data','s',10)*10000;
% 
%       A(1:size(y,2),i) = y';
%       
%       clear y;
%       clear mic_data;
% 
%   end