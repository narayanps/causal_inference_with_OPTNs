function [A, op_tn, op_dist, op_ind] = make_transition_network(x, d, tau)
%Author : Narayan Subramaniyam, TUNI/2020


%compute all possible patterns

patterns=perms([0:1:d-1]');

%create phase space trajectoryand initialize variables
[v] = compute_psv(x,tau,d);
M = size(v,1);
op_ind = zeros(M,1);
op_dist = zeros(1,factorial(d));

%assign ordinal pattern index
for k=1:1:M
    v_k = v(k,:);
    [~, indx] = sort(v_k);
    I = ismember(patterns, indx-1,'rows');
    op_ind(k) = find(I==1);
    op_dist(op_ind(k)) =  op_dist(op_ind(k)) + 1;
end
A=zeros(factorial(d), factorial(d));
%%%%%%%%%%%%%%%%%%%%%%REMOVE SELF-LOOPS%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% diff_ = op_ind(2:end) - op_ind(1:end-1);
% rep_ids=find(diff_==0);
% op_ind(rep_ids+1) = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[tmp] = compute_psv(op_ind,1,2); %resuse psv code with tau=1 and dim=2 to get links a -> b -> c -> a ....

for i=1:1:size(tmp,1)
        A(tmp(i,2),tmp(i,1)) = A(tmp(i,1),tmp(i,2)) +1; 
end
op_tn=tmp;
end

