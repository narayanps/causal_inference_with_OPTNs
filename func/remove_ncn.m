function [H_upd]  = remove_ncn(H, C, P, trans_network,th,max_var, delays_all)
%AUTHOR : NARAYAN P SUBRAMANIYAM
%TUNI / MET / 2020
M=length(C);
H_upd = zeros(size(H));

for i=1:M
    tic
    if ~isempty(P{i}) %IF PARENT SET IS NOT EMPTY
        for j=1:length(P{i}.links) %FOR EACH PARENT p at delay tau
            %if i~=j
            if ~isempty(C{P{i}.links(j)}) %IF THE CHILDREN SET OF THE PARENT IS NOT EMPTY
                tau = max(P{i,1}.tau);
                [P_min_links, P_min_tau] = get_Pmin(P, P{i,1}, C{P{i}.links(j),1},i,P{i}.links(j));
                [min_cond_set] = get_min_cond_set(H,trans_network, P_min_links, P_min_tau, tau,i,max_var, delays_all);
                delays = P{i,1}.tau(find(P{i,1}.links==P{i}.links(j)));
                [delta] = get_delta(delays, trans_network, min_cond_set, P_min_tau, tau , i, P{i}.links(j));
                id_delta= find(delta>th);
                if ~isempty(id_delta)
                    for k=1:1:length(id_delta)
                    id(k) = find(delays_all == delays(id_delta(k)));
                    end
                    H_upd(i,P{i}.links(j),id) = H(i,P{i}.links(j),id);
                end
            end
            %end
            
        end
        
    end
    toc
end