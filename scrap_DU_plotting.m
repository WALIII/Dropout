
function scrap_DU_plotting(out);

AllDir = [];
AllUnDir = [];
% make all same lenght by padding

len = 24; % final length of vector

for i = 1:size(out.DirX,2)
    
    neuronDirX = out.DirX{i}-min(out.DirX{i});
    neuronUnDirX = out.UnDirX{i}-min(out.UnDirX{i});
    

     L1 = size(neuronDirX,1); % length of neuron
     
if rem(L1, 2) == 1 % remove one from end if not even
    neuronDirX = neuronDirX(1:end-1,:);
    neuronUnDirX = neuronUnDirX(1:end-1,:);
else 
end

L1 =  size(neuronDirX,1); % length of neuron

diff = len-L1; % get difference between final length and actual

pad = zeros(diff/2,size(neuronDirX,2));% create pad

% Add pad for Directed
neuronDirX2 = cat(1,pad,neuronDirX);
neuronDirX2 = cat(1,neuronDirX2,pad);

% Add pad for UnDirected
neuronUnDirX2 = cat(1,pad,neuronUnDirX);
neuronUnDirX2 = cat(1,neuronUnDirX2,pad);

N_adjusted{i}.neuronUnDirX2 = neuronUnDirX2;
N_adjusted{i}.neuronDirX2 = neuronDirX2;

% concat to one big matrix:
try
  mean_neuronDirX2 = median(neuronDirX2,2);
  mean_neuronUnDirX2 = median(neuronUnDirX2,2);

AllDir = cat(2,AllDir,mean_neuronDirX2);
AllUnDir = cat(2,AllUnDir,mean_neuronUnDirX2);
 catch
    disp('ERROR');
    AllDir = mean_neuronDirX2;
    AllUnDir = mean_neuronUnDirX2;
 end
end





%% Plotting
plotting = 1;
if plotting ==1;
Dat1{1} = AllDir;
Dat1{2} = AllUnDir;

col = {'g','m'};

figure(); 
hold on;
for i = 1:2;
% smooth data
adata = (Dat1{i})'; % data matrix
L = size(adata,2);
se = std(adata); % 1/2 STD. can use std, or SEM if you must: sqrt(length(adata));
mn = mean(adata);
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col{i}); alpha(0.3);
plot(mn,'Color',col{i});
end
end

ylabel('Df/f')
xlabel('pixels');




%% Calc FWHM
zAllDir = (Dat1{1})';
zAllDir2 = (Dat1{2})';
warning off
for i = 1: size(zAllDir,1);
    aa = zAllDir(i,:);
    w(i) = fwhm(1:length(aa),aa);
    clear aa
end
for i = 1: size(zAllDir2,1);
    aa2 = zAllDir2(i,:);
    w2(i) = fwhm(1:length(aa2),aa2);
    clear aa
end
warning on;
figure();
hold on;
histogram(w,'BinWidth',1,'FaceColor','g','normalization','probability');
histogram(w2,'BinWidth',1,'FaceColor','m','normalization','probability');
figure();
plot(w,w2,'o');



[stats,~] = ranksum(w, w2)



