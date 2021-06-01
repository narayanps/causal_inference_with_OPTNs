%The demo code estimates causal network as shown in the figure 2 of the paper
close all
path=pwd;
addpath(genpath(strcat(path, '/func/')));
addpath(strcat(path, '/external/'));
L=10000;


data =  test_model(L);
ent_params.dim = 3;
ent_params.tau=100;
ent_params.th=0.12;
ent_params.min_delay = 1;
ent_params.delays = 1:10;
ent_params.lambda = 0.99;
ent_params.max_var=2;
[H_mvar, ~] = run_multivar_entropy(data, ent_params);
H_mvar(H_mvar==0) = log2(factorial(ent_params.dim));
max_delay = 10; %maximum delay (in samples) upto which causality is tested
plot_interaction_delays(H_mvar, data, ent_params, max_delay)