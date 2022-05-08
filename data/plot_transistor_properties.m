close all;
plot_heatmaps = false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% W/L = 30um / 5um
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Lacc = 5;
Rsq = 78.98e3; % Ohm/sq
Rcontact = 2.2e6; % Ohm*um^2
% sheet and contact resistances
Rs = Lacc/80*Rsq + Rcontact/(10*70);
Rd = Lacc/80*Rsq + Rcontact/(10*70);
[gm, ro, gmi, roi, Id_data, Vds_data, Vgs_data] = get_transistor_props('0502_DC_IV/30_5_IV.csv', linspace(0,10,51), 111, Rd, Rs);
[gm_old, ro_old, gmi_old, roi_old, Id_data_old, Vds_data_old, Vgs_data_old] = get_transistor_props('8nmIGZO_30nmAlOx_30_5_transfer.csv', linspace(0,5,26), 51, Rd, Rs);
[vd,vg] = meshgrid(Vds_data, Vgs_data);
figure(1);
vgs_sweep = 31:10:length(Vgs_data)-40;
num_series = length(vgs_sweep);
cm = turbo(num_series*10);
ci = 1;
output_legend_data = repmat({''},1,int32(num_series));
for vgs_idx=vgs_sweep
    plot(Vds_data, 1e6*Id_data(vgs_idx,:)/30, '-', 'Linewidth', 2, 'Color', cm(ci*10,:,:));
    hold on;
    output_legend_data{ci} = strcat("V_{GS} = ", num2str(Vgs_data(vgs_idx)), "V");
    ci = ci + 1;
end
figure(2);
vds_sweep = 11:10:length(Vds_data);
num_series = length(vds_sweep);
cm = turbo(num_series*10);
ci = 1;
transfer_legend_data = repmat({''},1,int32(2*num_series));
for vds_idx=vds_sweep
    colororder({'k','k'})
    yyaxis left;
    semilogy(Vgs_data, abs(Id_data(:,vds_idx))/30, '-', 'Linewidth', 2, 'Color', cm(ci*10,:,:));
    hold on;
    yyaxis right;
    plot(Vgs_data, 1e6*Id_data(:,vds_idx)/30, '--', 'Linewidth', 2, 'Color', cm(ci*10,:,:));
    hold on;
    transfer_legend_data{ci} = strcat("V_{DS} = ", num2str(Vds_data(vds_idx)), "V");
    ci = ci + 1;
end
figure(3);
vds_sweep = 6:5:length(Vds_data_old);
num_series = length(vds_sweep);
cm = turbo(num_series*10);
ci = 1;
comparison_transfer_legend_data = repmat({''},1,int32(2*num_series));
for vds_idx=vds_sweep
    semilogy(Vgs_data_old, abs(Id_data_old(:,vds_idx))/30, '--', 'Linewidth', 2, 'Color', cm(ci*10,:,:));
    hold on;
    comparison_transfer_legend_data{ci} = strcat("V_{DS} = ", num2str(Vds_data_old(vds_idx)), "V (04/11)");
    ci = ci + 1;
end
for vds_idx=vds_sweep
    semilogy(Vgs_data, abs(Id_data(:,vds_idx))/30, '-', 'Linewidth', 2, 'Color', cm((ci-num_series)*10,:,:));
    hold on;
    comparison_transfer_legend_data{ci} = strcat("V_{DS} = ", num2str(Vds_data(vds_idx)), "V (05/02)");
    ci = ci + 1;
end
figure(1);
title("30um/5um Output Characteristics");
ylabel("J_D [\muA/\mum]");
xlabel("V_{DS} [V]");
legend(output_legend_data, "Location", 'northwest');
ylim([0 6]);
figure(2);
title("30um/5um Transfer Characteristics");
yyaxis left;
ylabel("J_D [A/\mum]");
ylim([1e-11 1e-4]);
yyaxis right;
ylabel("J_D [\muA/\mum]");
ylim([0 6]);
xlabel("V_{GS} [V]");
xlim([-14 0]);
legend(transfer_legend_data,"Location",'northwest');
figure(3);
title("30um/5um V_T Degradation");
ylabel("J_D [A/\mum]");
ylim([1e-11 1e-4]);
xlabel("V_{GS} [V]");
xlim([-14 -7]);
legend(comparison_transfer_legend_data,"Location",'northwest','NumColumns',2);
if plot_heatmaps
    figure(4);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(0,3,4)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(gm.*ro)), log10(contours),'Linecolor','none');
    hold on;
    contour(vd, vg, log10(abs(gm.*ro)), [0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([1 1000]));
    title("30um/5um Extrinsic Gain g_mr_o");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    figure(5);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(1,9,9) linspace(10,90,9) 100];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(0,2,3)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(gmi.*roi)), log10(contours),'Linecolor','none');
    hold on;
    contour(vd, vg, log10(abs(gmi.*roi)), [0 1 2], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([1 100]));
    title("30um/5um Intrinsic Gain g_{mi}r_{oi}");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    xlim([1 10]);
    ylim([-12 0]);
    figure(6);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(0.001,0.009,9) linspace(0.01,0.09,9) linspace(0.1,0.9,9) linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(-3,3,7)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(roi.*(30/1e9))), log10(contours),'Linecolor','none');
    hold on;
    contour(vd, vg, log10(abs(roi.*(30/1e9))), [-3 -2 -1 0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([0.001 1e3]))
    title("30um/5um Intrinsic Output Resistance r_{oi}\cdotW [G\Omega\cdot\mum]");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    figure(7);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(0.1,0.9,9) linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(-1,3,5)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(gmi.*(1e9/30))), log10(contours),'Linecolor','none');
    hold on;
    contour(vd, vg, log10(abs(gmi.*(1e9/30))), [-1 0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([0.1 1e3]))
    title("30um/5um Intrinsic Transconductance g_{mi}/W [nA/V/\mum]");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    figure(8);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(0.001,0.009,9) linspace(0.01,0.09,9) linspace(0.1,0.9,9) linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(-3,3,7)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(ro.*(30/1e9))), log10(contours),'Linecolor','none');
    hold on;
    contour(vd, vg, log10(abs(ro.*(30/1e9))), [-3 -2 -1 0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([0.001 1e3]))
    title("30um/5um Extrinsic Output Resistance r_{o}\cdotW [G\Omega\cdot\mum]");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    figure(9);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(0.1,0.9,9) linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(-1,3,5)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(gm.*(1e9/30))), log10(contours),'Linecolor','none');
    hold on;
    contour(vd, vg, log10(abs(gm.*(1e9/30))), [-1 0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([0.1 1e3]))
    title("30um/5um Extrinsic Transconductance g_{m}/W [nA/V/\mum]");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% W/L = 80um / 5um
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rs = Lacc/30*Rsq + Rcontact/(10*70);
Rd = Lacc/30*Rsq + Rcontact/(10*20);
[gm, ro, gmi, roi, Id_data, Vds_data, Vgs_data] = get_transistor_props('0502_DC_IV/80_5_IV.csv', linspace(0,10,51), 71, Rd, Rs);
[gm_old, ro_old, gmi_old, roi_old, Id_data_old, Vds_data_old, Vgs_data_old] = get_transistor_props('8nmIGZO_30nmAlOx_80_5_transfer.csv', linspace(0,5,26), 51, Rd, Rs);
[vd,vg] = meshgrid(Vds_data, Vgs_data);
figure(11);
vgs_sweep = 31:10:length(Vgs_data);
num_series = length(vgs_sweep);
cm = turbo(num_series*10);
ci = 1;
output_legend_data = repmat({''},1,int32(num_series));
for vgs_idx=vgs_sweep
    plot(Vds_data, 1e6*Id_data(vgs_idx,:)/80, '-', 'Linewidth', 2, 'Color', cm(ci*10,:,:));
    hold on;
    output_legend_data{ci} = strcat("V_{GS} = ", num2str(Vgs_data(vgs_idx)), "V");
    ci = ci + 1;
end
figure(12);
vds_sweep = 11:10:length(Vds_data);
num_series = length(vds_sweep);
cm = turbo(num_series*10);
ci = 1;
transfer_legend_data = repmat({''},1,int32(2*num_series));
for vds_idx=vds_sweep
    colororder({'k','k'});
    yyaxis left;
    semilogy(Vgs_data, abs(Id_data(:,vds_idx))/80, '-', 'Linewidth', 2, 'Color', cm(ci*10,:,:));
    hold on;
    yyaxis right;
    plot(Vgs_data, 1e6*Id_data(:,vds_idx)/80, '--', 'Linewidth', 2, 'Color', cm(ci*10,:,:));
    hold on;
    transfer_legend_data{ci} = strcat("V_{DS} = ", num2str(Vds_data(vds_idx)), "V");
    ci = ci + 1;
end
figure(13);
vds_sweep = 6:5:length(Vds_data_old);
num_series = length(vds_sweep);
cm = turbo(num_series*10);
ci = 1;
comparison_transfer_legend_data = repmat({''},1,int32(2*num_series));
for vds_idx=vds_sweep
    semilogy(Vgs_data_old, abs(Id_data_old(:,vds_idx))/80, '--', 'Linewidth', 2, 'Color', cm(ci*10,:,:));
    hold on;
    comparison_transfer_legend_data{ci} = strcat("V_{DS} = ", num2str(Vds_data_old(vds_idx)), "V (04/11)");
    ci = ci + 1;
end
for vds_idx=vds_sweep
    semilogy(Vgs_data, abs(Id_data(:,vds_idx))/80, '-', 'Linewidth', 2, 'Color', cm((ci-num_series)*10,:,:));
    hold on;
    comparison_transfer_legend_data{ci} = strcat("V_{DS} = ", num2str(Vds_data(vds_idx)), "V (05/02)");
    ci = ci + 1;
end
figure(11);
title("80um/5um Output Characteristics");
ylabel("J_D [\muA/\mum]");
xlabel("V_{DS} [V]");
legend(output_legend_data, "Location", 'northwest');
ylim([0 6]);
figure(12);
title("80um/5um Transfer Characteristics");
yyaxis left;
ylabel("J_D [A/\mum]");
ylim([1e-11 1e-4]);
yyaxis right;
ylabel("J_D [\muA/\mum]");
ylim([0 6]);
xlabel("V_{GS} [V]");
xlim([-14 0]);
legend(transfer_legend_data, "Location", 'northwest');
figure(13);
title("80um/5um V_T Degradation");
ylabel("J_D [A/\mum]");
ylim([1e-11 1e-4]);
xlabel("V_{GS} [V]");
xlim([-14 -7]);
legend(comparison_transfer_legend_data,"Location",'northwest','NumColumns',2);
if plot_heatmaps
    figure(14);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1000];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(0,3,4)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(gm.*ro)), log10(contours), 'Linecolor', 'none');
    hold on;
    contour(vd, vg, log10(abs(gm.*ro)), [0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([1 1000]));
    title("80um/5um Extrinsic Gain g_mr_o");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    figure(15);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(1,9,9) linspace(10,90,9) 100];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(0,2,3)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(gmi.*roi)), log10(contours), 'Linecolor', 'none');
    hold on;
    contour(vd, vg, log10(abs(gmi.*roi)), [0 1 2], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([1 100]));
    title("80um/5um Intrinsic Gain g_{mi}r_{oi}");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    xlim([1 10]);
    ylim([-12 0]);
    figure(16);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(0.001,0.009,9) linspace(0.01,0.09,9) linspace(0.1,0.9,9) linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(-3,3,7)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(roi.*(80/1e9))), log10(contours), 'Linecolor', 'none');
    hold on;
    contour(vd, vg, log10(abs(roi.*(80/1e9))), [-3 -2 -1 0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([0.001 1e3]))
    title("80um/5um Intrinsic Output Resistance r_{oi}\cdotW [G\Omega\cdot\mum]");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    figure(17);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(0.1,0.9,9) linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(-1,3,5)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(gmi*(1e9/80))), log10(contours),'Linecolor','none');
    hold on;
    contour(vd, vg, log10(abs(gmi*(1e9/80))), [-1 0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([0.1 1e3]))
    title("80um/5um Intrinsic Transconductance g_{mi}/W [nA/V/\mum]");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    figure(18);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(0.001,0.009,9) linspace(0.01,0.09,9) linspace(0.1,0.9,9) linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(-3,3,7)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(ro.*(80/1e9))), log10(contours), 'Linecolor', 'none');
    hold on;
    contour(vd, vg, log10(abs(ro.*(80/1e9))), [-3 -2 -1 0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([0.001 1e3]))
    title("80um/5um Extrinsic Output Resistance r_{o}\cdotW [G\Omega\cdot\mum]");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
    figure(19);
    contours = logspace(-8, 4, 130);
    contour_ticks = [linspace(0.1,0.9,9) linspace(1,9,9) linspace(10,90,9) linspace(100,900,9) 1e3];
    contour_tick_labels = repmat({''}, 1, length(contour_ticks));
    c = 1;
    for i=logspace(-1,3,5)
        contour_tick_labels{c} = num2str(i);
        c = c + 9;
    end
    contourf(vd, vg, log10(abs(gm*(1e9/80))), log10(contours),'Linecolor','none');
    hold on;
    contour(vd, vg, log10(abs(gm*(1e9/80))), [-1 0 1 2 3], 'Linecolor', 'k', 'Linewidth', 2);
    colorbar('YTick',log10(contour_ticks),'YTickLabel',contour_tick_labels);
    colormap('jet');
    caxis(log10([0.1 1e3]))
    title("80um/5um Extrinsic Transconductance g_{m}/W [nA/V/\mum]");
    xlabel("V_{DS} [V]");
    ylabel("V_{GS} [V]");
end