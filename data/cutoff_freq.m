close all;
f = [500 800 1e3 1.5e3 2e3 3e3 5e3 8e3];
Vout_200m = [0.2 0.196 0.19 0.18 0.155 0.14 0.106 0.065];
Vout_500m = [0.408 0.4 0.392 0.37 0.343 0.294 0.204 0.105];

figure;
loglog(f,Vout_200m/0.2,'r.','MarkerSize',12);
hold on;
freq = logspace(2,4,100);
loglog(freq,sqrt(1./(1+(freq./3e3).^2)),'r-');
loglog(f,Vout_500m/0.5,'b.','MarkerSize',12);
loglog(freq,sqrt(0.7./(1+(freq./3e3).^2)),'b-');
title("Frequency response of Source Follower");
legend("V_{out}/V_{in} (measured, 200mV_{pp} input)", "V_{out}/V_{in} (fit, 200mV_{pp} input)", "V_{out}/V_{in} (measured, 500mV_{pp} input)", "V_{out}/V_{in} (fit, 500mV_{pp} input)", "Location","southwest")

% model
% Cgs=1e-12;
% rho_C = 2.198e-6; % ohm*m^2
% Rc_80=rho_C/(70*10e-12);
% Rc_30=rho_C/(20*10e-12);
% Rsq=7.8983e4;
% Rd2=Rc_30+13/80*Rsq;
% Rd1=Rc_80+0.1*Rsq;
% Rs1=Rc_80+0.1*Rsq;
% gmroi1=100;
% roi1=1e6;
% roi2=1e6;
% freq = logspace(-20,20,1000);
% av = (Rd2+roi2)*(gmroi1+(Rd1+roi1)*pi*2i*freq*Cgs)./(Rd1+(1+gmroi1)*Rd2+roi1+roi2+Rs1+gmroi1*(roi2+Rs1)+(Rd1+roi1)*(Rd2+Rs1+roi2)*pi*2i*freq*Cgs);
% figure;
% loglog(freq, abs(av));
% 
% Cov=1e-15;
% sCgs=Cgs.*freq*pi*2i;
% sCov=Cov.*freq*pi*2i;
% ZL=(Rd2+roi2)./(1+sCov.*(Rd2+roi2));
% num = ZL.*((Rd1+roi1).*sCgs+(Rd1+roi1+Rs1+(Rd1+roi1)*Rs1.*sCgs).*sCov+gmroi1.*(1+Rs1.*sCov));
% den = (roi1+Rs1*(1+gmroi1)+sCgs.*(roi1*Rs1)+ZL+Rs1.*ZL.*sCov+ZL.*(gmroi1+sCgs.*roi1+sCov.*roi1+gmroi1*Rs1+(sCgs.*sCov).*(roi1*Rs1))+Rd1*(1+Rs1.*sCgs+ZL.*(sCgs+sCov+Rs1.*sCgs.*sCov)));
% av = num./den;
% figure;
% loglog(freq,abs(av));
% 
% % Cov > Cgs in order to get low pass characteristic
% av = (gmroi1.*ZL+sCgs.*roi1.*ZL)./(roi1+ZL+gmroi1.*ZL+sCgs.*ZL.*roi1);
% figure;
% loglog(freq,abs(av));