function [C_new, H_new] = remove_false_neighours(C,H, min_delay)
H_new = zeros(size(H));
C_new=cell(size(H,1),1);
for j=1:1:length(C)
    if ~isempty(C{j,1})
        k = unique(C{j,1}.neighbors);
        c=0;
        for i=1:1:length(k)
            tau_ = C{j,1}.tau(find(C{j,1}.neighbors==k(i)));
            %find if taus are more or less consecutive
            if length(tau_) > 1
                
                a=diff(tau_);
                if max(a) < min_delay
                    c=c+1;
                    min_tau_id = find(H(j,k(i),tau_) == min(H(j,k(i),tau_)));
                    tau_to_keep = tau_(min_tau_id);
                    C_new{j,1}.neighbors(c) = k(i);
                    C_new{j,1}.tau(c) = tau_to_keep;
                    H_new(j, k(i), tau_to_keep) = H(j,k(i),tau_to_keep);
                    
                else
                    ids = find(a>2);
                    ids(end+1) = length(tau_);
                    kk=1;
                    for q=1:1:length(ids)
                        c=c+1;
                        tau_grp{q}.grps = tau_(kk:ids(q));
                        min_tau_id = find(H(j,k(i),tau_grp{q}.grps) == min(H(j,k(i),tau_grp{q}.grps)));
                        tau_to_keep = tau_grp{q}.grps(min_tau_id);
                        C_new{j,1}.neighbors(c) = k(i);
                        C_new{j,1}.tau(c) = tau_to_keep;
                        H_new(j, k(i), tau_to_keep) = H(j,k(i),tau_to_keep);
                        kk=ids(q)+1;
                    end
                    ids=[];
                    
                    
                    
                end
            else
                c=c+1;
                C_new{j,1}.neighbors(c) =k(i);
                C_new{j,1}.tau(c) = tau_;
                H_new(j, k(i), tau_) = H(j,k(i),tau_);
            end
        end
    end
end
end