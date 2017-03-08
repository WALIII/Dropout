function FS_Spectrogram(mic_data,fs);
% Make spectrogram of mic data

figure()




[b,a]=ellip(5,.2,80,[500]/(fs/2),'high');
[IMAGE,F,T] = fb_pretty_sonogram(filtfilt(b,a,mic_data./abs(max(mic_data))),fs,'low',2.9,'zeropad',0);
colormap(hot)
imagesc(T,F,log(abs(IMAGE)+1e+2));set(gca,'YDir','normal');
ylim([0 9000]);

hold on;

