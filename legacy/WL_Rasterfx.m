% function WL_Rasterfx(inputdat,CellNo,varargin)

% nparams=length(varargin);


% ex:  WL_Rasterfx(roi_ave2.interp_raw,[ 5 6 7 8 10 11 12 13 15 21 22 23 24
% 26 27 28 33 34 35 ])
% for i=1:2:nparams
% 	switch lower(varargin{i})
% 		case 'high'
% 			high=varargin{i+1};
% 		case 'low'
% 			low=varargin{i+1};
% 		case 'gap_thresh'
% 			gap_thresh=varargin{i+1};
% 		case 'fs'
% 			fs=varargin{i+1};
% 		case 'mat_dir'
% 			mat_dir=varargin{i+1};
% 		case 'gif_dir'
% 			gif_dir=varargin{i+1};
% 		case 'alt_thresh'
% 			alt_thresh=varargin{i+1};
% 		case 'alt_method'
% 			alt_method=varargin{i+1};
% 		case 'alt_pad'
% 			alt_pad=varargin{i+1};
% 	end
% end
figure(1);


inputdat = data.undirected;
CellNo = 20;
TrialNo = 6;
ave_time = 1:58;
wt = 2
%[mm,nn,TrialNo] = size(inputdat(:,:,:,:))




c = colormap(lines(50));
linewidth = 2;
counter = 1;

for n = 1:CellNo
for i = 1:TrialNo
    hold on
Great{i,n}=(fast_oopsi((inputdat(i,:,n)')));
pls = Great{i,n};
thresh = wt*std(pls);
[val,loc] = findpeaks((pls),'MINPEAKHEIGHT',thresh);
Mbinary = ave_time(transpose(loc));
x = (1.5+(counter-1))*ones(size(Mbinary));
y = (0.5+(counter-1))*ones(size(Mbinary));
figure(1);
plot([Mbinary;Mbinary],[x;y],'color',c(n,:),'linewidth',linewidth);

counter = counter +1;
end
end