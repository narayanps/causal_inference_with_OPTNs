function [trans_network] = make_optn(data, dim, tau)

M=size(data,1);  %no. of channels
T=size(data,2); %no of time points
N = T -(dim-1)*tau;  %no of time points after embedding
trans_network = zeros(N,M); %Matrix storing transition network constructed for each channel along the column 

%compute all possible patterns
patterns=perms([0:1:dim-1]');

%create phase space trajectoryand initialize variables
for i=1:1:M
    x=data(i,:);
    [v] = compute_psv(x,tau,dim);
   
    op_ind = zeros(N,1);
    op_dist = zeros(1,factorial(dim));
    
    %assign ordinal pattern index
    for k=1:1:N
        v_k = v(k,:);
        [~, indx] = sort(v_k);
        I = ismember(patterns, indx-1,'rows');
        op_ind(k) = find(I==1);
        op_dist(op_ind(k)) =  op_dist(op_ind(k)) + 1;
    end
     trans_network(:,i) = op_ind;
end

