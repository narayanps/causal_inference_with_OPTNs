function [xout] = ASR_SurrogateMulti(Data,ParamSurro)
% This source code forms part of the resources published along with
% Reference [1]. Please refer to http://www.dtic.upf.edu/~ralph/sc/index.html 
% for further specifications and conditions of use. 

% For a references that describe this particular algorithm please refer to
% [2-4] and references therein.


% References 
% [1] Andrzejak RG, Schindler K and Rummel C, Phys. Rev. E 86, 046206, 2012
% [2] Schreiber T and Schmitz A, Phys. Rev. Lett. 77, 635, 1996
% [3] Schreiber S and Schmitz A, Physica D 142, 346, 2000 
% [4] Andrzejak RG et al. Phys. Rev. E. 68, 066202, 2003 


x = Data';
M = size(x,1);
D = size(x,2);
%Keep amplitude values  of time series
xs= sort(x);
%Keep amplitudes and phases of Fourier coefficients
pwx = abs(fft(x,M));
phix = angle(fft(x,M));
%Start with random shuffle of time series
xsur = zeros(M,D);
temp = zeros(M,D);
P = zeros(M,D);


for mc = 1:D
    xsur(:,mc) = x(randperm(M),mc);
end
for istep = 1:ParamSurro.MaxIter
    phisx = angle(fft(xsur,M));
    alpha = zeros(M,1);
    for cc = 2:ceil(M/2)
        alpha(cc) = atan(sum(sin(phisx(cc,:)-phix(cc,:)))./sum(cos(phisx(cc,:)-phix(cc,:))));
        if sum(cos(alpha(cc)+phix(cc,:)-phisx(cc,:))) < 0
            alpha(cc) = alpha(cc)-pi;
        end
        alpha(M-cc+2) = -alpha(cc);
    end
    fftsurx = pwx.*exp(1i*(phix+repmat(alpha,1,D)));
    xoutb = real(ifft(fftsurx,M));
    for c = 1:D
        [temp(:,c) P(:,c)] = sort(xoutb(:,c));
        xsur(P(:,c),c) = xs(:,c);
    end
end
if ParamSurro.type ==1 
  xout = xsur';
else
 xout = xoutb';    
end

