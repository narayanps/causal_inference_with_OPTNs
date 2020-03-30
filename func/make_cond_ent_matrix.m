function [H] = make_cond_ent_matrix(M, trans_network, trans_network_surr, delays, num_surr)

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
            for  ns=1:num_surr
%                 S_1 = squeeze(trans_network_surr(delays(t)+1:end,1,count, ns));
%                 S_2 = squeeze(trans_network_surr(1:end-delays(t),2,count, ns));
                S_1 = squeeze(trans_network_surr(delays(t)+1:end,i, ns));
                S_2 = squeeze(trans_network_surr(1:end-delays(t),K(j), ns));
                Hs(i, K(j), t, ns)= entropy(S_1', S_2');
            end
        end
    end
end
% Hs_mean = squeeze(mean(Hs, 4));
% Hs_sigma = squeeze(std(Hs, [], 4));
% Z = abs(H - Hs_mean)./Hs_sigma;
% Z(Z<2.58) = 0;
% Z(Z>2.58) = 1;
% for i=1:1:M
%     for j=1:1:M
%         if i~=j
%             H(i,j,:) = H(i,j,:) .* Z(i,j,:);
%         end
%     end
% end
Hs_min=min(Hs,[],4);
H(H > Hs_min) = 0; 
