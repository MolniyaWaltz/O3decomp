classdef ozone
    properties (Constant)
        % Ozone and oxygen properties
        oxygen_cs_area = 1E-19 % 10 angstroms^2 (Deitz)
        molar_mass = 48
        molecular_diffusivity = 1.3E-5 % 0.13 cm^2/s from Massman (1998)
    end
end