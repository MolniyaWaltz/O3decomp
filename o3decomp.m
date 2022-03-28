% This set of MATLAB scripts and classes is created by Thomas McIntosh as
% part of GDP Group 21's aims to create a decontamination chamber for the
% PlasmaSaber Mark 4. 

% Initial variable calculation
rho_AC = const.m_AC / const.V_AC;

runtime = 300;
[mo3, ppm, po3, litres_o3] = o3gen(runtime);
vm = const.A_AC_BET * const.m_AC * (const.R * const.T / po3) / (const.Na * const.A_o2);

% rate constants
k1 = 50 * mo3 / litres_o3;
k2 = 2.13 * mo3 / litres_o3; 

kd1 = 49.5E-3 * (mo3 / litres_o3) / const.M_o3;
kd2 = 0.86E3; % kd2 in s^-1
kd_tot = kd1 + kd2;

% diffusion coefficient calculations
DK = 9.7E-3 * const.r_pore * sqrt(const.T/48); % Knudsen diffusivity (Equation C3)
Dcomb = 1/(1/DK + 1/const.DM); % combined diffusivities (Equation C2)

porosity = 1 - const.rho_pore / rho_AC;
tortuosity = 1;
Deff = porosity * Dcomb / tortuosity;

[theta, v] = langmuir(po3, k1, kd_tot, vm, runtime);

runtime_array = [1:1:300];
[mo3_array, ppm_array, po3_array, litres_o3_array] = o3gen(runtime_array);
vm_array = const.A_AC_BET * const.m_AC * (const.R * const.T ./ po3_array) / (const.Na * const.A_o2);
[theta_array, v_array] = langmuir(po3_array, k1, kd_tot, vm_array, runtime_array);

figure(1); 
plot(runtime_array,theta_array);
plot(runtime_array,theta_array ./2);
title('Surface coverage \theta for CeraPlas runtime');
xlabel('Runtime (s)');
ylabel('Surface coverage \theta = v/v_m ');

% TODO multiple plots for decreasing rate constants