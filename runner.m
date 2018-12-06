
clear all

%% Preliminary analysis - rewriting of the system on the M-Delta form
[A,B,C,D] = linmod('BFnominale');
syst1 = ss(A,B,C,D);
R_old=pole(syst1);

[A,B,C,D] = linmod('BFnew');
syst2 = ss(A,B,C,D);
R_new=pole(syst2);

%% Unstructured analysis of SatBFrob2
[A,B,C,D] = linmod('satBFrob2_v2017');
sys = ss(A,B,C,D);                      % Importing M block
SC = diag([0.3 0.3 0.5 0.5 0.2 0.2]);   % Parameter variation margins
syscal = SC^0.5*sys*SC^0.5;             % M link with parameter variation block
blkc=[1 0; 1 0; 2 0; 1 0; 1 0];         % Complex uncertainties
blkr=[1 0;-1 0;-2 0;-1 0;-1 0];         % Real uncertainties

% ----- Unstructured analysis -----
n_sys = norm(sys,'inf');                 % Hinf norm of the nominal system
% tf_sys = ss2tf(sys)
n_calsys = norm(syscal,'inf');           % Hinf norm of the perturbed system
omeg = [0:0.001:5];

% Analysis of the singular values of calibrated system
sigv = sigma(syscal,omeg);
figure(1); clf;
plot(omeg,sigv);
title('Plot of singular values under parameter variations')
xlabel('frequency (rad/s)')
ylabel('singular values')
grid;

% Analysis of the singular values of nominal system 
sigv = sigma(sys,omeg);
figure(2); clf;
plot(omeg,sigv);
title('Plot of singular values under parameter variations')
xlabel('frequency (rad/s)')
ylabel('singular values')
grid;

%% Structured analysis

% ----- Case 1 : All uncertainties are complex

% Upper bound calculations
[upbndc, wcuc, tabc, pbc] = muub_mixed(syscal,blkc);
if pbc ~= 0
    disp("Problem on mixed mu analysis = "+str(pbc))
else
    disp("Mu analysis done - upper bound!")
    plot_muub(tabc);
end


% Lower bound calculations
[lbndc,wclc,pert]=mulb(syscal, blkc);
disp("Mu analysis done - lower bound!")
plot(wclc+j*lbndc,'b*','MarkerSize',15);
grid;
title("Mu upper and lower bounds for complex-only uncertainties")
xlabel("frequency (rad/s)")
ylabel("mu-bound values")



% Case 2 : The uncertainties are mixed - complex and real

% Upper bound calculations
[upbndr, wcur, tabr, pbc] = muub_mixed(syscal,blkr);
if pbc ~= 0
    disp("Problem on mixed mu analysis = "+str(pbc))
else
    disp("Mu analysis done - upper bound!")
    plot_muub(tabr);
end


% Lower bound calculations
[lbndr,wclr,pert]=mulb(syscal, blkr);
disp("Mu analysis done - lower bound!")
plot(wclr+j*lbndr,'b*','MarkerSize',15);
grid;
title("Mu upper and lower bounds for mixed uncertainties")
xlabel("frequency (rad/s)")
ylabel("mu-bound values")




% Unceirtain parameters
% Da = ucomplex('Delta_a', 0, 'Radius', 0.3);
% d_omega = ureal('del_omega', 1, 'PlusMinus', 0.5);
% d_xi = ureal('del_xi', 1, 'PlusMinus', 0.2);
% d_tau = ureal('del_tau', 1, 'PlusMinus', 0.2);



