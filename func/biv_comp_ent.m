function [H_S_bar,C_JS_bar] = biv_comp_ent(data, emb_params, tau)

%pull out embedding parameters

emb_dim=emb_params.d;
emb_tau(1) = emb_params.tau(1);
emb_tau(2) = emb_params.tau(2);

%sample space and probabilities
D=factorial(emb_dim);
prob_iX = zeros(D,1);
cond_prob_YX = zeros(D,1);
co_occur_mat = zeros(D,D);
P_e = repmat(1/D,D,1);

%co-occurence entropy/complexity variables
H_S=zeros(D,1);
C_JS=zeros(D,1);
H_S_bar=zeros(length(tau),1);
C_JS_bar=zeros(length(tau),1);
[~, op_tn_x, ~, ~] = make_transition_network(data(1,:), emb_dim, emb_tau(1));
[~, op_tn_y, ~, ~] = make_transition_network(data(2,:), emb_dim, emb_tau(2));
L_1 = length(op_tn_x);
L_2 = length(op_tn_y);
%compute bivariate C-E for each tau
for k=1:1:length(tau)
    for pi_iX=1:1:D
        indx = find(op_tn_x(1:end,1)==pi_iX);
        prob_iX(pi_iX) = length(indx)./length(op_tn_x(1:end,1));
        indx_tau = indx + tau(k);
        invalid_inds = find(indx_tau>L_2 | indx_tau <1);
        indx_tau(invalid_inds) = [];
        pi_jY_tau = op_tn_y(indx_tau, 1);
        for pi_iY=1:1:D
            freq= length(find(pi_jY_tau == pi_iY));
            co_occur_mat(pi_iX, pi_iY) = freq./size(pi_jY_tau,1);
            cond_prob_YX(pi_iY)=freq./size(pi_jY_tau,1);
        end

        % normalized entropy permutation entropy
        H_S(pi_iX) = Shannon_ent(cond_prob_YX) ; %./ log2(D);
        C_JS(pi_iX) = MPR_complexity(H_S(pi_iX), cond_prob_YX, P_e, D);
       
    end
    %compute weighted averages of entropy/complexityfor each delay
    H_S_bar(k) = 1*sum((prob_iX).*H_S);
    C_JS_bar(k) = 1*sum((prob_iX).*C_JS);
    
end


