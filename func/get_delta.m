function  [delta] = get_delta(delays, trans_network, min_cond_set, P_min_tau, tau , i, j)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if ~isempty(P_min_tau)
    for t=1:1:length(delays)
        cond_set_inc = [min_cond_set ; trans_network(1+(tau-delays(t)):end-(delays(t)),j)'];
        delta(t) = ConditionalEntropy(trans_network(1+tau:end,i), min_cond_set') -  ConditionalEntropy(trans_network(1+tau:end,i), cond_set_inc');
    end
else
    for t=1:1:length(delays)
        cond_set_inc = [trans_network(1+(tau-delays(t)):end-(delays(t)),j)'];
        delta(t) = ShannonEntropy(trans_network(1+tau:end,i)) -  ConditionalEntropy(trans_network(1+tau:end,i), cond_set_inc');
    end
end
end

