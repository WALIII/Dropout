
% Estimate the number of factors needed to explain the directed and
% undirected data. Nees to rin [data] = FS_Data(calcium,align,Motif_ind,0,32);

% Dd06/08/18


warning off
Ga = data.directed;
Gb = data.undirected;
for i = 1:63
G1= squeeze(Ga(i,:,:))';
[dim_to_use1, result1] = findzdim(G1);
pool1(:,i) = result1.line;

% Randomize...
for ii = 1:size(G1,1)
g2 = randperm(size(G1,2));
C1(ii,:) = smooth(G1(1,g2),4);
end

[dim_to_use3, result3] = findzdim(C1);
pool3(:,i) = result3.line;

try
G2= squeeze(Gb(i,:,:))';
[dim_to_use2, result2] = findzdim(G2);
pool2(:,i) = result2.line;
catch
    
end
end

figure(); hold on; plot(pool1,'g'); plot(pool2,'m'); plot(pool3,'b');
warning on




figure();
col = jet(3);
hold on;
for i = 1:3;
    
    if i ==1;
        adata = pool1';
    elseif i ==2
        adata = pool2';
    else
        adata = pool3';
    end
L = size(adata,2);
se = std(adata);
mn = mean(adata);
 
 
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(i,:)); alpha(1);
plot(mn,'Color',col(i,:));

end



%% interpolate

x = 1:size(pool1,1);
x2 = 1:0.01:size(pool1,1);
p1 = interp1(x,pool1,x2);
p2 = interp1(x,pool2,x2);

clear AA
clear AB
% for i = 1:63;
% [c ind1] = min(abs(0.95-p1(:,i)));
% AA(:,i) = ind1;
% 
% try
% [c ind2] = min(abs(0.95-p2(:,i)));
% AB(:,i) = ind2;
% catch
% end
% end
for i = 1:63;
AA(:,i) = p1(300,i);

try
AB(:,i) = p2(300,i);
catch
end
end

figure();
hold on;
h1 = histogram(AB,'FaceColor','m');
h2 = histogram(AA,'FaceColor','g');
h1.Normalization = 'probability';
h1.BinWidth = 0.018;
h2.Normalization = 'probability';
h2.BinWidth = 0.018;

[h,p] = kstest2(AB,AA);

