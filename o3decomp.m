% This set of MATLAB scripts and classes is created by Thomas McIntosh as
% part of GDP Group 21's aims to create a decontamination chamber for the
% PlasmaSaber Mark 4. 

% Initial variable calculation
thisCarbon = carbon(6, 7.25E-5); % g, m3
thisThermal = thermal(303.15);

runtime = 300;
runtimes = 1:1:runtime;
[mo3, ppm, po3, litres_o3] = o3gen(runtime, thisThermal.temp);

% rate constants
k1 = 50 * mo3 / litres_o3;
k2 = 2.13 * mo3 / litres_o3; 

kd1 = 49.5E-3 * (mo3 / litres_o3) / ozone.molar_mass;
kd2 = 0.86E3; % kd2 in s^-1
kd_tot = kd1 + kd2;

% diffusion coefficient calculations
DK = 9.7E-3 * thisCarbon.pore_radius * sqrt(thisThermal.temp/48); % Knudsen diffusivity (Equation C3)
Dcomb = 1/(1/DK + 1/ozone.molecular_diffusivity); % combined diffusivities (Equation C2)

porosity = 1 - thisCarbon.pore_density / thisCarbon.density;
tortuosity = 1;
Deff = porosity * Dcomb / tortuosity;

% ================================
%         BEGIN SCENARIO
% ================================
rateconsts = 6;
k1_array = linspace(k1/rateconsts, k1, rateconsts);

figure(1); 
[theta, v, vm] =  langmuir(po3, k1, kd_tot, thisThermal.temp, thisCarbon.S_BET, thisCarbon.mass)
for i = 1:rateconsts
    [theta_array, v_array, vm_array] = isotherm(runtime, k1_array(i), kd_tot, thisThermal.temp, thisCarbon.S_BET, thisCarbon.mass);
    plot(runtimes,theta_array);
    hold on;
end

hold off;
xlabel('Runtime (s)');
ylabel('Surface coverage \theta = v/v_m ');

% This code predicts longetivity of activated carbon by determining
% percentage of available active sites assuming ozone species adsorbs to
% equilibrium point and desorbs, with 100% of filled sites being destroyed
% after desorption

runs = 20;
active_sites = zeros(1, length(runtimes));
active_sites_matrix = zeros(runs, length(runtimes));

prev_active_sites = ones(1, length(runtimes));

for i = 1:runs
    [theta_array,v_array,vm_array] = isotherm(runtime, k1, kd_tot, thisThermal.temp, thisCarbon.S_BET, thisCarbon.mass);
    
    last_theta_array = theta_array;
    for j = 1:length(runtimes)
        active_sites(j) = (1 - theta_array(j)) * prev_active_sites(j);
        active_sites_matrix(i, j) = active_sites(j);
    end
    prev_active_sites = active_sites;
end

% TODO multiple plots for decreasing rate constants
% TODO vary proportion of filled sites destroyed based on organic chemical
% theory (formed carbonyl/carboxyl groups not reusable while nitrosamines
% are)