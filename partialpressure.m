function [mo3, ppm, po3] = partialpressure(time)

R = 8.314462;       % Gas constant
T = 303.15;         % Temp. in Kelvin

GR = (80E-3) / 3600 % Max generation rate per second in g/s
                    % https://www.tdk-electronics.tdk.com/inf/130/Cold_Plasma/Z63000Z2910Z%201Z72.pdf
mo3 = GR * time;     % Amount of ozone generated in grams (GR * seconds)
m = (0.2*0.2*0.25 - 0.1*0.1*0.1) * 1.225 * 1000; % Mass of air in decon. chamber from m = rho (V - V of cubesat), in grams
ppm = 1E6 * (mo3 / 48) / (m / 28.97); 
po3 = (ppm / 1E6) * 1E5; % Partial pressure of ozone from Dalton's Law
end