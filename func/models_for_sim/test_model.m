function [X] = test_model(N)
%example stochastic model used in the paper
%AUTHOR : NARAYAN P SUBRAMANIYAM
%TUNI / MET / 2020

N_ignore=10000;
x_1(1:4) = randn(4,1);
x_2(1:4) = randn(4,1);
x_3(1:4) = randn(4,1);
x_4(1:4) = randn(4,1);
x_5(1:4) = randn(4,1);
x_6(1:4) = randn(4,1);
x_7(1:4) = randn(4,1);
x_8(1:4) = randn(4,1);
x_9(1:4) = randn(4,1);
c_21=2.5; c_31=1.8; c_41=1.5;c_54=1.5; c_64=1.2; c_76=1.5;c_79=1.8; c_78=0.8;
for i=5:1:N+N_ignore
    x_1(i) = 3.4 * x_1(i-1) * (1 - x_1(i-1).^2)*exp(-(x_1(i-1).^2)) + c_21*x_2(i-4) + c_31*x_3(i-2) + c_41*x_4(i-2) + 0.4*randn;
    x_2(i) = 3.4 * x_2(i-1) * (1 - x_2(i-1).^2)*exp(-(x_2(i-1).^2)) +0.4*randn;
    x_3(i) = 3.4 * x_3(i-1) * (1 - x_3(i-1).^2)*exp(-(x_3(i-1).^2))  + 0.25*x_1(i-1) + 0.4*randn;
    x_4(i) = 3.4 * x_4(i-1) * (1 - x_4(i-1).^2)*exp(-(x_4(i-1).^2)) + c_54*x_5(i-3) + c_64*x_6(i-1) + 0.4*randn;
    x_5(i) = 3.4 * x_5(i-1) * (1 - x_5(i-1).^2)*exp(-(x_5(i-1).^2)) + 0.4*randn;
    x_6(i) = 3.4 * x_6(i-1) * (1 - x_6(i-1).^2)*exp(-(x_6(i-1).^2)) + c_76*x_7(i-3) + 0.4*randn;
    x_7(i) = 3.4 * x_7(i-1) * (1 - x_7(i-1).^2)*exp(-(x_7(i-1).^2)) + 0.4*randn;
    x_8(i) = 3.4 * x_8(i-1) * (1 - x_8(i-1).^2)*exp(-(x_8(i-1).^2)) + c_78*x_7(i-1) + 0.4*randn;
    x_9(i) = 3.4 * x_9(i-1) * (1 - x_9(i-1).^2)*exp(-(x_9(i-1).^2)) + c_79*x_7(i-1) + 0.4*randn;
end
X = [x_1(N_ignore+1:end); x_2(N_ignore+1:end);x_3(N_ignore+1:end);x_4(N_ignore+1:end);...
    x_5(N_ignore+1:end);x_6(N_ignore+1:end);x_7(N_ignore+1:end);x_8(N_ignore+1:end); x_9(N_ignore+1:end)];


