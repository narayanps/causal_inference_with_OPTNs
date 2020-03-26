function [trans_network_surr] = make_tn_surr(M, data, num_surr, ParamSurro, emb_dim, emb_tau)
count=0;
chan_comb = zeros(M*(M-1), 2);
for i=1:1:M
    tic
    K = setdiff(1:M,i); % set of the remaining channels excluding i-th channel
    for j=1:1:length(K)
        count=count+1;
        chan_comb(count,:) = [i K(j)];
        for ns=1:1:num_surr
            data_surr = ASR_SurrogateMulti(data([i K(j)],:),ParamSurro);
            [trans_network_surr(:,:,count, ns)] = make_optn(data_surr, emb_dim, emb_tau);
        end
    end
    toc
end