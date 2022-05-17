% Initial variable calculation
thisCarbon = carbon(6, 7.25E-5); % g, m3
thisThermal = thermal(303.15);

runtime = 10;
runtimes = 1:1:runtime;
[moles_o3, ppm, po3, predict_conc_o3] = o3gen(runtime, thisThermal.temp);

mo3 = moles_o3 * ozone.molar_mass;
litres_o3 = moles_o3 * thermal.gas_const * thisThermal.temp / po3;
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
    try
        tests_raw{i} = inputter(strcat('cleanedtests/test',int2str(i),'.txt'));
    catch
        fprintf(strcat("INITIALISATION.m: tests_raw{",int2str(i),"} has been skipped.\n\n"));
        continue
    end

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

% Calculate averages
avg_ppm_acf = zeros(75,1);
avg_ppm_nocf = zeros(75,1);
for j = [3 5]
    avg_ppm_acf = avg_ppm_acf + tests_raw{j}.ppm(1:75);
end

avg_ppm_acf = avg_ppm_acf / length(j);

for k = [4 7 8]
    avg_ppm_nocf = avg_ppm_nocf + tests_raw{k}.ppm(1:75);
end

avg_ppm_nocf = avg_ppm_nocf / length(k);

avg_concO3_acf = avg_ppm_acf .* ((1225 / 28.97)/1E6);
avg_concO3_nocf = avg_ppm_nocf .* ((1225 / 28.97)/1E6);