


figure(); 
hold on;
plot3(dat1.PG2,dat1.P2,dat1.FM2,'*','Color',[0.7 .2 0.7]);%[0.7 .5 0.5]
plot3(dat2.PG2,dat2.P2,dat2.FM2,'*','Color',[1 0 1]);%[0.7 .5 0.5]

plot3(dat1.PG1,dat1.P1,dat1.FM1,'*','Color',[0.2 .7 0.2]); %[0.5 .7 0.5]
plot3(dat2.PG1,dat2.P1,dat2.FM1,'*','Color',[0 1 0]); %[0.5 .7 0.5]

xlabel('Entropy');
ylabel('Entropy');
zlabel('Entropy');

title('scatter ')
legend('Direccted','Undiected')
grid on;