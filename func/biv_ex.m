function X = biv_ex(N)
N_ignore=10000;
c=0.5;    
delay_1= 2;
delay_2= 2;
x_1(1:delay_1) = randn(1,delay_1);
x_2(1:delay_2) = randn(1,delay_2);
for i=1:1:N+N_ignore
    x_1(i+delay_1) = 3.4 * x_1(i+1) * (1 - x_1(i+1)*x_1(i+1))*exp(-(x_1(i+1).^2)) + 0.8*x_1(i) + randn;
    x_2(i+delay_1) = 3.4 * x_2(i+1) * (1 - x_2(i+1)*x_2(i+1))*exp(-(x_2(i+1).^2)) + 0.5*x_2(i) + c*x_1(i).^2 + randn;
    
end
X = [x_1(N_ignore+1:end) ; x_2(N_ignore+1:end);];