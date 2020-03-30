function [H]  = remove_ncn(C, H, trans_network)

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
                delta(j)=entropy(trans_network(1+tau:end,i)', Y_prime) - entropy(trans_network(1+tau:end,i)', Y);
                %if abs(delta)<0.3
                %    count=count+1;
                %    C{i}.NCN(count) = C{i}.neighbors(j);
                %    C{i}.NCD(count) = C{i}.tau(j);
                %    H(i, C{i}.neighbors(j), 1+C{i}.tau(j)) = 0;
                %end
                
            end
            max_delta=max(delta);
            ind=find(delta==max_delta);
            id_n = setdiff(1:length(delta), ind);
            for j=1:1:length(id_n)
                if delta(id_n(j)) < 3*max_delta
                    H(i, C{i}.neighbors(id_n(j)), 1+C{i}.tau(id_n(j))) = 0;
                end
            end
            delta=[];
        end
        
    end
end

