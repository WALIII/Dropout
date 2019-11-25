
function  [mdl] = DU_compute_LinModel(out)

% D3.song = D2.song(1:280,:);
% D3.song_r = D2.song(1:280,:);
% D3.song_w = D2.song_w(1:280,:);
% D3.song_uw = D2.song_uw(1:280,:);
% D3.unsorted = D2.unsorted(1:280,:,:);
% D3.warped_time = D2.warped_time(:,:,1:280);
% D3.index = D2.index(:,280);
% D3.motif_ind = D2.motif_ind(:,1:280);
% D3.song_uwds = D2.song_uwds(1:280,:);
% D3.song_wds = D2.song_wds(1:280,:);
% Gconsensus2{1} = Gconsensus3{1}(:,:,1:280);


% set up things for anova


for i = 1: size(out,2);
    if i ==1;
Df = zscore( mean(out{i}.X_DffHeight_peaks,2));
ST = zscore(mean(out{i}.X_SoundTime_peaks,2));
SS = zscore( mean(out{i}.X_simScore_peaks,2));
 x = (1:length(Df))';
    else
        
tDf = zscore( median(out{i}.X_DffHeight_peaks,2));
tST = zscore(median(out{i}.X_SoundTime_peaks,2));
tSS = zscore( median(out{i}.X_simScore_peaks,2));
 tx = (1:length(tDf))';
 % concat
 Df = cat(1, tDf,Df);
 ST = cat(1, tST,ST);
 SS = cat(1, tSS,SS);
 x = cat(1,tx,x);
    end
end
 
        
 
tbl = table(Df,SS,ST,x,'VariableName',{'Dff','SongSim','SongTime','TimeDay'});
mdl = fitlm(tbl,'SongTime~SongSim+Dff+TimeDay')

mdl = fitlm(tbl,'TimeDay~SongSim+SongTime+Dff')



% gnerate linear fit ( diference in angle btw df/f and song time);

P1 = polyfit(x,Df,1);
P2 = polyfit(x,ST,1);

yfit1 = P1(1)*x+P1(2);
yfit2 = P2(1)*x+P2(2);
a_real = P2(1)-P1(1);

% now shuffle 100 times;
for i = 1: 1000;
    p = randperm(length(x)); % permute the identity of time
    
P1a = polyfit(x,Df(p),1); % refit with random time
P2b = polyfit(x,ST(p),1);

yfit1 = P1a(1)*x+P1a(2);
yfit2 = P2b(1)*x+P2b(2);
a_dist(i) = P1a(1)-P2b(1); % null distribution
end


figure();
hold on
histogram(a_dist,40,'Normalization','probability');
line([a_real a_real], [0 .1], 'LineWidth',2,'Color','r');
title('slope difference of linear fit of dff vs time, and Syllable Length vs time compaerd to a null distribution')



figure();

hold on;
scatter(SS,Df,'o')
P3 = polyfit(SS,Df,2);
x2 = -4:0.1:6;
y2 = polyval(P3,x2);
plot(x2,y2);



figure();

hold on;
scatter(ST,Df,'o')
P3 = polyfit(ST,Df,2);
x2 = -4:0.1:6;
y2 = polyval(P3,x2);
plot(x2,y2);



% compare difference in a to a null ( time shuffled distribution)




