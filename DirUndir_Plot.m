function DirUndir_Plot(DataD,DataU)




im1 = mean(DataD.Gconsensus{1}{1},3);
im2 = mean(DataD.Gconsensus{3}{1},3);
im3 = mean(DataD.Gconsensus{4}{1},3);
figure(1);
subplot(2,1,1);
XMASS_song(im1(:,:),im2(:,:),im3(:,:));
hold on;

% figure();
% scrapPlot(DataU.S_diff)
% figure
% scrapPlot(DataU.A_diff)

% Internal comparison, 
figure(1);
subplot(2,1,2);
im4 = mean(DataU.Gconsensus{1}{1},3);
im5 = mean(DataU.Gconsensus{3}{1},3);
im6 = mean(DataU.Gconsensus{4}{1},3);
XMASS_song(im4(:,:),im5(:,:),im6(:,:));

% figure();
% scrapPlot(DataU.S_diff)
% figure
% scrapPlot(DataU.A_diff)





% Compariosn

figure(10);
subplot(2,1,1);
XMASS_song(im4(:,:),im1(:,:),im4(:,:));
hold on;
subplot(2,1,2);
XMASS_song(im6(:,:),im3(:,:),im6(:,:));


Comp1{1} = DataD.S_diff{1};
Comp1{2} = DataU.S_diff{1};
figure();
scrapPlot(Comp1)



% concat all 

  for iii = 1:size(DataD.Gconsensus,2)
  if iii == 1
      c_aggD = DataD.Gconsensus{1,iii}{1};
      c_aggU = DataU.Gconsensus{1,iii}{1};
  else
      c_aggD = cat(3,c_aggD,DataD.Gconsensus{1,iii}{1});
      c_aggU = cat(3,c_aggU,DataU.Gconsensus{1,iii}{1});
  end
  end
  
im7 = mean(c_aggD,3);
im8 = mean(c_aggU,3);

figure();
XMASS_song(im8(:,:),im7(:,:),im8(:,:));



end

