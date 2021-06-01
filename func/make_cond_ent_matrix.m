function [H] = make_cond_ent_matrix(M, trans_network, delays)
%AUTHOR : NARAYAN P SUBRAMANIYAM
%TUNI / MET / 2020
%initialize
H = zeros(M,M,length(delays));
count = 0;

%find causal neighbors (this may include direct and indirect links)
for i=1:1:M
    K = setdiff(1:M,i); % set of the remaining channels excluding i-th channel
    for j=1:1:length(K)
        count = count + 1;
        for t=1:1:length(delays)
            H(i, K(j), t)= entropy(trans_network(delays(t)+1:end,i)', trans_network(1:end-delays(t),K(j))');
        end
    end
end

