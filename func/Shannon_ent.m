function [H] = Shannon_ent(P)
H = -sum(P(P>0) .* log2(P(P>0)));
end

