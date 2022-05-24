classdef thermal
    properties
        temp
    end
    properties (Constant)
        avogadro = 6.022E23
        gas_const = 8.314462
        boltzmann = thermal.gas_const / thermal.avogadro
    end
    methods
        function obj = thermal(some_temp)
            obj.temp = some_temp;
        end
    end
end