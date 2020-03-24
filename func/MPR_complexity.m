function [C_JS] = MPR_complexity(H_S, P, P_e, D)

% statistical complexity based on Jensen-Shannon divergence
%compute the normalization constant Q_0
Q_1 = ((D+1)/D)*log(D+1);
Q_2 = 2*log(2*D);
Q_3 = log(D);
Q_0 = -2*((Q_1 - Q_2 + Q_3).^(-1));

%compute Jensen-Shannon divergence
J = Shannon_ent((P+P_e)./2) - 0.5*Shannon_ent(P) - 0.5*Shannon_ent(P_e);
Q_J = Q_0 * J;
C_JS = Q_J * H_S;
        
end

