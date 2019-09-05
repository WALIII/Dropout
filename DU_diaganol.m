function DU_diaganol(Input_Mat);

% Input_Mat is Bmat from DU_PeakSearch!


for iii = 1:6
TT = Input_Mat{iii};

bound = 5;

TTrep = TT;
counter = 1;
% get local correlations
    for ii = -bound:bound
   temp = diag(TT,ii);
   if counter ==1;
   Ttot = temp;
   counter = 2;
   else
       Ttot = cat(1,Ttot(:),temp);
   end
    end
       
    
   far1 = triu(TT,bound);
   far2 = triu(TT,-bound);
   far_tot = cat(1,far1(:),far2(:));
   
   Near = Ttot(:);
   Near(Near ==1) = [];
    far_tot(far_tot ==1) = [];

   far_tot(far_tot ==0) = [];
   Far = far_tot;
% figure();
% hold on;
% histogram(Near,20,'FaceColor','r','Normalization','probability');
% histogram((far_tot(:)),20,'FaceColor','b','Normalization','probability');
% title(' blue is far');

if iii == 1;
    Nsum =  Near;
    Fsum = Far;
else
    cat(1,Nsum,Near);
    cat(1,Fsum,Far);
    
end

clear Near Far;
end
    
 figure();
 hold on;
histogram(Nsum,20,'FaceColor','r','Normalization','probability');
 histogram((Fsum),20,'FaceColor','b','Normalization','probability');
 title(' blue is far');
 
 
  figure();
 hold on;
histogram(Nsum,20,'FaceColor','r','Normalization','probability');
 histogram((Fsum),20,'FaceColor','b','Normalization','probability');
 title(' blue is far');
 
 
    
    