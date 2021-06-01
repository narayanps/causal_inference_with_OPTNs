%run example slice 04
clear all
path=pwd;
addpath(genpath(strcat(path, '/func/')));
addpath(genpath(strcat(path, '/external/')));
addpath(genpath(strcat(path, '/example_mea_data_slice_04/')));
slice_no=4;
electrodes_cut{4,1} = [83 75 23 42 43 44 12 13 14 16 17 36];%1,2,3,4,5,9
ent_params.lambda=0.99;
for i=1:1:length(electrodes_cut{slice_no,1})
    load(sprintf('20200226_slice0%d_02_CTRL2_%d', slice_no, electrodes_cut{slice_no,1}(i)));  
    eeg_data(i,:)= [data- mean(data)]'; %Demean
end


Fs=5000;
Fbp=[0.1 300];
Fs_new  = 3000; 
win_len = 4;
win_step=2;

[win_data, win_index, eeg_data_res] = preprocess_data(eeg_data(:,1:end), Fs, Fbp, win_len, win_step, Fs_new);
delay_ms = 2:2:150;
delay_samp = delay_ms*Fs_new*1e-3;
ent_params.dim = 3;
ent_params.tau=100;
ent_params.delays=delay_samp;
ent_params.th=0.2;
ent_params.max_var=2;
elec=[1 2 3 4 5 9];
%example section from slice 4 that includes ictal activity
win_pre=57; % few seconds before seizure
win_post=78;% few seconds after seizure
%example plot
plot(eeg_data_res(elec(end), squeeze(win_index(1,win_pre,1)):squeeze(win_index(1,win_post,2))));
[H_win, H] = run_multivar_entropy(squeeze(win_data(elec,:,win_pre:win_post)), ent_params);
win_id = [57:78];
win_index = squeeze(win_index(1,:,:));
t=win_index(win_id(1),1)/Fs_new:1/Fs_new:win_index(win_id(end),2)/Fs_new;
t_win = floor(win_index(win_id,1)/Fs_new + win_index(win_id,2)/Fs_new)/2;
H_win=2.58-H_win;
H_win(H_win==2.58) = 0;

figure('units','normalized','outerposition',[0 0 1 1])
cM = plasma(256);
colormap(cM);
N=size(H_win,1);
node_label = {'DG', 'CA3', 'CA1', 'SUB', 'CTX-1', 'CTX-2'};

for i=1:1:N
    for j=1:1:N
        if i ~=j
            subplot(N,N, N*(i-1)+j)
            
            imagesc(t_win,delay_ms,squeeze(H_win(i,j,:,:)));
            set(gca, 'YDir', 'normal')
            ylabel('\textbf{delay[ms]}', 'fontweight','bold','fontsize',14);
            title(strcat(node_label{j},'$\rightarrow$', node_label{i}),'fontweight','bold','fontsize',16)
            axesH = gca;
            axesH.XAxis.TickLabelInterpreter = 'latex';
            axesH.XAxis.TickLabelFormat      = '\\textbf{%g}';
            axesH.YAxis.TickLabelInterpreter = 'latex';
            axesH.YAxis.TickLabelFormat      = '\\textbf{%g}';
            set(gca,'fontsize',12);
        end
        if i==j
            subplot(N,N, N*(i-1)+j)
            plot(t,eeg_data_res(elec(i), win_index(win_id(1),1):win_index(win_id(end),2)))
            xlim([t(1) t(end)])
            ylabel('\textbf{Amplitude[$\mu$V]}', 'fontweight','bold','fontsize',16)
            title(node_label{j},'fontweight','bold','fontsize',14)
            axesH = gca;
            axesH.XAxis.TickLabelInterpreter = 'latex';
            axesH.XAxis.TickLabelFormat      = '\\textbf{%g}';
            axesH.YAxis.TickLabelInterpreter = 'latex';
            axesH.YAxis.TickLabelFormat      = '\\textbf{%g}';
            set(gca,'fontsize',12)
        end
        %         if j==1
        %             if i>1
        %         ylabel('delay[ms]')
        %             end
        %         end
        if i==6
            xlabel('\textbf{time[seconds]}','fontweight','bold','fontsize',14)
        end
        set(gca, 'CLim', [0 max(H_win(:))])
    end
    if (i==6)
        cb = colorbar;
        cb.Position = cb.Position + 1e-10;
        p = cb.Position;
        p(1) = p(1) + 0.05;
        set(cb, 'position', p);
    end
    
end

