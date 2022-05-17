initialisation;

period = 600; % Seconds

t_range = linspace(0, period, period/8);
tests_nocf = [4, 7, 8];
tests_cf = [3, 5];

rateconsts_nocf = zeros(1,length(tests_nocf));
rateconsts_cf = zeros(1,length(tests_cf));

for i = 1:length(tests_nocf)
    rateconst_sec = rateconst_getter(tests_log, tests_nocf(i), period);
    rateconst_hour = rateconst_sec * 3600;
    rateconsts_nocf(i) = rateconst_hour;
end

for j = 1:length(tests_cf)
    rateconst_sec = rateconst_getter(tests_log, tests_cf(j), period);
    rateconst_hour = rateconst_sec * 3600;
    rateconsts_cf(j) = rateconst_hour;
end

rateconst_adsorption = mean(rateconsts_cf) - mean(rateconsts_nocf)