%TRULY MULTIVARIATE ENTROPY

function [C, A] = estim_multivar_entropy(data, tau, emb_params, ParamSurro, tol_c, tol_h)
data = directed_chain_1(5000);
M=size(data,1); %num of channels
T=size(data,2); %num of time-points
num_surr=99;
ParamSurro.MaxIter=120;
ParamSurro.type=1;
delays=0:2;
emb_dim=3;
emb_tau=10;
H_max = -1*log2(1/factorial(emb_dim));

%construct transition networks from symbolic dynamics
[trans_network] = make_optn(data, emb_dim, emb_tau);

%construct transition networks from surrogates
%[trans_network_surr] = make_tn_surr(M, data, num_surr, ParamSurro, emb_dim, emb_tau);
[trans_network_surr] = make_tn_surr_mv( data, num_surr, ParamSurro, emb_dim, emb_tau);

%construct matrix of conditional entropies for each delay t - H(i,j,t),
%where H(i,j,t) -> H(i|j) at t

[H] = make_cond_ent_matrix(M, trans_network, trans_network_surr, delays, num_surr);

[C]  = find_conn_and_delays(H, delays);

[H]  = remove_ncn(C, H, trans_network);





C=cell(M,1);
for i=1:1:M
    K=setdiff(1:M,i);
    count=0;
    for k=1:1:length(K)
        for j=1:1:length(tau)           
            Hc(j)= entropy(X(tau(j)+1:end,i)', X(1:end-tau(j),K(k))');
            for ns=1:19
                data_surr = ASR_SurrogateMulti(data([i K(k)],:),ParamSurro);
                [~, op_tn_1s, ~, ~] = make_transition_network(data_surr(1,:), emb_params.d, emb_params.tau(1));
                [~, op_tn_2s, ~, ~] = make_transition_network(data_surr(2,:), emb_params.d, emb_params.tau(2));
                Xs = [op_tn_1s(:,1) op_tn_2s(:,1)];
                Hs(ns)= entropy(Xs(tau(j)+1:end,1)', Xs(1:end-tau(j),2)');
            end
            %Hthr=min(Hs);
            Z = abs(Hc(j) - mean(Hs))./std(Hs);
                %if ((H_max - Hc(j) > tol_h))
                if Z > 1.96
                    count=count+1;
                    C{i}.N(count,1) = K(k);
                    C{i}.delay(count,1) = tau(j);
                    C{i}.H(count,1) = Hc(j);
                end
        end
    end
end

for i=1:1:M
    if ~isempty(C{i})
        count=0;
        K = C{i}.N;
        max_delay = max(C{i}.delay);
        Y=[];
        if length(K) > 1
            for m=1:1:length(K)
                Y=[Y;X(max_delay-C{i}.delay(m)+1:end-C{i}.delay(m),C{i}.N(m))' ];
            end
            for j=1:1:length(C{i}.N)
                v=setdiff(1:length(C{i}.N), j);
                    Yv=[];
                    for n=1:1:length(v)
                        Yv=[Yv;X(max_delay-C{i}.delay(v(n))+1:end-C{i}.delay(v(n)),C{i}.N(v(n)))' ];
                    end
                hh=entropy(X(max_delay+1:end,i)', Yv) - entropy(X(max_delay+1:end,i)', Y);
                if abs(hh)<tol_c
                    count=count+1;
                    C{i}.NCN(count) = C{i}.N(j);
                end
            end
        end
    end
end

%build adj matrix
for i=1:1:M
    if ~isempty(C{i})
        if ~isfield(C{i}, 'NCN')
            for j=1:1:length(C{i}.N)
                A(C{i}.N(j), i, C{i}.delay(j)) = C{i}.H(j);
            end
        else
            CN = setdiff(C{i}.N, C{i}.NCN);
            for j=1:1:length(CN)
                A(CN(j), i, C{i}.delay(find(C{i}.N==CN(j)))) = C{i}.H(find(C{i}.N==CN(j)));
            end
        end
    end
end
end
