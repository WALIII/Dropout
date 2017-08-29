


function [sim_score, vector_score] = FS_song_dff(consensus)
% FSA3_Get_Mean_Scores
%
% Created: 05/20/16
% Updated: 05/23/16
% WALIII

% Use for freedomscope birds. Wrapper is 'Plot_SDI_Comparison'

%==============================================%
% Convert if in the freedomsScope format.

if iscell(consensus)==1
   for i = 1:size(consensus,2)
        consensus2(:,:,i) = consensus{i};
   end
    consensus = consensus2;
end

clear sim_score; clear Mean_c;

% Get Mean of mic data ( similar to spectral density image)
Mean_c = mean(consensus,3);
Mean_c2 = mean(consensus,3);

% Compare to the days's contour to the SDI
for i = 1:size(consensus,3)
    %sim_score(i)=norm(consensus(:,:,i).*Mean_c)/sqrt(norm(consensus(:,:,i)).*norm(Mean_c));
sim_score(i)= sum(sum(consensus(:,:,i).*Mean_c2))./sqrt(sum(sum(consensus(:,:,i).^2)).*sum(sum(Mean_c2.^2)));
vector_score(:,i) =  (sum(consensus(:,:,i).*Mean_c2))./sqrt((sum(consensus(:,:,i).^2)).*(sum(Mean_c2.^2)));

end
