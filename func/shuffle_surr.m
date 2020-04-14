function [ ts_surr] = shuffle_surr(x,ns)
numpoints=length(x); %% number of sample points in raw signal
for j=1:1:ns
rnd_data=rand(numpoints,1);
sort_rnd_data=sort(rnd_data);
for i=1:numpoints
    loc(i,1)=find(rnd_data==sort_rnd_data(i,1));
end
ts_surr(j,:)=x(1,loc);
end


