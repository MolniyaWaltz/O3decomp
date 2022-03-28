% Initial variable declaration

R = 8.314462;
T = 303.15;

eff_factor = 1;

m_AC = 6; % grams
V_AC = 7.25E-5; % m3
rho_AC = m_AC / V_AC;

k1 = 50E-3 * rho_AC;
k2 = 2.13E-3 * rho_AC; % k1, k2 constants from literature are in m^3/g.s

kd1 = 49.5E-6 * m_AC / (12 * V_AC); % kd1 in m^3/mol.s
kd2 = 0.86E3; % kd2 in s^-1

% diffusion coefficient calculations

r_pore = 2E-9; % micropore radius
rho_pore = 9E5; % 0.9 g/cm3 = 900,000 g/m3
Dlb = 5E-5;

DK = 9.7E-3 * r_pore * sqrt(T/48); % Knudsen diffusivity (Equation C3)
DM = 1.3E-5; % 0.13 cm^2/s from Massman (1998)
Dcomb = 1/(1/DK + 1/DM); % combined diffusivities (Equation C2)

porosity = 1 - rho_pore / rho_AC;
tortuosity = 1;
Deff = porosity * Dcomb / tortuosity;

% scripts to call

[mo3, ppm, po3] = partialpressure(300);
% [theta, vm, v] = langmuir(po3, equilconst);