L = 10000;
Fs = 1000;
data = directed_chain_1(L, 3.5);
ent_params.dim = 3;
ent_params.tau=100;
ent_params.delays=1:10;
ent_params.th=0.005;
win_len = [];
win_step=[];
delays = 1:10;

[H] = run_multivar_entropy(data, Fs, [], win_len, win_step, ent_params);