function scrap(mic_data,sorted_syllable);

figure()
N=1024;
NOVERLAP=1e3;
DOWNSAMPLE=5;


fs = 48000;
[b,a]=ellip(5,.2,80,[500]/(fs/2),'high');
[IMAGE,F,T] = fb_pretty_sonogram(filtfilt(b,a,mic_data./abs(max(mic_data))),fs,'low',2.5,'zeropad',0);
colormap(hot)
imagesc(T,F,log(abs(IMAGE)+1e+2));set(gca,'YDir','normal');
ylim([0 9000]);

hold on;

envelope = abs(hilbert(mic_data));
yupper = tsmovavg(envelope','s',10)*10000;
%plot((1:length(yupper))/fs,yupper,'b','linewidth',2);
plot((sorted_syllable*((N-NOVERLAP)*DOWNSAMPLE)-N)/fs+0.6,ones(length(sorted_syllable)),'b*');



% figure(); plot((1:length(yupper)),yupper);
% hold on;
% 
% plot(sorted_syllable{122}*fs,1:length(sorted_syllable{122}),'b*');

% [pk,lk] = findpeaks(yupper,'MinPeakHeight',100,'MinPeakProminence',1000);

% 
% S_CUT = lk(1);
% M_CUT = find(diff(lk)>10000);
% E_CUT = lk(end);
% 
% plot(S_CUT,pk(1),'b*');
% plot(lk(M_CUT),pk(M_CUT),'b*');
% plot(E_CUT,pk(end),'b*');



