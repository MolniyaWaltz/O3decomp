classdef carbon
    properties
        % AC properties
        mass
        volume
        pore_radius = 2E-9 % micropore radius
        pore_density = 9E5 % 0.9 g/cm3
        S_BET = 1500
        bed_diffusivity = 5E-5
        density
    end
    methods
        function obj = carbon(some_mass, some_vol)
            obj.mass = some_mass;
            obj.volume = some_vol % Constructor;
            obj.density = some_mass / some_vol;
        end
    end
end