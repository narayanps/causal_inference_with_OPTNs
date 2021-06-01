function [C, P,H]  = find_parents_children(H, delays)
%AUTHOR : NARAYAN P SUBRAMANIYAM
%TUNI / MET / 2020

M=size(H,1);
N=length(delays);
C=cell(M,1);
P=cell(M,1);
for i=1:1:M
    count_p = 0;
    count_c = 0;
    for k=1:1:N
        K_p = find(H(i,:,k)>0);
        K_c = find(H(:,i,k)>0);
        if ~isempty(K_p)
            for j=1:1:length(K_p)
                count_p = count_p + 1;
                P{i,1}.links(count_p) = K_p(j);
                P{i,1}.tau(count_p) = delays(k);
            end
        end
        
        if ~isempty(K_c)
            for j=1:1:length(K_c)
                count_c = count_c + 1;
                C{i,1}.links(count_c) = K_c(j);
                C{i,1}.tau(count_c) = delays(k);
            end
        end
    end
end