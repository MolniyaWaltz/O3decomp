% This set of MATLAB scripts and classes is created by Thomas McIntosh as
% part of GDP Group 21's aims to create a decontamination chamber for the
% PlasmaSaber Mark 4. 

% Initial variable calculation
thisCarbon = carbon(6, 7.25E-5); % g, m3
thisThermal = thermal(303.15);

runtime = 300;
[mo3, ppm, po3, litres_o3] = o3gen(runtime, thisThermal.temp);
vm = thisCarbon.spec_area_BET * thisCarbon.mass * (thermal.gas_const * thisThermal.temp / po3) / (thermal.avogadro * ozone.oxygen_cs_area);

% rate constants
k1 = 50 * mo3 / litres_o3;
k2 = 2.13 * mo3 / litres_o3; 

kd1 = 49.5E-3 * (mo3 / litres_o3) / const.M_o3;
kd2 = 0.86E3; % kd2 in s^-1
kd_tot = kd1 + kd2;

% diffusion coefficient calculations
DK = 9.7E-3 * thisCarbon.pore_radius * sqrt(thisThermal.temp/48); % Knudsen diffusivity (Equation C3)
Dcomb = 1/(1/DK + 1/const.DM); % combined diffusivities (Equation C2)

porosity = 1 - thisCarbon.pore_density / thisCarbon.density;
tortuosity = 1;
Deff = porosity * Dcomb / tortuosity;

% ================================
%         BEGIN SCENARIO
% ================================
rateconsts = 5;
k1_array = linspace(k1/rateconsts, k1, rateconsts);

figure(1); 
[theta, v] = langmuir(po3, k1, kd_tot, vm);
for i = 1:rateconsts
    runtime_array = [1:1:300];
    [mo3_array, ppm_array, po3_array, litres_o3_array] = o3gen(runtime_array, thisThermal.temp);
    vm_array = thisCarbon.spec_area_BET * thisCarbon.mass * (thermal.gas_const * thisThermal.temp ./ po3_array) / (thermal.avogadro * ozone.oxygen_cs_area);
    [theta_array, v_array] = langmuir(po3_array, k1_array(i), kd_tot, vm_array);
    figure(1); 
    plot(runtime_array,theta_array);
    hold on;
end
hold off;
title('Surface coverage \theta for CeraPlas runtime');
xlabel('Runtime (s)');
ylabel('Surface coverage \theta = v/v_m ');

% TODO multiple plots for decreasing rate constants