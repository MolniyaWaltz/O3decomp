classdef reaction
    %REACTION A reaction taking place, with associated bond energies.
    
    properties
        C_C_broken = 0;
        C_O_broken = 0;
        C_double_C_broken = 0;
        C_double_O_broken = 0;
        O_O_broken = 0;
        O_double_O_broken = 0;
        
        C_C_formed = 0;
        C_O_formed = 0;
        C_double_C_formed = 0;
        C_double_O_formed = 0;
        O_O_formed = 0;
        O_double_O_formed = 0;
        

        heat_of_reaction = 0;
    end
    methods
        function obj = reaction(i)
            if i == 1
                obj.C_C_broken = 1;
                obj.O_O_broken = 1;
                obj.C_O_formed = 1;
            elseif i == 2
                obj.C_double_C_broken = 1;
                obj.O_O_broken = 1;
                obj.C_double_O_formed = 1;
            elseif i >= 3
                obj.C_double_C_broken = 1;
                % As this is ozonolysis, a C_double_C must be cleaved
                if i == 3
                    obj.O_double_O_broken = 1;
                    obj.C_O_formed = 4;
                elseif i == 4
                    obj.C_C_formed = 1;
                    obj.O_double_O_broken = 1;
                    obj.O_O_formed = 1;
                    obj.C_O_formed = 2;
                elseif i == 5
                    obj.C_C_formed = 1;
                    obj.C_O_formed = 1;
                    obj.O_O_formed = 1;
                    obj.O_double_O_broken = 1;
                end
            end
            obj.heat_of_reaction = determine_heat(obj);
        end
        function heat_of_reaction = determine_heat(obj)
            heat_released = obj.C_C_broken * 347 + ...
            obj.C_O_broken * 358 + obj.C_double_C_broken * 614 + ...
            obj.C_double_O_broken * 745 + obj.O_O_broken * 146 + ...
            obj.O_double_O_broken * 495;

            heat_taken = obj.C_C_formed * 347 + ...
            obj.C_O_formed * 358 + obj.C_double_C_formed * 614 + ...
            obj.C_double_O_formed * 745 +  obj.O_O_formed * 146 + ...
            obj.O_double_O_formed * 495;
            heat_of_reaction = heat_released - heat_taken;
            % Approximation of enthalpy of reaction using bond energies
            % taken from chem.libretexts.org
        end
    end
end

