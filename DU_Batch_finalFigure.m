function [Fdat, Fout] = DU_Batch_finalFigure();


mov_listing=dir(fullfile(pwd,'*.mat'));
mov_listing={mov_listing(:).name};


filenames=mov_listing;


disp('Creating Dff movies');

[nblanks formatstring]=fb_progressbar(100);
fprintf(1,['Progress:  ' blanks(nblanks)]);

for i=1:length(mov_listing)
    
    % load in data
    load(fullfile(pwd,mov_listing{i}),'Motif_ind','align','calcium');
    
    [data] = FS_Data(calcium,align,Motif_ind,0,30);
    
    
    
    [stats, output] =  DU_CorrMatrix(data,0);
    
    Fdat{i} = data; % data aggregator
    Fout{i} = output; % Corr Matrix aggregator
    Fstats{i} = stats;
    clear data
    clear output
    clear stats
end

figure(); 
D = 0;
U = 0;
for i = [1 2 3 4 5 6 7]
    hold on;     
plot(mean(Fout{i}.A),mean(Fout{i}.B),'o');
D = [D  Fout{i}.B(:)'];
U = [U  Fout{i}.A(:)'];
end

plot(zeros(3,1),-1:1,'r--');
plot(-1:1,zeros(3,1),'r--');
plot([0 1], [0 1],'b--');
xlim([-0.5 1]);
ylim([-0.5 1]);


GG = lines(10);

figure(); 
for i = 1:7
    hold on;     
plot((Fout{i}.A),(Fout{i}.B),'o','Color',GG(i,:));
end
plot(zeros(3,1),-1:1,'r--');
plot(-1:1,zeros(3,1),'r--');
plot([0 1], [0 1],'b--');
xlim([-0.8 1]);
ylim([-0.8 1]);
title('All to All');


figure();
hold on;
h1 = histogram(abs(U),20,'FaceColor','m');
h2 = histogram(abs(D),20,'FaceColor','g');
h1.Normalization = 'probability';
h2.Normalization = 'probability';



% figure();
% hold on;
% 
% h1 = histogram(Fout{1}.B-Fout{1}.A,50,'FaceColor',GG(1,:));
% h2 = histogram(Fout{2}.B-Fout{2}.A,50,'FaceColor',GG(2,:));
% h3 = histogram(Fout{3}.B-Fout{3}.A,50,'FaceColor',GG(3,:));
% h4 = histogram(Fout{4}.B-Fout{4}.A,50,'FaceColor',GG(4,:));
% h5 = histogram(Fout{5}.B-Fout{5}.A,50,'FaceColor',GG(5,:));
% h6 = histogram(Fout{6}.B-Fout{6}.A,50,'FaceColor',GG(6,:));
% h7 = histogram(Fout{7}.B-Fout{7}.A,50,'FaceColor',GG(7,:));
% 
% 
% h1.Normalization = 'probability';
% h2.Normalization = 'probability';
% h3.Normalization = 'probability';
% h4.Normalization = 'probability';
% h5.Normalization = 'probability';
% h6.Normalization = 'probability';
% h7.Normalization = 'probability';
% 
%     
%     
    
    