function [trans_network_surr, chan_comb] = make_tn_surr(M, data, num_surr, ParamSurro, emb_dim, emb_tau, srate)
count=0;
chan_comb = zeros(M*(M-1), 2);
for i=1:1:M
    tic
    K = setdiff(1:M,i); % set of the remaining channels excluding i-th channel
    for j=1:1:length(K)
        count=count+1;
        chan_comb(count,:) = [K(j) i];
%         [ts_surr] = time_shift_surr(data(K(j),:),srate, num_surr);
        [ts_surr] = shuffle_surr(data(K(j),:), num_surr);
        for ns=1:1:num_surr
            data_surr = [ data(i,:); ts_surr(ns,:)];
            [trans_network_surr(:,:,count, ns)] = make_optn(data_surr, emb_dim, emb_tau);
        end
    end
    toc
end