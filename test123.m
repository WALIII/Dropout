
function [T, F, coefficients_spec, coefficients, h, p_values] = test123(data,Gconsensus2,cell,f,t,TOD)
% Example code for analysis of neural correlate with spectral differences.
% This looks at differences in spectral power (but will not uncover
% relationships between neural activity and timing differences, as all that
% is masked by the warping process; a similar approach could look at
% correlates between neural activity and amount of warping).

%% Step 1: warp spectrograms
% How the spectrogram is warped is important, as you want to avoid spectral
% artifacts of the warping process. The exact code will vary a bit
% depending on what spectral routine you are using.
%
% I have not tested this, but the important idea is that you want to do the
% warping at the same time scale as the spectrogram generation, and apply
% the warping directly to the spectral columns (rather than generating the
% spectrogram from the warped audio).

% assumes variable:
%    songs - cell array of individual songs
%    template - vector of template song
%    fs - sampling rate

% % both the warping and spectrogram should use consistent parameters
% fft_window = 1024;
% fft_overlap = 1016;
% fft_stride = fft_window - fft_overlap;
% 
% % get time and frequency for template
% [S_template, F, T] = ccountour(template, fs, 'fft_length', fft_window, 'fft_overlap', fft_overlap);
% 
% % make spectrogram container
% spectrograms = zeros(length(F), length(T), length(songs));
% 
% for i = 1:length(songs)
%     % zero pad to spectrogram boundary
%     len = fft_window + fft_stride * ceil((length(songs{i}) - fft_window) / fft_stride);
%     song = [songs{i}; zeros(len - length(songs{i}), 1)];
% 
%     % generate spectrogram
%     [S, F, T] = ccountour(song, fs, 'fft_length', fft_window, 'fft_overlap', fft_overlap);
% 
%     % perform warping
%     [~, ~, ~, path] = warp_audio(song, template, fs, [], 'fft_window', fft_window, 'fft_overlap', fft_overlap);
% 
%     % warp spectrogram
%     for j = 1:path(1, end)
%         idx = path(1, :) == j;
%         spectrograms(:, j, i) = mean(S(:, path(2, idx)), 2);
%     end
% end
% 
% %% Step 2: extract interesting parts of 

% assumes variables:
%    spectrograms - frequencies x times x trials
%    F - frequencies corresponding with the spectral times
%    T - times corresponding with the spectral times
%    peak_dff - vector of peak df/f for cell of interest (length: trials)
%    other_factors - matrix of factors to control for (factors x trials)
%    time_range - start and end time of interest (ignores spectral
%                 differences out of this range), vector of two values
%                 (start and end time)
%    freq_range - pick a meaningful frequency range (ignores spectral
%                 differences out of this range, e.g., 1 kHz to 10 kHz),
%                 vector of two values (start and end frequency)

try
figure(); plot(data.ind_sort(:,:,cell)');
catch
    data.ind_sort = data.unsorted;
    figure(); plot(data.unsorted(:,:,cell)');
end
clear b
for i = 1: size(data.ind_sort,1);
    dff(:,i) = max(data.ind_sort(i,:,cell)) - min(data.ind_sort(i,:,cell));
end



spectrograms = Gconsensus2{1};
peak_dff = dff;
%time_range = [0 2350];
%freq_range = [0 200];
time_range = [0 .01];
freq_range = [1 10];
T = t;
F = f;
% get dimensions
trials = size(spectrograms, 3);

% independent variables (what to regress out), include a column of ones,
% before assessing the relationship between our cell of interest and the
% spectral bins
other_factors = TOD;
X_other = other_factors';

% reshape peak_dff to be a column vector
X = reshape(peak_dff, [], 1);

% get spectral columns of interests
% F_idx = F >= freq_range(1) & F <= freq_range(2);
% T_idx = T >= time_range(1) & T <= time_range(2);
T_idx = [1:size(t,2)];
F_idx = [1:size(f,1)];


Y = spectrograms(F_idx, T_idx, :);
Y = reshape(Y, [], trials)'; % reshape, so rows of Y correspond with song 
% trials and columns correspond with the spectral bins of interest

% for each spectral bin
spectral_bins = size(Y, 2);
coefficients = zeros(1, spectral_bins);
p_values = zeros(1, spectral_bins);


    f = waitbar(0, 'Processing...');
for i = 1:spectral_bins
   waitbar((i/spectral_bins),f, 'Processing...');
    % perform a linear regression on the spectral bin, building a linear
    % model combining a constant (y-intercept), any other factors and the
    % peak df/f for the cell of interest
    mdl = fitlm([X_other X], Y(:, i));
    
    % store coefficient and p value (the last ones returned)
    coefficients(i) = mdl.Coefficients.Estimate(end);
    p_values(i) = mdl.Coefficients.pValue(end);
end





% false discovery rate correction for multiple tests
% requires FDH_BH from file exchange
% https://www.mathworks.com/matlabcentral/fileexchange/27418-fdr-bh
h = fdr_bh(p_values, 0.01);

% print result
fprintf('Found %d spectral bins with significant change associated with peak df/f.\n', sum(h));

% h is 1 where there is a significant change in the spectral bin
coefficients_significant = coefficients;
coefficients_significant(h == 0) = 0;

% we can now reshape this back into a spectrogram
coefficients_spec = zeros(size(spectrograms, 1), size(spectrograms, 2));
coefficients_spec = reshape(coefficients_significant,[max(F_idx) max(T_idx)]);

% show 
figure;
% imagesc(T, F, coefficients_spec,[min(min(coefficients_spec))/5 max(max(coefficients_spec)) ]);
 imagesc(T, F, coefficients_spec,[-1 1]);



axis xy;
xlabel('Time [s]');
ylabel('Frequency [Hz]');
colormap(fireice)
colorbar();
