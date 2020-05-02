function [H]  = remove_ncn(C, H, trans_network,th)

M=length(C);
for i=1:1:M
    if ~isempty(C{i})
        count=0;
        K = C{i}.neighbors;
        tau = max(C{i}.tau);
        Y=[];
        if length(K) > 1
            for m=1:1:length(K)
                Y=[Y;trans_network(1+(tau-C{i}.tau(m)):end-( C{i}.tau(m)),C{i}.neighbors(m))' ];
            end
            
            for j=1:1:length(C{i}.neighbors)
                V=setdiff(1:length(C{i}.neighbors), j);
                Y_prime=[];
                for n=1:1:length(V)
                    Y_prime=[Y_prime;trans_network(1+(tau-C{i}.tau(V(n))):end-(C{i}.tau(V(n))),C{i}.neighbors(V(n)))' ];
                end
                delta(j) =  abs(ConditionalEntropy(trans_network(1+tau:end,i), [Y_prime']) - ConditionalEntropy(trans_network(1+tau:end,i), [Y']));
            if (delta(j) < th)  %(delta(j) < max(delta_s))     
                H(i, C{i}.neighbors(j), C{i}.tau(j)) = 0;
             end
            end
        delta = [];
        
    end
    end
end

