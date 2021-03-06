%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate C code %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('constants.mat');
load('poly.mat')
load('dyn_data.mat');

codegen -c -d 'matlab_c' -config:lib qp_vars -args {zeros(n,1)} 

num_poly_hp_max = max(bigPolyLen);
% num_poly_hp_max = 0;
% for i=1:length(control_chain)
%     num_poly_hp_max = max(num_poly_hp_max, size(control_chain(i).A,1));
% end

num_xu_hp = size(XUA,1);
if p>0
	max_num_ineq = con.N*(num_xu_hp+2*num_poly_hp_max);
else
	max_num_ineq = con.N*(num_xu_hp+num_poly_hp_max);
end

fid = fopen('./matlab_c/definitions.h','wt');
fprintf(fid,'%s', '#define V_LIN ');
fprintf(fid,'%f\n', con.v_linearize);
fprintf(fid,'%s', '#define CAR_MASS ');
fprintf(fid,'%f\n', con.mass);
fprintf(fid,'%s', '#define CAR_F0 ');
fprintf(fid,'%f\n', con.f0);
fprintf(fid,'%s', '#define CAR_F1 ');
fprintf(fid,'%f\n', con.f1);
fprintf(fid,'%s', '#define CAR_F2 ');
fprintf(fid,'%f\n', con.f2);
fprintf(fid,'%s', '#define U_SCALE ');
fprintf(fid,'%f\n', u_scale);


fprintf(fid,'%s', '#define QP_N ');
fprintf(fid,'%d\n', con.N);
fprintf(fid,'%s', '#define QP_XDIM ');
fprintf(fid,'%d\n', n);
fprintf(fid,'%s', '#define QP_UDIM ');
fprintf(fid,'%d\n', m);
fprintf(fid,'%s', '#define QP_MAX_INEQ ');
fprintf(fid,'%d\n', max_num_ineq);

fclose(fid);