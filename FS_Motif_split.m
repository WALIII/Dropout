
function [Tally, C] = FS_Motif_split()

% run in exreaction directory

DIR = pwd;
N=1024;
NOVERLAP=1e3;
DOWNSAMPLE=5;
fs = 48000;


DIR = pwd;
load(fullfile(DIR,'cluster_results.mat'),'sorted_syllable');
load(fullfile(DIR,'cluster_data.mat'),'filenames');
counter = 1;
counter2 = 1;
% Tally = zeros(10,100000);







% Get Mic Data
cd ../
mov_listing=filenames;

counter2 = 1;
for i=1:length(mov_listing)
load(mov_listing{i},'audio')
mic_data{i} = audio.data;
clear audio.data
end


      
for i = 1:length(mov_listing);
    
     try
St_cut = abs(sorted_syllable{i}(1)*((N-NOVERLAP)*DOWNSAMPLE)-N);
     catch
          continue
     end
    
GG = find(diff(sorted_syllable{i})>5000);
GG = GG+1; % cut infront of the next block.

% try
% if St_cut == GG(1);
%     GG(1) = [];
% end
% catch
% end


if size(GG,1) >= 1;
M_cuts = (sorted_syllable{i}(GG)*((N-NOVERLAP)*DOWNSAMPLE)-N);
CUTS = horzcat(St_cut,M_cuts',length(mic_data{i}));
clear St_cut;
else 
    CUTS = horzcat(St_cut,length(mic_data{i}));
end

C{1,counter2} = CUTS;
C{2,counter2} = mov_listing{i};
counter2 = counter2+1;
% } = mic_data{i}(St_cut:M_cuts(1));
% %Tally(counter,1:size(})) = };
% Tally{counter} = };


for ii = 2:size(CUTS,2);

    temp = mic_data{i}(CUTS(ii-1):CUTS(ii));
    %Tally(counter,1:size(temp)) = temp;
    Tally{counter} = temp';

    clear temp
    counter = counter+1;

        

end


end


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

cd(DIR);
end


%figure(); imagesc(Tally(1:10000));

