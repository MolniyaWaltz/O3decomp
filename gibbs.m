abstractionA = reaction(1); % Exothermic
abstractionB = reaction(2); % Exothermic
additionA = reaction(3);
additionB = reaction(4);
additionC = reaction(5); % Exothermic

i = linspace(0.5,0.7,40);

DH = i * abstractionA.heat_of_reaction + (1-i) * abstractionB.heat_of_reaction;
% Vary these?

DS = 0;
DG = DH - thisThermal.temp * DS; % in kJ/mol

% This is the Eyring equation for rate constants using Gibbs Free Energy.
% 6.626 * 10^-34 is Planck's constant.
theory_k = (thermal.boltzmann * thisThermal.temp / 6.626E-34) * exp(-1000 * DG/(thermal.gas_const * thisThermal.temp))
theory_k_hr = theory_k * 3600

plot(i .* 100,theory_k);
xlabel("Proportion of abstraction following pathway A (%)");
ylabel("Theoretical k (1/s)");
saveas(gcf, 'gibbs.png')