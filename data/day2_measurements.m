close all;
% common drain (looks like shit lol)
figure;
f = [100 150 200 300 500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3];
freq = logspace(2,6,100);
vin = 200;
% Vin,DC = -8
% Vb = -7
vout = [172 175 175 175 175 170 168 163 160 139 118 89 83 65];
loglog(f, vout./vin, 'b.', 'MarkerSize', 12);
hold on;
loglog(freq, 175./200.*sqrt(1./(1+(freq./5e3).^2)), 'b-');
hold on;
% Vin,DC = -8
% Vb = -6
vout = [166 166 166 166 166 164 162 155 151 140 125 93.6 82.8 61.2];
loglog(f, vout./vin, 'r.', 'MarkerSize', 12);
hold on;
loglog(freq, 166./200.*sqrt(1./(1+(freq./5.5e3).^2)), 'r-');
% % Vin,DC = -7
% % Vb = -6
% vout = [204 204 204 200 204 200 200 200 196 184 163 140 120 98];
% loglog(f, vout./vin, 'g.', 'MarkerSize', 12);
% hold on;
% loglog(freq, 204./200.*sqrt(1./(1+(freq./7e3).^2)), 'g-');
% % Vin,DC = -7
% % Vb = -7
% vout = [204 204 204 204 204 204 204 192 192 180 155 131 114 90];
% loglog(f, vout./vin, 'm.', 'MarkerSize', 12);
% hold on;
% loglog(freq, 204./200.*sqrt(1./(1+(freq./6.5e3).^2)), 'm-');
% Vin,DC = -9
% Vb = -9
vout = [161 161 161 161 158 154 151 142 129 110 80 55.2 46 32];
loglog(f, vout./vin, 'c.', 'MarkerSize', 12);
hold on;
loglog(freq, 161./200.*sqrt(1./(1+(freq./3e3).^2)), 'c-');
% Vin,DC = -9.8
% Vb = -9
vout = [152 152 152 152 150 144 140 130 120 100 69 47 39 25];
loglog(f, vout./vin, 'k.', 'MarkerSize', 12);
hold on;
loglog(freq, 152./200.*sqrt(1./(1+(freq./2.5e3).^2)), 'k-');
% Vin,DC = -4
% Vb = -2
vout = [147 147 147 142 142 139 139 139 139 139 131 122 106 90];
loglog(f, vout./vin, 'g.', 'MarkerSize', 12);
hold on;
loglog(freq, 147./200.*sqrt(1./(1+(freq./12e3).^2)), 'g-');
% Vin,DC = -6
% Vb = -1
f = [100 150 200 300 500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3];
vout = [196 196 188 188 180 180 180 180 180 180 180 163 155 114 98 90];
loglog(f, vout./vin, 'm.', 'MarkerSize', 12);
hold on;
loglog(freq, 190./200.*sqrt(1./(1+(freq./13e3).^2)), 'm-');
xlim([1e2 30e3]);
title("Common Drain Frequency Response");
ylabel("V_{out}/V_{in}");
xlabel("freq [Hz]");

% common gate
figure;
% Vb1 = -8
% Vb2 = -4
% Vin,DC = 0
% Vdd = 6
% Vout,DC = 0.8
f = [100 150 200 300 500 800 1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3];
vout = [178 180 180 178 176 176 176 174 172 170 166 154 144 122 104 78 52 36];
loglog(f, vout./vin, 'r.', 'MarkerSize', 12);
hold on;
loglog(freq, 180./200.*sqrt(1./(1+(freq./14e3).^2)), 'r-');
% Vb1 = -7
% Vb2 = -3
% Vin,DC = 0
% Vdd = 6
% Vout,DC = 0.758
f = [1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3];
vout = [178 178 174 174 172 166 158 142 126 98 66 44 37 26 20 13];
loglog(f, vout./vin, 'g.', 'MarkerSize', 12);
hold on;
loglog(freq, 178./200.*sqrt(1./(1+(freq./20e3).^2)), 'g-');
xlim([1e2 300e3]);
% Vb1 = -6
% Vb2 = -2
% Vin,DC = 0
% Vdd = 6
% Vout,DC = 0.716
vout = [180 180 178 180 178 172 170 158 142 120 83 56 46 33 25 17];
loglog(f, vout./vin, 'b.', 'MarkerSize', 12);
hold on;
loglog(freq, 180./200.*sqrt(1./(1+(freq./26e3).^2)), 'b-');
xlim([1e2 300e3]);
% Vb1 = -5
% Vb2 = -1
% Vin,DC = 0
% Vdd = 6
% Vout,DC = 0.68
vout = [178 178 182 180 180 174 172 164 151 131 97 68 57 40 32 22];
loglog(f, vout./vin, 'c.', 'MarkerSize', 12);
hold on;
loglog(freq, 180./200.*sqrt(1./(1+(freq./31e3).^2)), 'c-');
xlim([1e2 300e3]);
% Vb1 = -4
% Vb2 = 0
% Vin,DC = 0
% Vdd = 6
% Vout,DC = 0.66
f = [1e3 1.5e3 2e3 3e3 5e3 8e3 10e3 15e3 20e3 30e3 50e3 80e3 100e3 150e3 200e3 300e3 500e3];
vout = [180 180 182 182 180 176 176 168 162 144 110 80 66 47 37 26 10];
loglog(f, vout./vin, 'm.', 'MarkerSize', 12);
hold on;
loglog(freq, 180./200.*sqrt(1./(1+(freq./38e3).^2)), 'm-');
xlim([5e2 300e3]);
title("Common Gate Frequency Response");
ylabel("V_{out}/V_{in}");
xlabel("freq [Hz]");

