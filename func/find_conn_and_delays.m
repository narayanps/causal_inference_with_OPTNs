function [C]  = find_conn_and_delays(H, delays)

M=size(H,1);
T=size(H,3);
C=cell(M,1);


for i=1:1:M
    count=0;
    for t=1:1:T
        K = find(H(i,:,t)>0); %links / connections to the i-th channel at delay t
        if ~isempty(K)
            for j=1:1:length(K)
                count=count+1;
                C{i}.neighbors(count,1) = K(j);
                C{i}.tau(count,1) = delays(t);
            end
            
        end
    end
end
end

