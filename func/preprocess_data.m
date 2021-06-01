function [win_data, win_index, data_res] = preprocess_data(data, Fs, Fbp, win_len, win_step, Fs_new)

%STEP I - re-referencing
%re-referencing introduces some common artifacts, so leaving commented
% avg_val = mean(data,1);              % Average over electrodes.
% for i=1:size(data,2)                 % For each time,
%     data(:,i) = data(:,i) - avg_val(i); % ... subtract the average reference.
% end


% Bandpass filter (EX : 0.5-2000 Hz)
fNQ = Fs/2;					%Define the Nyquist frequency.

Wn = Fbp/fNQ;                  %...set the passband,
n  = 100;                     %...and filter order,
b  = fir1(n,Wn);              %...build bandpass filter.

data_filt = filtfilt(b,1,data')';	%...and apply filter.


%RESAMPLE
data_res = resample(data_filt', Fs_new, Fs)';

%%%%%%%%%%%%%%%%%%%%%MAKE WINDOWS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(win_len)
    param_win.win_len=win_len; %window length in sec
    param_win.win_step=win_step; %window overlap in sec
    param_win.samp_freq=Fs_new;
    for i=1:1:size(data_filt,1)
        [win_data(i,:,:),win_index(i,:,:)] = make_windows(data_res(i,:), ...
            param_win );
    end
else
    win_data(:,:,1)=data_res;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

