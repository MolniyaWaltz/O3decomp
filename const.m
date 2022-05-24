classdef const
    %CONSTANTS Summary of this class goes here
    %   Detailed explanation goes here
    % TODO Add explanation 
    
    properties (Constant)
        eff_factor = 1
        
        % Thermal variables
        R = 8.314462
        T = 303.15
        Na = 6.022E23
        % AC properties
        m_AC = 6
        V_AC = 7.25E-5
        r_pore = 2E-9 % micropore radius
        rho_pore = 9E5 % 0.9 g/cm3
        A_AC_BET = 1500 

        % Ozone and oxygen properties
        A_o2 = 1E-19 % 10 angstroms^2 (Deitz)
        M_o3 = 48

        % Diffusion coefficients
        Dlb = 5E-5
        DM = 1.3E-5 % 0.13 cm^2/s from Massman (1998)
    end
end

