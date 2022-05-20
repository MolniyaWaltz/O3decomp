% Decon chamber vertical diffusion model based on Alvarez et. al. (2008)
% Equation 3
% https://hal.archives-ouvertes.fr/hal-01938089/file/FAUmes-surf-rev2-proof-Langmuir_sans%20marque.pdf
initialisation;

ub = 0;

% Equation 4
syms a2(t);
a20 = 1; % Assuming fresh GAC at start of experiment
% TODO Develop loop that takes final a's and feeds into initial a's
a2 = a20 * exp(-kd2 * t);

% Equations 6 and 7
rad = 0.2; % 2mm = 0.2cm
phi = rad/3 * sqrt((k1 * a1 + k2 * a2) * rho_pore / Deff);
eff_factor = 1/phi * (1/tanh(3 * phi) - 1/(3 * phi));

syms a1(t) o3(t);
ode = diff(a1,t) == -kd1 * eff_factor *  o3 * a1;
cond = a1(0) == 1; % Assuming fresh GAC at start of experiment
a1Sol(t) = dsolve(ode,cond);

ub = 0;
Dlb = 1;

% Equation 8 (Partial Differential)
function [c,f,s] = pdex1pe(z,t,o3,do3dz)
c = 1;
f = Dlb * do3dz - ub * o3;
s = -kt * o3 - (k1 * a1(t) + k2 * a2(t)) * o3 * eff_factor * rho_bed;
end

function o30 = pdex1ic(z)
o30 = 0; 
end

function [pl,ql,pr,qr] = pdex1bc(zl,o3l,zr,o3r,t)
pl = 0;
ql = 0;
pr = 0;
qr = 0.25;
end