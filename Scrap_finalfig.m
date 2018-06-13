function Scrap_finalfig(audioVect2,Motif_ind)

clear D
clear U
c1 = 1;
c2 = 1;
for i = 1:103;
    
    if Motif_ind(3,i) == 1;
        D(:,c1) = audioVect2(:,i);
        c1 = c1+1;
    else
        U(:,c2) = audioVect2(:,i);
        c2 = c2+1;
    end
end

figure(); imagesc(audioVect2')

figure(); imagesc(D')
title('directed Uncleaned')
figure(); imagesc(U')
title('Undirected Uncleaned')



D(:,[11 16 17]) = [];
U(:,[10 11 12 22]) = [];

figure(); imagesc(D')
title('directed')
figure(); imagesc(U')
title('Undirected')



figure(); 
hold on;
plot(D,'g')
plot(U,'m')




figure(); 

plot(D,'g')
hold on; 
counter = 1;
for i = [2 18 20]
plot(D(:,i),'b')
GT(:,counter) = D(:,i);
counter = counter+1;
end


figure(); imagesc(GT')

plot(U,'m')
hold on; 

for i = [10 20 ]
plot(U(:,i),'b')
end




