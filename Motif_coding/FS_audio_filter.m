function y =  FS_audio_filter(x)

Fs  = 48000;                                 % Sampling Frequency (Hz)
Fn  = Fs/2;                                 % Nyquist Frequency
Fco =   1000;                                 % Passband (Cutoff) Frequency
Fsb =   30;                                 % Stopband Frequency
Rp  =    1;                                 % Passband Ripple (dB)
Rs  =   10;                                 % Stopband Ripple (dB)
[n,Wn]  = buttord(Fco/Fn, Fsb/Fn, Rp, Rs);  % Filter Order & Wco
[b,a]   = butter(n,Wn,'high');                     % Lowpass Is Default Design
[sos,g] = tf2sos(b,a);                      % Second-Order-Section For STability

y = filtfilt(b,a,x);

%% plot the signal:
% figure();
% plot(y,'r');
% hold on;
% plot(x+0.5,'b');