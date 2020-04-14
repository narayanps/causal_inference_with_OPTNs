function X = directed_chain_1(N)
N_ignore=10000;
c_1=3.7;
c_2=3.9;
c=0.7;
x_1(1:2) = randn(2,1);
x_2(1:2) = randn(2,1);
x_3(1:2) = randn(2,1);
for i=3:1:N+N_ignore
    x_1(i) = 3.4 * x_1(i-1) * (1 - x_1(i-1)*x_1(i-1))*exp(-(x_1(i-1).^2)) + randn;
    x_2(i) = 3.4 * x_2(i-1) * (1 - x_2(i-1)*x_2(i-1))*exp(-(x_2(i-1).^2)) + c_1*x_1(i-1).^2 + 0*x_3(i-1) + randn;
    x_3(i) = 3.4 * x_3(i-1) * (1 - x_3(i-1)*x_3(i-1))*exp(-(x_3(i-1).^2)) + c_2*x_2(i-1)   + randn;
    
end
X = [x_1(N_ignore+1:end); x_2(N_ignore+1:end);x_3(N_ignore+1:end)];