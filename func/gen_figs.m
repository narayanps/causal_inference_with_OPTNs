close all
figure
title('Linear connectivity')
set(0,'defaultAxesFontSize',20)
load H_biv_lin
H(H<=0) = 6.9;
subplot(2,1,1)
plot(0:10, squeeze(H(2,1,:)), 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,2,:)), 'r', 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,1,:)), 'g', 'LineWidth', 2)
xlabel('Delay')
ylabel('Co-occurence entropy')
legend('1->2', '2->3', '1->3')
title('Linear connectivity (Bivar)')


load H_mul_lin
H(H<=0) = 6.9;
subplot(2,1,2)
plot(0:10, squeeze(H(2,1,:)), 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,2,:)), 'r', 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,1,:)), 'g', 'LineWidth', 2)
xlabel('Delay')
ylabel('Co-occurence entropy ')
legend('1->2', '2->3', '1->3')
title('Linear connectivity (Multivar)')



figure

set(0,'defaultAxesFontSize',20)
load H_biv
H(H<=0) = 6.9;
subplot(2,1,1)
plot(0:10, squeeze(H(2,1,:)), 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,2,:)), 'r', 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,1,:)), 'g', 'LineWidth', 2)
xlabel('Delay')
ylabel('Co-occurence entropy')
legend('1->2', '2->3', '1->3')
title('Non-Linear connectivity (Bivar)')


load H_mul
H(H<=0) = 6.9;
subplot(2,1,2)
plot(0:10, squeeze(H(2,1,:)), 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,2,:)), 'r', 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,1,:)), 'g', 'LineWidth', 2)
xlabel('Delay')
ylabel('Co-occurence entropy ')
legend('1->2', '2->3', '1->3')

title('Non-Linear connectivity (Multivar)')




figure

set(0,'defaultAxesFontSize',20)
load H_biv_lin_nonlin
H(H<=0) = 6.9;
subplot(2,1,1)
plot(0:10, squeeze(H(2,1,:)), 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,2,:)), 'r', 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,1,:)), 'g', 'LineWidth', 2)
xlabel('Delay')
ylabel('Co-occurence entropy')
legend('1->2', '2->3', '1->3')
title('Linear and Non-Linear connectivity (Bivar)')

load H_mul_lin_nonlin
H(H<=0) = 6.9;
subplot(2,1,2)
plot(0:10, squeeze(H(2,1,:)), 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,2,:)), 'r', 'LineWidth', 2)
hold on
plot(0:10, squeeze(H(3,1,:)), 'g', 'LineWidth', 2)
xlabel('Delay')
ylabel('Co-occurence entropy ')
legend('1->2', '2->3', '1->3')

title('Linear and Non-Linear connectivity (Multivar)')