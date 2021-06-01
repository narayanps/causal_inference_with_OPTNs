function [state] = three_coupled_lorenz(state,params,N)
%AUTHOR : NARAYAN P SUBRAMANIYAM
%TUNI / MET / 2020
N_ignore=10000;
for i=1:1:N+N_ignore
    state_dot = lorenz(state(:,i),params);
    [state(:,i+1)] = rk4(state(:,i),state_dot, params);
end
state=state(:,N_ignore+1:end);

end

function [state] = rk4(state,state_dot,params)

dt=0.05;
tmp=state;
k1 = dt * state_dot;
state = tmp + 0.5*k1;
state_dot = lorenz(state,params);

k2 = dt * state_dot;
state = tmp + 0.5*k2;
state_dot = lorenz(state,params);

k3 = dt * state_dot;
state = tmp + k3;
state_dot = lorenz(state,params);

k4 = dt * state_dot;


state = tmp + (k1 + 2*k2 + 2*k3 + k4)/6;
end


function [state_dot] = lorenz(state,params)
c=1;
x1 = state(1);
y1 = state(2);
z1 = state(3);

x2 = state(4);
y2 = state(5);
z2 = state(6);

x3 = state(7);
y3 = state(8);
z3 = state(9);


sigma = params(1);
r = params(2);
beta = params(3);


state_dot(1,1) = sigma*(y1 - x1);
state_dot(2,1) = x1*r - y1 - x1*z1;
state_dot(3,1) = x1*y1 - beta*z1;

state_dot(4,1) = sigma*(y2 - x2) + c*(x1-x2);
state_dot(5,1) = x2*r - y2 - x2*z2;
state_dot(6,1) = x2*y2 - beta*z2;

state_dot(7,1) = sigma*(y3 - x3) + c*(x2-x3);
state_dot(8,1) = x3*r - y3 - x3*z3;
state_dot(9,1) = x3*y3 - beta*z3;
end



