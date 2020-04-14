function [H]  = remove_ncn_v2(C, H, trans_network,  data)

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
            
                [ts_surr] = shuffle_surr(data(K(j),:), 19);
                for ns=1:1:19
                    data_surr = [data(i,:); ts_surr(ns,:)];
                    [trans_network_surr(:,:,1, ns)] = make_optn(data_surr, 3, 100);
                    Y_=squeeze(trans_network_surr(1+(tau-C{i}.tau(j)):end-(C{i}.tau(j)),2, 1, ns))';
                    delta_s(ns) = abs(ConditionalEntropy(trans_network(1+tau:end,i), [Y_prime']) - ConditionalEntropy(trans_network(1+tau:end,i), [Y_prime' Y_']) );
                end

            if abs(delta(j) - mean(delta_s)) < 0.05    
                H(i, C{i}.neighbors(j), 1+C{i}.tau(j)) = 0;
            end
        end
        
    end
    end
end

