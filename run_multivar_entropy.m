clear all
close all
set(groot, 'defaultTextInterpreter', 'latex')
addpath(strcat(pwd, '/func'))
addpath(strcat(pwd, '/external'))

%multivariate data
%data = four_chan_NL(10000);
data = model7(10000);

%embedding parameters for the data
emb_params.d=3;
emb_params.tau(1)=100;
emb_params.tau(2)=100;
emb_params.tau(3)=100;
emb_params_surr.d=3;
emb_params_surr.tau(1)=1;
emb_params_surr.tau(2)=1;
emb_params_surr.tau(3)=1;
emb_params.tau(4)=1;

%no of channels
M=size(data,1);

%range of delays to test
tau=0:2;

%compute bi-variate entropy that is unable to distinguish direct and
%indirect links
A = zeros(M,M,length(tau));
H_max = -1*log2(1/factorial(emb_params.d)); %max entropy
%H_max=round(H_max*1e2)./1e2;
pc=0;
tol=5e-3;%0.01;
ParamSurro.MaxIter=120;
ParamSurro.type=1;

% for i=1:1:M
%     for j=1:M
%         if i ~=j
%             pc = pc+1;
%             [H_S_bar(:,pc),C_JS_bar(:,pc)] = biv_comp_ent(data([i j],:), emb_params, tau);
%             for ns=1:19
%                 data_surr = ASR_SurrogateMulti(data([i j],:),ParamSurro);
%                 [H_S_bar_s(:,pc,ns),C_JS_bar_s(:,pc,ns)] = biv_comp_ent(data_surr, emb_params, tau);
%             end
%             d=mean(H_S_bar_s(:,pc,:),3);
%             sigma=std(H_S_bar_s(:,pc,:),[],3);
%             Z = abs(H_S_bar(:,pc) - d)./sigma
%             sig_int_ids =  find(Z>1.96) ;%find(abs(H_S_bar(:,pc)-H_max)>tol);
%             A(i,j,sig_int_ids) = H_S_bar(sig_int_ids,pc);
%         end
%         
%     end
% end
% plot(tau,H_S_bar(:,:)', 'LineWidth', 2)


% run truly multivaritae entropy
[C, A_mv] = multivar_entropy(data, tau, emb_params, ParamSurro, 0.15, tol);