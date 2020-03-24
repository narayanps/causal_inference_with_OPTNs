clear all
close all
set(groot, 'defaultTextInterpreter', 'latex')

%multivariate data
data = four_chan_NL(10000);

%embedding parameters for the data
emb_params.d=3;
emb_params.tau(1)=10;
emb_params.tau(2)=10;
emb_params.tau(3)=10;
emb_params.tau(4)=10;

%no of channels
M=size(data,1);

%range of delays to test
tau=1:5;

%compute bi-variate entropy that is unable to distinguish direct and
%indirect links
A = zeros(M,M,length(tau));
H_max = -1*log2(1/factorial(emb_params.d)); %max entropy
pc=0;
tol=0.05;
ParamSurro.MaxIter=120;
ParamSurro.type=1;

for i=1:1:M
    for j=1:M
        if i ~=j
        pc = pc+1;
        [H_S_bar(:,pc),C_JS_bar(:,pc)] = biv_comp_ent(data([i j],:), emb_params, tau);
        sig_int_ids = find(abs(H_S_bar(:,pc)-H_max)>tol);
        A(i,j,sig_int_ids) = H_S_bar(sig_int_ids,pc);
        end
        
    end
end
plot(tau,H_S_bar(:,:)', 'LineWidth', 2)


% run truly multivaritae entropy
[C, A_mv] = multivar_entropy(data, tau, emb_params, ParamSurro, 0.15);