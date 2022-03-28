% This set of MATLAB scripts and classes is created by Thomas McIntosh as
% part of GDP Group 21's aims to create a decontamination chamber for the
% PlasmaSaber Mark 4. 

% Initial variable calculation
rho_AC = const.m_AC / const.V_AC;

[mo3, ppm, po3, litres_o3] = o3gen(runtime);

k1 = 50 * mo3 / litres_o3;
k2 = 2.13 * mo3 / litres_o3; % k1, k2 const from literature are in m^3/g.s

kd1 = 49.5E-3 * (mo3 / litres_o3) / const.M_o3; % kd1 in m^3/mol.s
kd2 = 0.86E3 % kd2 in s^-1

% diffusion coefficient calculations
DK = 9.7E-3 * const.r_pore * sqrt(const.T/48); % Knudsen diffusivity (Equation C3)
Dcomb = 1/(1/DK + 1/const.DM); % combined diffusivities (Equation C2)

porosity = 1 - const.rho_pore / rho_AC;
tortuosity = 1;
Deff = porosity * Dcomb / tortuosity;

% scripts to call
runtime = 300;
[theta, vm, v] = langmuir(po3, k1, kd1, runtime);