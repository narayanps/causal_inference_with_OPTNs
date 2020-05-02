clear all
addpath('/opt/lintula/worktmp/nbnapu/HERMES_DATA/CONNECTED/gabriealla_new/20200226/04/20200226_04_mat_files/')
addpath('/opt/lintula/worktmp/nbnapu/fieldtrip-20200109')
ft_defaults
%electrodes_intact = [72 77 24 22 44 12 13 14 16 17 36 28];
electrodes_intact = [77 12 13 14 16 17];
for i=1:1:length(electrodes_intact)
        load(sprintf('20200226_slice04_01_CTRL1_%d', electrodes_intact(i)))
        eeg_data(i,:)= [data- mean(data)]'; %Demean
end

ent_params.dim = 3;
ent_params.tau=100;
ent_params.delays=1:10;
ent_params.th=0.05;
win_len = 3;
win_step=1.5;
delays = 1:10;
Fs=5000;
Flp=2000;

[H] = run_multivar_entropy(eeg_data(:,1:30*5000), Fs, Flp, win_len, win_step, ent_params);