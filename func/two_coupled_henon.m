function X = two_coupled_henon(N)
c=0.5;
N_ignore=10000;
x_1(1) = randn(1,1);
x_2(1) = randn(1,1);
y_1(1) = randn(1,1);
y_2(1) = randn(1,1);
b_1=0.3;
b_2=0.3;
mu=0.3;
for i=2:1:N+N_ignore
x_1(i) = 1.4 - x_1(i-1).^2 + b_1*x_2(i-1);
x_2(i) = x_1(i-1);

y_1(i) = 1.4 - (mu*x_1(i-1)*y_1(i-1) + (1-mu)*y_1(i-1).^2) + b_2*y_2(i-1);
y_2(i) = y_1(i-1);

end
X = [x_1(N_ignore+1:end); y_1(N_ignore+1:end)];