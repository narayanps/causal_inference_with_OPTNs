function [ ts_surr] = time_shift_surr(x,s_rate, ns)
numpoints=length(x); %% number of sample points in raw signal
minskip=s_rate; %% time lag must be at least this big
maxskip=numpoints-s_rate; 
skip=ceil(numpoints.*rand(ns*2,1));
skip(find(skip>maxskip))=[];
skip(find(skip<minskip))=[];
skip=skip(1:ns,1);
for s=1:1:ns
ts_surr(s,:)=[x(skip(s):end) x(1:skip(s)-1)];
end

% K1=50;
% K2=50;
% p=10;
% L=length(x);
% 
% for i=1:1:50
%     K(i,:) = [i L-K2-p+i ];
% end
% 
% for i=1:1:length(K)
%   e(i) = sum((x(K(i,1):(K(i,1)+p)) - x(K(i,2):K(i,2)+p)).^2);
% end
% 
% ind=find(e==min(e));
% ts = x(K(ind,1):K(ind,2));
% ts_surr = [ts(d+1:end) ts(1:d)];
% gamma_1 = ((ts_surr(1) - ts_surr(end)).^2) / sum((ts_surr - mean(ts_surr)).^2);
% gamma_2 = (((ts_surr(2)-ts_surr(1)) - (ts_surr(end)-ts_surr(end-1))).^2) / sum((ts_surr - mean(ts_surr)).^2);