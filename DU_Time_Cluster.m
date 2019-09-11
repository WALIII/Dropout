function [out] = DU_Time_Cluster(DffHeight_time,DffHeight,neighborhood1,neighborhood2)



% Now, sort explicitly by time:
In_t =  DffHeight_time(:,:);
[ta tb] = sort(In_t);


B_unsort= corr(DffHeight);


% Make a timing Matrix:
for i =1:size(DffHeight_time,2)
    
    for ii = 1:size(DffHeight_time,2)     
        Amat(i,ii) = abs((DffHeight_time(i)-DffHeight_time(ii)));
    end
end



% Plot timing matrix:
figure(); imagesc(Amat(tb,tb))
title('timing structure');


A_near_indx = find(Amat>=neighborhood1 & Amat<neighborhood2);
A_far_indx = find(Amat>=neighborhood2);

A_near = B_unsort(A_near_indx);
A_near = A_near(:);

A_far = B_unsort(A_far_indx);
A_far = A_far(:);

% Clear out the autocorrelation
A_near(A_near ==1) = [];
A_far(A_far ==1) = [];


  figure();
 hold on;
histogram(A_near,'BinWidth',0.07,'FaceColor','r','Normalization','probability');
 histogram(A_far ,'BinWidth',0.07,'FaceColor','b','Normalization','probability');
 title(' blue is far');

 
 % export data...
 out.A_near = A_near;
 out.A_far = A_far;
  out.A_near_mean = mean(A_near);
 out.A_far_mean = mean(A_far);
