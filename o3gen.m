function [moles_o3, ppm, po3, conc_o3] = o3gen(time, temp)
    m_air = (0.2*0.2*0.25 - 0.1*0.1*0.1) * 1.225 * 1000;

    GR = (80E-3) / 3600; % Max rate in g/s, see CeraPlas manual
    GR = GR / 6; % Scale factor to reflect experimental results

    moles_o3 = GR * time / ozone.molar_mass;
    m_air = (0.2*0.2*0.25 - 0.1*0.1*0.1) * 1.225 * 1000;
    % Air mass from m = rho (V - V of cubesat)
    fraction = moles_o3 / (m_air / 28.97);
    ppm = 1E6 * fraction;
    % Denominator should be no. of moles of air + no. of moles of ozone,
    % this is a simplification since no. of moles of air >>> no. of moles
    % of ozone.
    po3 = (ppm / 1E6) * 1.225 * 287 * temp; % Dalton's Law
    conc_o3 = fraction .* (1225 / 28.97);
end