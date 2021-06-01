function [H_win, H] = run_multivar_entropy(win_data, ent_params)


% data : channel X samples
% Fs : Sampling frequency
% Flp : Low-pass filter
% win_len : window length in seconds
% win_ol : window overlap in seconds


%%%%%%%%%%%%%%%%%%%%%ESTIMATE CO-OCCURENCE ENTROPY%%%%%%%%%%%%%%%%%%%%%%%%%
delays = ent_params.delays;
dim = ent_params.dim;
tau = ent_params.tau;
th = ent_params.th;
lambda = ent_params.lambda;
max_var = ent_params.max_var;
M=size(win_data,1);

for i=1:1:size(win_data,3)
    tic
    [trans_network] = make_optn(squeeze(win_data(:,:,i)), dim, tau);
    [H] = make_cond_ent_matrix(M, trans_network,delays);
    H(H>=lambda*log2(factorial(ent_params.dim)))  = 0;
    [C, P,H]  = find_parents_children(H, delays);
    [H_upd]  = remove_ncn(H, C, P, trans_network,th,max_var, delays);
    H_win(:,:,:,i) = H_upd;
    toc
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




end