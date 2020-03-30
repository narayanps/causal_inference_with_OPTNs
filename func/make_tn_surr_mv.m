function [trans_network_surr] = make_tn_surr_mv( data, num_surr, ParamSurro, emb_dim, emb_tau)
for ns=1:1:num_surr
    tic
    data_surr(:,:,ns) = ASR_SurrogateMulti(data,ParamSurro);
    trans_network_surr(:,:,ns) = make_optn(data_surr, emb_dim, emb_tau);
    toc
end


