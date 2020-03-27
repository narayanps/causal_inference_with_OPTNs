function [H]  = remove_ncn(C, trans_network, trans_network_surr,delays,num_surr);

M=length(C);
for i=1:1:M
    if ~isempty(C{i})
        K = C{i}.neighbors;
        tau = max(C{i}.tau);
        Y=[];
        if length(K) > 1
            for m=1:1:length(K)
                Y=[Y;trans_network(tau-C{i}.tau(m)+1:end-C{i}.tau(m),C{i}.neighbors(m))' ];
            end
            
            for j=1:1:length(C{i}.neighbors)
                V=setdiff(1:length(C{i}.neighbors), j);
                Y_prime=[];
                for n=1:1:length(V)
                    Y_prime=[Y_prime;trans_network(tau-C{i}.tau(V(n))+1:end-C{i}.tau(V(n)),C{i}.neighbors(V(n)))' ];
                end
                delta=entropy(trans_network(tau+1:end,i)', Y_prime) - entropy(trans_network(tau+1:end,i)', Y);
                for ns=1:1:num_surr
                    delta(ns)=entropy(trans_network(tau+1:end,i)', Y_prime) - entropy(trans_network_surr(tau+1:end,i)', Y);
                    
                end
                if abs(hh)<tol_c
                    count=count+1;
                    C{i}.NCN(count) = C{i}.N(j);
                end
            end
        end
    end
end

