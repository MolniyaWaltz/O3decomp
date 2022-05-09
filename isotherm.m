function [theta_array,v_array,vm_array] = isotherm(runtime, kad, kdes, temp, carbon_S_BET, carbon_mass)
    runtime_array = 1:1:runtime;
    [~, ~, po3_array, ~] = o3gen(runtime_array, temp);
    [theta_array, v_array, vm_array] = langmuir(po3_array, kad, kdes, temp, carbon_S_BET, carbon_mass);
end

