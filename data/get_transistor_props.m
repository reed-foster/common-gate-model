function [gm, ro, gmi, roi, id, vds, vgs] = get_transistor_props(fname, Vds_data, vgsCount, Rd, Rs)
    Vgs_data = readmatrix(fname,'Range',strcat('A2:A',num2str(vgsCount+1)))';
    Id_data = readmatrix(fname,'Range',strcat('C2:C',num2str(vgsCount*51+1)));
    Id_data = reshape(Id_data,[length(Vgs_data),length(Vds_data)]);
    Id_smooth = zeros(size(Id_data));
    for i=1:length(Vgs_data)
        Id_smooth(i,:) = smooth(Vds_data,Id_data(i,:),20,'sgolay',3);
    end
    gm = zeros(length(Vgs_data),length(Vds_data));
    ro = zeros(length(Vgs_data),length(Vds_data));
    for vgs_idx=1:length(Vgs_data)
        ro(vgs_idx,:) = gradient(Vds_data)./gradient(Id_smooth(vgs_idx,:));
    end
    for vds_idx=1:length(Vds_data)
        gm(:,vds_idx) = gradient(Id_smooth(:,vds_idx)')./gradient(Vgs_data);
    end
    gm(gm<0) = 0;
    ro(ro<0) = 0;
    roi = ro-(1+gm.*ro).*Rs-Rd;
    gmi = gm.*ro./roi;
    id = Id_smooth;
    vds = Vds_data;
    vgs = Vgs_data;
end