% This set of MATLAB scripts and classes is created by Thomas McIntosh as
% part of GDP Group 21's aims to create a decontamination chamber for the
% PlasmaSaber Mark 4. 

initialisation;

% ================================
%         BEGIN SCENARIO
% ================================
rateconsts = 3;
k1 = 3.9763 / 3600;
k1_array = linspace(k1/3,k1,rateconsts);

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

legend(strcat("k1 = ",num2str(k1_array(1)), " s^{-1}"), ...
    strcat("k1 = ",num2str(k1_array(2)), " s^{-1}"), ...
    strcat("k1 = ",num2str(k1_array(3)), " s^{-1}"),'Location','northwest');

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

figure(2); 

surf(active_sites_matrix,'LineStyle','none');
zlim([0 1]);

% TODO multiple plots for decreasing rate constants
% TODO vary proportion of filled sites destroyed based on organic chemical
% theory (formed carbonyl/carboxyl groups not reusable while nitrosamines
% are)