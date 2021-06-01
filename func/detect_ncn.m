function [ncn] = detect_ncn(m, thr)
% [vals, id_1] = sort(m);
% d = diff(vals);
% id_2 = find(d>thr);
% ncn = setdiff(1:length(m), id_1(id_2+1));
c  =min(m);
m = m - c;
ncn = find(m<thr);
end