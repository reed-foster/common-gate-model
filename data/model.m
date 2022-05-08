close all;
freq = logspace(2, 15, 1000);
omega = 2*pi*freq;
eps0 = 8.854e-12; % F/m

% Day 2 measurements 04_??
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vb1 = -8        % Vb1 = -7         % Vb1 = -6         % Vb1 = -5        % Vb1 = -4
% Vb2 = -4        % Vb2 = -3         % Vb2 = -2         % Vb2 = -1        % Vb2 = 0
% Vin,DC = 0      % Vin,DC = 0       % Vin,DC = 0       % Vin,DC = 0      % Vin,DC = 0
% Vdd = 6         % Vdd = 6          % Vdd = 6          % Vdd = 6         % Vdd = 6
% Vout,DC = 0.8   % Vout,DC = 0.758  % Vout,DC = 0.716  % Vout,DC = 0.68  % Vout,DC = 0.66
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vgs1 = -8       % Vgs1 = -7        % Vgs1 = -6        % Vgs1 = -5       % Vgs1 = -4
% Vgs2 = -4.8     % Vgs2 = -3.758    % Vgs2 = -2.716    % Vgs2 = -1.68    % Vgs2 = -0.66
% Vds1 = 0.8      % Vds1 = 0.758     % Vds1 = 0.716     % Vds1 = 0.68     % Vds1 = 0.66
% Vds2 = 5.2      % Vds2 = 5.242     % Vds2 = 5.284     % Vds2 = 5.32     % Vds2 = 5.34
% Id1 = 11.207uA  % Id1 = 18.252uA   % Id1 = 26.1577uA  % Id1 = 26.29uA   % Id1 = 32.3363uA
% Id2 = 17.892uA  % Id2 = 24.8178uA  % Id2 = 33.5259uA  % Id2 = 43.45uA   % Id2 = 49.8219uA

% Day 4 measurements 04_22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vin,DC = -6      % Vin,DC = -6       % Vin,DC = -6       % Vin,DC = -6      % Vin,DC = -6
% VDD = 8          % VDD = 8           % VDD = 8           % VDD = 8          % VDD = 8
% Vb1 = -12        % Vb1 = -12         % Vb1 = -12         % Vb1 = -12        % Vb1 = -12
% Vb2 = 0          % Vb2 = 2           % Vb2 = 4           % Vb2 = 6          % Vb2 = 8
% Vout,DC = -1.44  % Vout,DC = -0.611  % Vout,DC = -0.131  % Vout,DC = 0.511  % Vout,DC = 0.960
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vgs1 = -6        % Vgs1 = -6         % Vgs1 = -6         % Vgs1 = -6        % Vgs1 = -6
% Vgs2 = 1.44      % Vgs2 = 2.611      % Vgs2 = 4.131      % Vgs2 = 5.489     % Vgs2 = 7.04
% Vds1 = 4.56      % Vds1 = 5.389      % Vds1 = 5.869      % Vds1 = 6.511     % Vds1 = 6.960
% Vds2 = 9.44      % Vds2 = 8.611      % Vds2 = 8.131      % Vds2 = 7.489     % Vds2 = 7.04

% extract from data instead of manually
Lacc = 2;
Rsq = 78.98e3; % Ohm/sq
Rc = 2.2e6; % Ohm*um^2
% sheet and contact resistances
Rs1 = Lacc/80*Rsq + Rc/(10*70); % 9/80 squares + Rc
Rd1 = Lacc/80*Rsq;
Rs2 = Lacc/30*Rsq;
Rd2 = Lacc/30*Rsq + Rc/(10*20);
Rco = Rc/(10*70);
[gm1, ro1, gmi1, roi1, id1, vds1, vgs1] = get_transistor_props('0502_DC_IV/80_5_IV.csv', linspace(0,10,51), 71, Rd1, Rs1);
[gm2, ro2, gmi2, roi2, id2, vds2, vgs2] = get_transistor_props('0502_DC_IV/30_5_IV.csv', linspace(0,10,51), 111, Rd2, Rs2);
% find small signal params at each bias point
% 1:5 are day 2 measurements (see bottom half of day2_measurements.m)
% 6:10 are day 4 measurements (see day4_cg_measurements.m)
vgs1_bias = [-8 -7 -6 -5 -4 -6 -6 -6 -6 -6];
vds1_bias = [0.8 0.758 0.716 0.68 0.66 4.56 5.389 5.869 6.511 6.960];
vgs2_bias = [-4.8 -3.758 -2.716 -1.68 -0.66 1.44 2.511 4.131 5.489 7.04];
vds2_bias = [5.2 5.242 5.284 5.32 5.34 9.44 8.611 8.131 7.489 7.04];
[~, vgs1_idx] = min(abs(vgs1' - vgs1_bias));
[~, vds1_idx] = min(abs(vds1' - vds1_bias));
[~, vgs2_idx] = min(abs(vgs2' - vgs2_bias));
[~, vds2_idx] = min(abs(vds2' - vds2_bias));
gm1_list = zeros(1,10);
gm2_list = zeros(1,10);
ro1_list = zeros(1,10);
ro2_list = zeros(1,10);
for i=1:10
    gm1_list(i) = gmi1(vgs1_idx(i), vds1_idx(i));
    ro1_list(i) = roi1(vgs1_idx(i), vds1_idx(i));
    gm2_list(i) = gmi2(vgs2_idx(i), vds2_idx(i));
    ro2_list(i) = roi2(vgs2_idx(i), vds2_idx(i));
end
tSi = 300e-6;
rCap = 50e-6; % m: order of magnitude size of IGZO-SiO2-Si capacitor bottom plate
rWafer = 0.1524; % m: 6"
Rsub = 10*tSi/(pi*rCap*rWafer); % resistance to ground through substrate (assuming resistivity of Si is 10 Ohm*m -> ~1e16/cm^3 doping)
tSiO2 = 420e-9; % m
tAlOx = 30e-9; % m
kSiO2 = 3.9;
kAlOx = 9;
Cs1 = 80e-6*49e-6/2*kSiO2*eps0/tSiO2; % lumped capacitance from IGZO to substrate
Cd1 = 80e-6*49e-6/2*kSiO2*eps0/tSiO2;
Cs2 = 30e-6*49e-6/2*kSiO2*eps0/tSiO2;
Cd2 = 30e-6*49e-6/2*kSiO2*eps0/tSiO2;
Cch1 = 2/3*80e-6*9e-6*kAlOx*eps0/tAlOx;
Cch2 = 2/3*30e-6*9e-6*kAlOx*eps0/tAlOx;
Cpad = (100e-6*150e-6+25e-6*240e-6)*eps0*(kSiO2*kAlOx/(kAlOx*tSiO2+kSiO2*tAlOx));

colors = {'r','g','b','c','m'};
for i=6:10 % only plot day 4 measurements
    gm1 = gm1_list(i);
    gm2 = gm2_list(i);
    ro1 = ro1_list(i);
    ro2 = ro2_list(i);
    if i == 1
        f = [100 150 200 300 500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3];
        vout = [178 180 180 178 176 176 176 174 172 170 166 154 144 122 104 78 52 36];
    elseif i == 2
        f = [1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3];
        vout = [178 178 174 174 172 166 158 142 126 98 66 44 37 26 20 13];
    elseif i == 3
        vout = [180 180 178 180 178 172 170 158 142 120 83 56 46 33 25 17];
    elseif i == 4
        vout = [178 178 182 180 180 174 172 164 151 131 97 68 57 40 32 22];
    elseif i == 5
        f = [1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3 500e3];
        vout = [180 180 182 182 180 176 176 168 162 144 110 80 66 47 37 26 10];
    elseif i == 6
        f = [500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3 500e3 800e3 1e6];
        vin = 206;
        vout_mag = [312 310 305 300 301 294 290 284 280 268 261 231 181 122 107 71 56 38 25 17 13];
        vout_phase = [4 4 3 5 6 8 10 13 16 24 29 38 52 66 71 76 80 84 85 88 90];
    elseif i == 7
        f = [500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3 500e3 800e3 1e6];
        vin = 209;
        vout_mag = [352 348 346 345 342 340 340 330 326 310 293 258 201 141 117 80 61 41 27 17 15];
        vout_phase = [1 2 3 3 4 6 9 14 17 24 33 41 56 67 73 78 82 86 89 90 90];
    elseif i == 8
        f = [500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3 500e3 800e3 1e6];
        vin = 206;
        vout_mag = [366 362 360 358 356 350 346 340 334 318 300 261 207 147 121 85 66 47 28 18 15];
        vout_phase = [3 2 3 5 5 6 9 14 17 24 30 41 54 67 72 77 86 86 90 90 90];
    elseif i == 9
        f = [500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3 500e3 800e3 1e6];
        vin = 206;
        vout_mag = [372 368 366 362 360 356 350 342 340 320 302 246 205 139 118 84 62 43 28 19 15];
        vout_phase = [3 3 3 4 5 6 10 15 18 25 32 43 56 67 73 76 82 86 87 88 90];
    elseif i == 10
        f = [500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3 500e3 800e3 1e6];
        vin = 206;
        vout_mag = [386 378 374 370 370 366 358 350 342 326 306 265 205 145 117 80 64 43 28 17 14];
        vout_phase = [3 4 4 4 5 8 10 15 18 26 32 43 57 67 72 80 82 86 87 90 90];
    end

    for j = 1:2
        figure(j);
        cp = Cpad;
        if j == 2
            cp = 60*Cpad;
        end
        Ysub_s1 = 1./(Rsub+1./(1j*omega*Cs1));
        Ysub_d1 = 1./(Rsub+1./(1j*omega*Cd1));
        Ysub_s2 = 1./(Rsub+1./(1j*omega*Cs2));
        Ysub_d2 = 1./(Rsub+1./(1j*omega*Cd2));
        sCch1 = 1j*omega*Cch1;
        sCch2 = 1j*omega*Cch2;
        Ypad = 1./(Rsub+1./(1j*omega*cp));
    
        ZL = Rs2 + (Rd2+ro2+Rd2*ro2*Ysub_d2)./(1+Rd2*(sCch2+Ysub_d2)+ro2*(gm2+sCch2).*(1+Rd2*Ysub_d2)+Ysub_s2.*(Rd2+ro2+Rd2*ro2*Ysub_d2));
        av_num = (gm1*ro1+1)*(Rd1+ZL+Rco*Ypad.*ZL+Rd1*Ypad.*(Rco+ZL))./(1+Rs1*Ypad);
        av_den = Rs1 + Rco*Rs1*Ypad+ZL+Rco*(ZL.*Ypad)+Rs1*ZL.*(sCch1+Ypad+Rco*(sCch1.*Ypad)+Ysub_d1+Ysub_s1+Rco*Ypad.*(Ysub_d1+Ysub_s1));
        av_den = av_den + ro1*(1+Rs1*(gm1+sCch1+Ysub_s1)).*(1+Rco*Ypad+ZL.*(Ypad+Ysub_d1+Rco*Ysub_d1.*Ypad));
        av_den = av_den + Rd1*(1+Ypad.*(Rco+ZL)).*(1+ro1*Ysub_d1+Rs1*(sCch1+Ysub_d1+ro1*(sCch1.*Ysub_d1)+Ysub_s1+ro1*Ysub_d1.*(gm1+Ysub_s1)));
        av = av_num./av_den;
    
        subplot(2,1,1);
        loglog(freq, abs(av), 'Color', colors{mod(i-1,5)+1}, 'Linewidth', 1);
        hold on;
        if i <= 5
            loglog(f, vout./200, '.', 'Color', colors{i}, 'Markersize', 10);
        else
            loglog(f, vout_mag./vin, '.', 'Color', colors{mod(i-1,5)+1}, 'Markersize', 10);
        end
    
        subplot(2,1,2);
        semilogx(freq, angle(av)*180/pi, 'Color', colors{mod(i-1,5)+1}, 'Linewidth', 1);
        hold on;
        if i > 5
            semilogx(f, -vout_phase, '.', 'Color', colors{mod(i-1,5)+1}, 'Markersize', 10);
        end
        [~,f3dB_idx] = min(abs(abs(av) - abs(av(1)/sqrt(2))));
        f3dB = freq(f3dB_idx);
        display(strcat("f3dB [kHz] = ", num2str(f3dB/1e3)));
    end
end
for j = 1:2
    f = figure(j);
    subplot(2,1,1);
    %xlim([1e2 1e7]);
    %title("Small signal model frequency response");
    ylabel("|A_v|(f)");
    legend('', 'V_{b} = 0V (exp)', '', 'V_{b} = 2V (exp)', '', 'V_{b} = 4V (exp)', '', 'V_{b} = 6V (exp)', '', 'V_{b} = 8V (exp)', 'Location','southwest')
    subplot(2,1,2);
    %xlim([1e2 1e7]);
    %ylim([-100 0]);
    legend('V_{b} = 0V (model)', '', 'V_{b} = 2V (model)', '', 'V_{b} = 4V (model)', '', 'V_{b} = 6V (model)', '', 'V_{b} = 8V (model)', '', 'Location','southwest')
    ylabel("\angle A_v(f)");
    xlabel("frequency [Hz]");
end
