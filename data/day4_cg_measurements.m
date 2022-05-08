close all
f = [500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3 500e3 800e3 1e6];
% vin = 211;
% % vin,DC = 5V
% % vb,2 = 0V
% vout = [320 318 316 314 314 310 308 300 295 280 268 233 175 ];

Av_data = zeros(1,10);
Bw_data = zeros(1,10);

Av_data(6:10) = [180 178 180 180 180]./200;
Bw_data(6:10) = [14e3 20e3 26e3 31e3 38e3];

freq = logspace(2, 6, 100);
% vb,2 = 0V
f3dB = 3.72e4;
Bw_data(1) = f3dB;
vin = 206;
vout_mag = [312 310 305 300 301 294 290 284 280 268 261 231 181 122 107 71 56 38 25 17 13];
Av = vout_mag(1)/vin;
Av_data(1) = Av;
vout_phase = [4 4 3 5 6 8 10 13 16 24 29 38 52 66 71 76 80 84 85 88 90];
figure;
subplot(2,1,1);
loglog(f, vout_mag./vin, 'r.', 'MarkerSize', 12);
hold on;
loglog(freq, Av.*sqrt(1./(1+(freq./f3dB).^2)), 'r-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);
subplot(2,1,2);
semilogx(f, -vout_phase, 'r.', 'MarkerSize', 12);
hold on;
semilogx(freq, -180/pi*atan(freq./f3dB), 'r-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);

% vb,2 = 2V
f3dB = 3.46e4;
Bw_data(2) = f3dB;
vin = 209;
vout_mag = [352 348 346 345 342 340 340 330 326 310 293 258 201 141 117 80 61 41 27 17 15];
Av = vout_mag(1)/vin;
Av_data(2) = Av;
vout_phase = [1 2 3 3 4 6 9 14 17 24 33 41 56 67 73 78 82 86 89 90 90];
subplot(2,1,1);
loglog(f, vout_mag./vin, 'b.', 'MarkerSize', 12);
hold on;
loglog(freq, Av.*sqrt(1./(1+(freq./f3dB).^2)), 'b-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);
subplot(2,1,2);
semilogx(f, -vout_phase, 'b.', 'MarkerSize', 12);
hold on;
semilogx(freq, -180/pi*atan(freq./f3dB), 'b-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);

% vb,2 = 4V
f3dB = 3.45e4;
Bw_data(3) = f3dB;
vin = 206;
vout_mag = [366 362 360 358 356 350 346 340 334 318 300 261 207 147 121 85 66 47 28 18 15];
Av = vout_mag(1)/vin;
Av_data(3) = Av;
vout_phase = [3 2 3 5 5 6 9 14 17 24 30 41 54 67 72 77 86 86 90 90 90];
subplot(2,1,1);
loglog(f, vout_mag./vin, 'g.', 'MarkerSize', 12);
hold on;
loglog(freq, Av.*sqrt(1./(1+(freq./f3dB).^2)), 'g-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);
subplot(2,1,2);
semilogx(f, -vout_phase, 'g.', 'MarkerSize', 12);
hold on;
semilogx(freq, -180/pi*atan(freq./f3dB), 'g-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);

% vb,2 = 6V
f3dB = 3.2e4;
Bw_data(4) = f3dB;
vin = 206;
vout_mag = [372 368 366 362 360 356 350 342 340 320 302 246 205 139 118 84 62 43 28 19 15];
Av = vout_mag(1)/vin;
Av_data(4) = Av;
vout_phase = [3 3 3 4 5 6 10 15 18 25 32 43 56 67 73 76 82 86 87 88 90];
subplot(2,1,1);
loglog(f, vout_mag./vin, 'm.', 'MarkerSize', 12);
hold on;
loglog(freq, Av.*sqrt(1./(1+(freq./f3dB).^2)), 'm-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);
subplot(2,1,2);
semilogx(f, -vout_phase, 'm.', 'MarkerSize', 12);
hold on;
semilogx(freq, -180/pi*atan(freq./f3dB), 'm-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);

% vb,2 = 8V
f3dB = 3.15e4;
Bw_data(5) = f3dB;
vin = 206;
vout_mag = [386 378 374 370 370 366 358 350 342 326 306 265 205 145 117 80 64 43 28 17 14];
Av = vout_mag(1)/vin;
Av_data(5) = Av;
vout_phase = [3 4 4 4 5 8 10 15 18 26 32 43 57 67 72 80 82 86 87 90 90];
subplot(2,1,1);
loglog(f, vout_mag./vin, 'c.', 'MarkerSize', 12);
hold on;
loglog(freq, Av.*sqrt(1./(1+(freq./f3dB).^2)), 'c-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);
ylabel("|A_v|(f)");
title("Frequency-dependent gain A_v(f) of common-gate amplifier")
legend('V_{b,load} = 0V', '', 'V_{b,load} = 2V', '', 'V_{b,load} = 4V', '', 'V_{b,load} = 6V', '', 'V_{b,load} = 8V', '', 'Location','southwest')
subplot(2,1,2);
semilogx(f, -vout_phase, 'c.', 'MarkerSize', 12);
hold on;
semilogx(freq, -180/pi*atan(freq./f3dB), 'c-', 'LineWidth', 0.5);
hold on;
xlim([500 1e6]);
ylabel("\angle A_v(f)");
xlabel("frequency [Hz]");

% normalize to power consumption
Pdc = [1.147 1.187 1.199 1.204 1.205 0.1074 0.1489 0.2012 0.2607 0.2989]; % mW
% figure;
% plot([0 2 4 6 8], Pdc);
% title("DC Power consumption vs. Vbias");
% xlabel("V_{b,load} [V]");
% ylabel("Power consumption [mW]");

figure;
plot(Av_data, Bw_data/1e3, 'b.', 'MarkerSize', 12);
hold on;
av_sweep = linspace(0.8, 2);
GBW_avg = (sum(Av_data.*Bw_data))/10;% - Av_data(3)*Bw_data(3))/4; % arithmetic mean of gain bandwidth product
%GBW = 5.8e4;
plot(av_sweep, GBW_avg./av_sweep/1e3, 'b-', 'Linewidth', 0.5);
%xlim([1.5 2]);
title("3dB bandwidth vs. DC gain");
xlabel("A_{v,DC}");
ylabel("f_{3dB} [kHz]");
legend("measured data", "fit (assuming constant GBW)");

figure;
plot(Pdc, Av_data.*(Bw_data/1e3), 'r.', 'MarkerSize', 12);
hold on;
av_sweep = linspace(0.8, 2);
%GBW_pow_avg = (sum(Av_data.*Bw_data./Pdc))/10;% - Av_data(3)*Bw_data(3)/Pdc(3))/4; % arithmetic mean of gain bandwidth product
%GBW = 5.8e4;
%plot(av_sweep, GBW_pow_avg./av_sweep/1e3, 'r-', 'Linewidth', 0.5);
%xlim([1.5 2]);
title("Power-normalized 3dB bandwidth vs. DC gain");
xlabel("P_{DC} [mW]");
ylabel("f_{3dB}A_{v,DC} [kHz]");
legend("measured data", "fit (assuming constant GBW/P)");
return;

figure;
GBW_pow = Av_data.*Bw_data./Pdc;
Vb_data = linspace(0, 8, 5);
Vb_sweep = linspace(0, 8, 100);
plot(Vb_data, GBW_pow./1e3, 'b.', 'Markersize', 12);
hold on;
P = polyfit(Vb_data, GBW_pow./1e3, 1);
GBW_pow_fit = P(1)*Vb_sweep+P(2);
plot(Vb_sweep, GBW_pow_fit, 'b-', 'Linewidth', 0.5)
xlabel("V_{b,load} [V]");
ylabel("A_{v,DC}\cdot f_{3dB}/P_{DC} [kHz/mW]");
title("Power-normalized gain-bandwidth-product vs. bias");
legend("measured data", strcat("linear best fit: ", num2str(P(1)), "V_b + ", num2str(P(2))));
ylim([40 60]);
