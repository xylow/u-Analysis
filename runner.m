clear all
mdl = 'BFnominale';
open_system(mdl);
[A,B,C,D] = linmod('BFnominale');
syst1 = ss(A,B,C,D);
R_old=pole(syst1);
mdl2 = 'BFnew';
open_system(mdl2);
[A,B,C,D] = linmod('BFnew');
syst2 = ss(A,B,C,D);
R_new=pole(syst2);
% Unceirtain parameters
% Da = ucomplex('Delta_a', 0, 'Radius', 0.3);
% d_omega = ureal('del_omega', 1, 'PlusMinus', 0.5);
% d_xi = ureal('del_xi', 1, 'PlusMinus', 0.2);
% d_tau = ureal('del_tau', 1, 'PlusMinus', 0.2);



