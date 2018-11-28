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
%% Unstructured analysis of SatBFrob2
[A,B,C,D] = linmod('satBFrob2');
sys = ss(A,B,C,D);                  % Importing M block
SC = diag([0.3 0.3 0.5 0.5 0.2 0.2]); % Parameter variation margins
syscal = SC^0.5*sys*SC^0.5;            % M link with parameter variation block
blkc=[1 0; 1 0; 2 0; 1 0; 1 0];     % Complex uncertainties
blkr=[1 0;-1 0;-2 0;-1 0;-1 0];     % Real uncertainties
% ----- Unstructured analysis -----
norm(sys,'inf')
omeg = [0:0.001:5];
sigv = sigma(syscal,omeg);
figure(1); clf;
plot(omeg,sigv);
title('Plot of singular values under parameter variations')
xlabel('frequency (rad/s)')
ylabel('singular values')
grid;








% Unceirtain parameters
% Da = ucomplex('Delta_a', 0, 'Radius', 0.3);
% d_omega = ureal('del_omega', 1, 'PlusMinus', 0.5);
% d_xi = ureal('del_xi', 1, 'PlusMinus', 0.2);
% d_tau = ureal('del_tau', 1, 'PlusMinus', 0.2);



