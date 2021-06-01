%The demo code estimates causal network for data simulated by network of
%neural mass models
close all
path=pwd;
addpath(genpath(strcat(path, '/func/')));
addpath(strcat(path, '/external/'));

n_rois = 8;
density = 0.05; % 5 percent connection density
snr = 1;
lambda = 0.99 ; %[0.95 0.96 0.97 0.98 0.99 1.0] ;
th = 0.05;
delay = 30/1000; %30 ms delay in interaction -- introduces ~3-to-4 samples delay @ 100 Hz Fs.
[eeg1, W_p] = NMM_data_Generation(n_rois, density, delay); %Generate EEG at 100 Hz
for n=1:1:n_rois
    sig_var(n) = var(eeg1(n,:),[],2);
end
avg_var = mean(sig_var);
C=(avg_var/snr).*eye(n_rois);
noise = chol(C) * randn(size(eeg1));
y = eeg1 + noise;

ent_params.dim = 3;
ent_params.tau=1;
ent_params.th=th;
ent_params.max_var = 2;
ent_params.lambda = lambda;
ent_params.min_delay = 1;
ent_params.delays = 1:10; %delays (in samples) upto which causality is tested
ent_params.true = W_p;
[H_mvar, ~] = run_multivar_entropy(y, ent_params);  
H_mvar(H_mvar==0) = log2(factorial(ent_params.dim));
max_delay = 10; %maximum delay (in samples) upto which causality is tested
plot_interaction_delays(H_mvar, y, ent_params, max_delay)
