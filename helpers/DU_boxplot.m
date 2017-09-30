function [stats] = DU_boxplot(data)

% Get the Baseline

v1 = mean(data.directed(:,1:end,end-1),2);
v2 = mean(data.undirected(:,1:end,end-1),2);

figure(); 
boxplot([v1(1:49),v2(1:49)],'Notch','on');