

function FS_AudioExtract(DIR)

% Extract Audio from videos, for song analysis.

if nargin<1 | isempty(DIR), DIR=pwd; end
mov_listing=dir(fullfile(DIR,'*.mov'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;

mat_dir='wav';
gif_dir='gif';

if exist(mat_dir,'dir') rmdir(mat_dir,'s'); end
if exist(gif_dir,'dir') rmdir(gif_dir,'s'); end
mkdir(mat_dir);
mkdir(gif_dir);

disp('Creating WAV files');

% [nblanks formatstring]=fb_progressbar(100);
% fprintf(1,['Progress:  ' blanks(nblanks)]);

for i=1:length(mov_listing)
    [y,Fs] = audioread(filenames{i});
    [path,file,ext]=fileparts(filenames{i});
    Newfilename = ['wav/',file,'.wav'];
    audiowrite(Newfilename,y,Fs);
  
    
    
    % write spectrogram
    		[b,a]=ellip(5,.2,80,[500]/(Fs/2),'high');
% 		plot_data=y./abs(max(y));

		[s,f,t]=fb_pretty_sonogram(filtfilt(b,a,y./abs(max(y))),Fs,'low',2.5,'zeropad',0);

		minpt=1;
		maxpt=min(find(f>=10e3));

		imwrite(flipdim(uint8(s(minpt:maxpt,:)),1),hot,fullfile([DIR,'/gif/'],[file '.gif']),'gif');
        clear y;
end

    
    