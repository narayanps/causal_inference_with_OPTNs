% clear all
% close all 
% clc
%NMM code taken from from Ursino et al 2019

function[eeg1, Wp] = NMM_data_Generation(n_rois, density, delay)

Npop=n_rois; % Number of ROIs

% time definition
dt=0.0001;
f_eulero=1/dt;
tend=120; % 56 sec, because one second will be excluded for transitory effects
t=(0:dt:tend);
N=length(t);

rng(11)  % noise seed

%% parameters definition
% Connectivity constants 
C(:,1) = 40.*ones(1,Npop); %Cep
C(:,2) = 40.*ones(1,Npop); %Cpe
C(:,3) = 40.*ones(1,Npop); %Csp
C(:,4) = 50.*ones(1,Npop); %Cps   
C(:,5) = 20.*ones(1,Npop); %Cfs
C(:,6) = 40.*ones(1,Npop); %Cfp
C(:,7) = 60.*ones(1,Npop); %Cpf
C(:,8) = 20.*ones(1,Npop); %Cff
 

% definition of excitatory and inhibitory synapses

Wp=zeros(Npop);
S = Npop*sprand(Npop, Npop, density);
D = digraph(S);
for j=1:1:size(D.Edges,1)
    Wp(D.Edges.EndNodes(j,2), D.Edges.EndNodes(j,1)) = randi([55 70],1,1);
end
Wp = Wp - diag(diag(Wp));


%excitatorty synapses
% Wp(1,2)=70;   % Wp_12 = 0, 20, 40, 60, 80 : 5 points (a,b,c,d,e) for each panel
% Wp(2,1)=0;
% Wp(3,1)=0;  % 0, 20, 40, 60 : 4 panels 
% Wp(2,3)=0;  % 0, 20, 40, 60 : 4 panels 
% Wp(3,2)=0;


% inhibitory synapses
Wf=zeros(Npop); 


e0 = 2.5; % Saturation value of the sigmoid
r = 0.56; % Slope of the sigmoid

D=delay*ones(1,Npop); % Delay between regions
                
a=[75 30 300 ]; % Reciprocal of synaptic time constants (\omega)             

G=[5.17 4.45 57.1]; % Synaptic gains
                   
 %% Simulation
for trial = 1: 1

disp(trial)

sigma = sqrt(9/dt); % Standard deviation of the input noise
np = randn(Npop,N)*sigma; % input noise to excitatory neurons
nf = randn(Npop,N)*sigma; % input noise to inhibitory neurons

% defining equations of a single ROI
yp=zeros(Npop,N);
xp=zeros(Npop,N);
vp=zeros(Npop,1);
zp=zeros(Npop,N);
ye=zeros(Npop,N);
xe=zeros(Npop,N);
ve=zeros(Npop,1);
ze=zeros(Npop,N);
ys=zeros(Npop,N);
xs=zeros(Npop,N);
vs=zeros(Npop,1);
zs=zeros(Npop,N);
yf=zeros(Npop,N);
xf=zeros(Npop,N);
zf=zeros(Npop,N);
vf=zeros(Npop,1);
xl=zeros(Npop,N);
yl=zeros(Npop,N);

step_red = 100;  % step reduction from 10000 to 100 Hz
fs = f_eulero/step_red;
eeg=zeros(Npop,(N-1-10000)/step_red);  % exclusion of the first second due to a possible transitory

m = zeros(Npop,1); % mean value of the input noise

kmax=round(max(D)/dt);

for k=1:N-1
   up=np(:,k)+m; % input of exogenous contributions to excitatory neurons
   uf=nf(:,k);  % input of exogenous contributions to inhibitory neurons
    
    if(k>kmax)
        for i=1:Npop
            up(i)=up(i)+Wp(i,:)*zp(:,round(k-D(i)/dt));
            uf(i)=uf(i)+Wf(i,:)*zp(:,round(k-D(i)/dt));
        end
    end
   
    % post-synaptic membrane potentials
    vp(:)=C(:,2).*ye(:,k)-C(:,4).*ys(:,k)-C(:,7).*yf(:,k);
    ve(:)=C(:,1).*yp(:,k);
    vs(:)=C(:,3).*yp(:,k);
    vf(:)=C(:,6).*yp(:,k)-C(:,5).*ys(:,k)-C(:,8).*yf(:,k)+yl(:,k);
    
    % average spike density
    zp(:,k)=2*e0./(1+exp(-r*(vp(:))))-e0;
    ze(:,k)=2*e0./(1+exp(-r*(ve(:))))-e0;
    zs(:,k)=2*e0./(1+exp(-r*(vs(:))))-e0;
    zf(:,k)=2*e0./(1+exp(-r*(vf(:))))-e0;
    
    % post synaptic potential for pyramidal neurons
    xp(:,k+1)=xp(:,k)+(G(1)*a(1)*zp(:,k)-2*a(1)*xp(:,k)-a(1)*a(1)*yp(:,k))*dt;   
    yp(:,k+1)=yp(:,k)+xp(:,k)*dt; 
    
    % post synaptic potential for excitatory interneurons
    xe(:,k+1)=xe(:,k)+(G(1)*a(1)*(ze(:,k)+up(:)./C(:,2))-2*a(1)*xe(:,k)-a(1)*a(1)*ye(:,k))*dt;  
    ye(:,k+1)=ye(:,k)+xe(:,k)*dt; 
    
    % post synaptic potential for slow inhibitory interneurons
    xs(:,k+1)=xs(:,k)+(G(2)*a(2)*zs(:,k)-2*a(2)*xs(:,k)-a(2)*a(2)*ys(:,k))*dt;   
    ys(:,k+1)=ys(:,k)+xs(:,k)*dt; 
    
    % post synaptic potential for fast inhibitory interneurons
    xl(:,k+1)=xl(:,k)+(G(1)*a(1)*uf(:)-2*a(1)*xl(:,k)-a(1)*a(1)*yl(:,k))*dt;  
    yl(:,k+1)=yl(:,k)+xl(:,k)*dt; 
    xf(:,k+1)=xf(:,k)+(G(3)*a(3)*zf(:,k)-2*a(3)*xf(:,k)-a(3)*a(3)*yf(:,k))*dt;   
    yf(:,k+1)=yf(:,k)+xf(:,k)*dt; 


end

% 3 ROIs data generation
start = 10000; % exclusion of the first second due to a possible transitory
eeg=diag(C(:,2))*ye(:,start:step_red:end)-diag(C(:,4))*ys(:,start:step_red:end)-diag(C(:,7))*yf(:,start:step_red:end);

switch trial
    case 1
        eeg1 = eeg;
    case 2
        eeg2 = eeg;
    case 3
        eeg3 = eeg;
    case 4
        eeg4 = eeg;
    case 5
        eeg5 = eeg;
    case 6
        eeg6 = eeg;
    case 7
        eeg7 = eeg;
    case 8
        eeg8 = eeg;
    case 9
        eeg9 = eeg;
    case 10
        eeg10 = eeg;
end
end

tt=t(start:step_red:end); % time vector