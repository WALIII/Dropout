function Dat = FS_Compare_SAP(F1,F2);
% compare SAP scores for direct vs undirected song

% F1 = directed
% F2 = Undirected

if gt(size(F2,2),size(F1,2)) ==1;

for i = 1:size(F1,2);
  % AM
  Dat.AM1(i) = mean(F1{i}.AM);
  Dat.AM2(i) = mean(F2{i}.AM);
  % FM
  Dat.FM1(i) = mean(F1{i}.FM);
  Dat.FM2(i) = mean(F2{i}.FM);
  % Entropy
  Dat.Ent1(i) = mean(F1{i}.entropy);
  Dat.Ent2(i) = mean(F2{i}.entropy);

 % Pitch Goodness
  Dat.PG1(i) = mean(F1{i}.pitch_goodness);
  Dat.PG2(i) = mean(F2{i}.pitch_goodness);

  % Pitch
  Dat.P1(i) = mean(F1{i}.pitch);
  Dat.P2(i) = mean(F2{i}.pitch);
end;

else

for i = 1:size(F2,2);
  % AM
  Dat.AM1(i) = mean(F1{i}.AM);
  Dat.AM2(i) = mean(F2{i}.AM);
  % FM
  Dat.FM1(i) = mean(F1{i}.FM);
  Dat.FM2(i) = mean(F2{i}.FM);
  % Entropy
  Dat.Ent1(i) = mean(F1{i}.entropy);
  Dat.Ent2(i) = mean(F2{i}.entropy);

 % Pitch Goodness
  Dat.PG1(i) = mean(F1{i}.pitch_goodness);
  Dat.PG2(i) = mean(F2{i}.pitch_goodness);

  % Pitch
  Dat.P1(i) = mean(F1{i}.pitch);
  Dat.P2(i) = mean(F2{i}.pitch);


end;
end

figure();
bin = 10;

subplot(1,5,1);
histogram(Dat.AM1,bin);
hold on;
histogram(Dat.AM2,bin);
title('AM')

subplot(1,5,2);
histogram(Dat.FM1,bin);
hold on;
histogram(Dat.FM2,bin);
title('FM')

subplot(1,5,3);
histogram(Dat.Ent1,bin);
hold on;
histogram(Dat.Ent2,bin);
title('Entropy')

subplot(1,5,4);
histogram(Dat.PG1,bin);
hold on;
histogram(Dat.PG2,bin);
title('Pitch Goodness')

subplot(1,5,5);
histogram(Dat.P1,bin);
hold on;
histogram(Dat.P2,bin);
title('Pitch ')
legend('Direccted','Undiected')


hold on;
figure(5); 
plot3(dat.PG1,Dat.P1,Dat.FM1,'*','Color',[0.7 .2 0.7]);%[0.7 .5 0.5]
xlabel('Entropy');
ylabel('Entropy');
zlabel('Entropy');
hold on;
plot3(Dat.PG2,Dat.P2,Dat.FM2,'*','Color',[0.1 .7 0.1]); %[0.5 .7 0.5]

title('scatter ')
legend('Direccted','Undiected')
grid on;
