function X = four_chan_NL(N)
N_ignore=10000;
c12=0.6;
c23=0.8;
c32=0.6;
c24=1.2;
delay_max=3;
x_1(1:delay_max+1) = randn(delay_max+1,1);
x_2(1:delay_max+1) = randn(delay_max+1,1);
x_3(1:delay_max+1) = randn(delay_max+1,1);
x_4(1:delay_max+1) = randn(delay_max+1,1);
for i=4:1:N+N_ignore
    x_1(i) = 3.4 * x_1(i-1) * (1 - x_1(i-1)*x_1(i-1))*exp(-(x_1(i-1).^2)) + randn;
    x_2(i) = 3.4 * x_2(i-1) * (1 - x_2(i-1)*x_2(i-1))*exp(-(x_2(i-1).^2)) + c12*x_1(i-1) + c32*x_3(i-3) + randn;
    x_3(i) = 3.4 * x_3(i-1) * (1 - x_3(i-1)*x_3(i-1))*exp(-(x_3(i-1).^2)) + c23*x_2(i-2)   + randn;
    x_4(i) = 3.4 * x_4(i-1) * (1 - x_4(i-1)*x_4(i-1))*exp(-(x_4(i-1).^2)) + c24*x_2(i-3)  + randn;
    
end
X = [x_1(N_ignore+1:end); x_2(N_ignore+1:end);x_3(N_ignore+1:end); x_4(N_ignore+1:end)];