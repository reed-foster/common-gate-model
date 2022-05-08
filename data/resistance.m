close all;
squares = [0.02 0.05 0.15 0.2 0.4];
contact_area = 90*10e-12; % m^2
I_1V = [140e-6 111e-6 62.5e-6 50e-6 27e-6];
P = polyfit(squares, 1./I_1V, 1);
sq_fit = linspace(0, 0.5);
rfit = P(1).*sq_fit+P(2);
f = figure;
plot(squares,1./I_1V/1e3,'r.','MarkerSize',12);
hold on;
plot(sq_fit,rfit/1e3,'r-');
ylim([0 50]);
xlim([0 0.5]);
xlabel("# Squares (L/W)");
ylabel("Resistance [k\Omega]");
title("IGZO Contact and Sheet Resistance");
legend("measurement", "fit");
a = annotation('textarrow',[0 0],[0 0],'String','  R_{c} \approx 2.4k\Omega,   \rho_{C} \approx 0.022\Omega\cdotcm^2');
a.Parent = f.CurrentAxes;
%a.Position = [0.15 5 0.2 5];
a.X = [0.15 0];
a.Y = [5 5];
a.HeadStyle = 'none';
l1 = annotation('line',[0 0], [0 0]);
l1.Parent = f.CurrentAxes;
l1.X = [0.17 0.27];
l1.Y = (P(1)*0.17+P(2))/1e3*ones(1,2);
l2 = annotation('line',[0 0], [0 0]);
l2.Parent = f.CurrentAxes;
l2.X = [0.27 0.27];
l2.Y = [P(1)*0.17+P(2) P(1)*0.27+P(2)]./1e3;
t = text(0.2, 15,'R_☐ \approx 79k\Omega, \rho \approx 0.0632\Omega\cdotcm');
rho_C = (P(2)/2)*contact_area; % ohm*m^2