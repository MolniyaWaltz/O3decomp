function [mo3, ppm, po3, litres_o3] = o3gen(time)
    GR = (80E-3) / 3600 % Max rate in g/s, see CeraPlas manual
    mo3 = GR * time;
    m = (0.2*0.2*0.25 - 0.1*0.1*0.1) * 1.225 * 1000; % Air mass from m = rho (V - V of cubesat)
    ppm = 1E6 * (mo3 / const.M_o3) / (m / 28.97); 
    po3 = (ppm / 1E6) * 1E5; % Dalton's Law
    litres_o3 = (mo3 / const.M_o3) * const.R * const.T / po3; % Ideal gas law
end