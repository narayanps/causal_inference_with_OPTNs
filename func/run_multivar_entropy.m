function [H] = run_multivar_entropy(data, Fs, Flp, win_len, win_step, ent_params)

% data : channel X samples
% Fs : Sampling frequency
% Flp : Low-pass filter
% win_len : window length in seconds
% win_ol : window overlap in seconds


if ~isempty(Flp)
    %%%%%%%%%%%%%%%%%%%%%%%%%%LOW PASS FILTER THE DATA%%%%%%%%%%%%%%%%%%%%
    for i=1:1:size(data,1)
        N = 10; % Filter order
        [data(i,:), ~, ~] = ft_preproc_lowpassfilter(data(i,1:end),Fs, ...
            Flp, N,'fir','onepass-zerophase','reduce',[],[],[],'yes',[]);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%MAKE WINDOWS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(win_len)
    param_win.win_len=win_len; %window length in sec
    param_win.win_step=win_step; %window overlap in sec
    param_win.samp_freq=Fs;
    for i=1:1:size(data,1)
        [win_data(i,:,:),win_index(i,:,:)] = make_windows(data(i,:), ...
            param_win );
    end
else
    win_data(:,:,1)=data;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%ESTIMATE CO-OCCURENCE ENTROPY%%%%%%%%%%%%%%%%%%%%%%%%%
delays = ent_params.delays;
dim = ent_params.dim;
tau = ent_params.tau;
th = ent_params.th;
M=size(win_data,1);

for i=1:1:size(win_data,3)
    [trans_network] = make_optn(squeeze(win_data(:,:,i)), dim, tau);
    [H] = make_cond_ent_matrix(M, trans_network,delays);
    %threshold based on theoretical upper bound
    H_max = max(H(:));
    H_min =	0.99*H_max;
    H(H>=H_min & H<=H_max)=	0;
    [C]  = find_conn_and_delays(H, delays);
    [H]  = remove_ncn(C, H, trans_network, th);
    H_win(:,:,:,i) = H;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%res_path = '/scratch/nbnapu/linear_directed_chain';
%fname = sprintf(strcat(res_path,'/H_%d.mat'),j);                                                                                                                                      
%save(fname, 'H');


end