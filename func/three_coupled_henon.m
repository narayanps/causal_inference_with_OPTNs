function X = three_coupled_henon(N)
c=0.5;
N_ignore=10000;
x_1(1:2) = randn(2,1);
x_2(1:2) = randn(2,1);
x_3(1:2) = randn(2,1);
for i=3:1:N+N_ignore
x_1(i) = 1.4 - x_1(i-1).^2 + 0.3*x_1(i-2);
x_2(i) = 1.4 - c*x_1(i-1)*x_2(i-1) - (1-c)*x_2(i-1).^2 + 0.3*x_2(i-2);
x_3(i) = 1.4 - c*x_2(i-1)*x_3(i-1) - (1-c)*x_3(i-1).^2 + 0.3*x_3(i-2);
end
X = [x_1(N_ignore+1:end); x_2(N_ignore+1:end);x_3(N_ignore+1:end)];