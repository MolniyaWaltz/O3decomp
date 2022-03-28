% heavily WIP

E1 = 1.12 * 288.49 * 1000;
EL = 288.49 * 1000;
c = exp((E1 - EL)/(R * T)); % BET Constant

p0 = 55.009 * 10^5;
p_array = [0:0.01:3.5] * 10^5;

% BET Isotherm calculation 1:
numerator = Vm * c * p_array;
p_diff = p0 - p_array;
p_ratio_scaled = 1 + (c - 1) * (p_array/p0);
V_array = numerator./(p_diff .* p_ratio_scaled); % from Activated Carbon Adsorption by Bansal and Goyal (2005)
theta = V_array/Vm % Adsorption fraction
figure(1); 
plot(p_array,V_array);