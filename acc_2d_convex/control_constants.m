function con = control_constants()
% Horizon
con.N = 1;
con.v_weight = 2;
con.h_weight = 2;
con.u_weight = 1;
con.u_weight_jerk = 1;

con.ramp_delta = 20;
con.ramp_lim = 10;		% 

end