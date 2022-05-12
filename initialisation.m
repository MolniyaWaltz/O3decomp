% Initial variable calculation
thisCarbon = carbon(6, 7.25E-5); % g, m3
thisThermal = thermal(303.15);

runtime = 300;
runtimes = 1:1:runtime;
[mo3, ppm, po3, litres_o3] = o3gen(runtime, thisThermal.temp);

% rate constants
k1 = 50 * mo3 / litres_o3;
k2 = 2.13 * mo3 / litres_o3; 

kd1 = 49.5E-3 * (mo3 / litres_o3) / ozone.molar_mass;
kd2 = 0.86E3; % kd2 in s^-1
kd_tot = kd1 + kd2;

% diffusion coefficient calculations
DK = 9.7E-3 * thisCarbon.pore_radius * sqrt(thisThermal.temp/48); % Knudsen diffusivity (Equation C3)
Dcomb = 1/(1/DK + 1/ozone.molecular_diffusivity); % combined diffusivities (Equation C2)

porosity = 1 - thisCarbon.pore_density / thisCarbon.density;
tortuosity = 1;
Deff = porosity * Dcomb / tortuosity;

% initialise experimental data

N = numel(dir('tests/*.txt'));

tests_raw = cell(1,N);
tests_molar = cell(1,N);
tests_log = cell(1,N);

m_air = (0.2*0.2*0.25 - 0.1*0.1*0.1) * 1.225 * 1000;

for i = 1:N
    tests_raw{i} = data_inputter(strcat('tests/test',int2str(i),'.txt'));

    tests_molar{i} = tests_raw{i};
    frac_o3 = tests_molar{i}{:,5} ./ 1E6; % Same as the mole fraction by definition.
    conc_o3 = frac_o3 .* (1225 / 28.97);
    tests_molar{i}{:,5} = conc_o3;
    tests_molar{i} = renamevars(tests_molar{i},"ppm","concO3");

    tests_log{i} = tests_molar{i};
    log_conc = arrayfun(@(x) nonegln(x), tests_log{i}{:,5});
    tests_log{i}{:,5} = log_conc;
    tests_log{i} = renamevars(tests_log{i},"concO3","lnO3");
end