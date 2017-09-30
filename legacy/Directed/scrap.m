function scrap1(SortedCell);
counter = 1;

for i = 1:18
D1(:,i) = mean(var(squeeze(SortedCell(i,1:100,:))));
end

for i = 80:98
D2(:,counter) = mean(var(squeeze(SortedCell(i,1:100,:))));
counter = counter+1;
end

figure(); 
plot(ones(1,length(D1)),D1,'r*');
hold on;
plot(ones(1,length(D2))+1,D2,'b*');
xlim([0 3]);


