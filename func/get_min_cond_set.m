function [min_cond_set] = get_min_cond_set(H, trans_network, P_min_links, P_min_tau, tau,i, max_var, delays)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if isempty(P_min_tau)
    min_cond_set = trans_network(1+tau:end,i);
else
    min_cond_set = [];
    if length(P_min_links) < max_var
        for m=1:1:length(P_min_links)
            min_cond_set=[min_cond_set;trans_network(1+(tau-P_min_tau(m)):end-(P_min_tau(m)),P_min_links(m))' ];
        end
    else
        for m=1:1:length(P_min_links)
            id = find(delays == P_min_tau(m));
            H_vals(m) = H(i, P_min_links(m), id);
        end
        [~,ind]=sort(H_vals, 'ascend');
        P_min_links_n = P_min_links(ind(1:max_var));
        P_min_tau_n = P_min_tau(ind(1:max_var));
        for m=1:1:length(P_min_links_n)
            min_cond_set=[min_cond_set;trans_network(1+(tau-P_min_tau_n(m)):end-(P_min_tau_n(m)),P_min_links_n(m))' ];
        end
    end
    
end
end

