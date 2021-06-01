function [P_min_links, P_min_tau] = get_Pmin(P_all,P, C, i, j);
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
P_full_links=P.links;
P_full_tau=P.tau;
C_full = C.links;
C_hat = setdiff(C_full, i);
if ~isempty(C_hat)
    P_min_links = P_full_links(find( ismember(P_full_links, C_hat))); %intersect(P_full_links, C_hat);
    if ~isempty(P_min_links)
        c = ismember(P_full_links, P_min_links);
        P_min_tau = P_full_tau(find(c));
    else
        if ~isempty(P_all{j,1})
            P_min_links = P_full_links(find(ismember(P_full_links, P_all{j,1}.links)));
        end
        if ~isempty(P_min_links)
            c = ismember(P_full_links, P_min_links);
            P_min_tau = P_full_tau(find(c));
        else
            P_min_links = i;
            P_min_tau = [];
        end
    end
else
    P_min_links = i;
    P_min_tau = [];
end
%end

