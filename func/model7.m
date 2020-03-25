function X = model7(N)
N_ignore=10000;
x_1(1:2) = randn(2,1);
x_2(1:2) = randn(2,1);
x_3(1:2) = randn(2,1);
for i=3:1:N+N_ignore
    x_1(i) = 3.4 * x_1(i-1) * (1 - x_1(i-1)*x_1(i-1))*exp(-(x_1(i-1).^2)) + 0.4*randn;
    x_2(i) = 3.4 * x_2(i-1) * (1 - x_2(i-1)*x_2(i-1))*exp(-(x_2(i-1).^2)) + 0.5*x_1(i-1)*x_2(i-1) + 0.4*randn;
    x_3(i) = 3.4 * x_3(i-1) * (1 - x_3(i-1)*x_3(i-1))*exp(-(x_3(i-1).^2)) + 0.3*x_2(i-1)  + 0.5*x_1(i-1).^2 + 0.4*randn;
    
end
X = [x_1(N_ignore+1:end); x_2(N_ignore+1:end);x_3(N_ignore+1:end)];
