close all
fname = "0425_DC_gain/full_data.csv";
for i=1:5
    offset = (i-1)*201;
    vdd = 8;
    vbias = (5-i)*2;
    vin_data = readmatrix(fname,'Range',strcat('A',num2str(2+offset),':A',num2str(202+offset)));
    iin_data = readmatrix(fname,'Range',strcat('C',num2str(2+offset),':C',num2str(202+offset)));
    vout_data = readmatrix(fname,'Range',strcat('D',num2str(2+offset),':D',num2str(202+offset)));
    av_data = readmatrix(fname,'Range',strcat('E',num2str(2+offset),':E',num2str(202+offset)));
    figure(i);
    yyaxis left;
    plot(vin_data, vout_data, 'LineWidth', 2);
    ylabel("V_{out} [V]");
    ylim([-5 5]);
    yyaxis right;
    plot(vin_data, smoothdata(av_data,'gaussian',30), 'LineWidth', 2);
    hold on;
    plot(vin_data, av_data, 'LineWidth',0.5);
    ylim([1.2 2.2]);
    ylabel("dV_{out}/dV_{in}");
    title(strcat("DC gain (V_{b1} = -12V, V_{b2} = ", num2str(vbias), "V)"));
    xlabel("V_{in} [V]");
    figure(6);
    plot(vin_data,-1e3*iin_data.*(vdd-vin_data),'LineWidth',2);
    hold on;
end
figure(6);
ylim([0 3]);
xlabel("V_{in} [V]");
ylabel("P_{DC} [mW]");
title("DC power consumption (V_{b1} = -12V)");
legend("V_{b2} = 8V","V_{b2} = 6V","V_{b2} = 4V","V_{b2} = 2V","V_{b2} = 0V");

figure(7);
vin_data = readmatrix('0425_DC_gain/long_sweep.csv','Range','A4:A204');
vout_data = readmatrix('0425_DC_gain/long_sweep.csv','Range','B4:B204');
plot(vin_data,vout_data, 'LineWidth', 2);
xlabel("V_{in} [V]");
ylabel("V_{out} [V]");
title("Common gate large signal transfer curve");