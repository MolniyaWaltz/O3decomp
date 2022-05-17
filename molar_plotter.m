initialisation;

figure(1);
t = linspace(0,600,75);

for i = [9 10]
    try
        conc = tests_molar{i}.concO3(1:75);
        % errorbar(t, conc, 0.02 .* ((1225 / 28.97)/1E6) * ones(size(conc)), 'LineStyle', 'none','CapSize',2);
        f = fit(t(:), conc, 'exp1')
        plot(f, t(:), conc);
        legend('hide');
        hold on;
    catch
        fprintf(strcat("RATE_CONSTS.m: tests_molar{",int2str(i),"} has been skipped as no data found\n\n"));
        continue
    end
end

hold off;
xlabel("Time (s)");
ylabel("Concentration of O3 (mol/L)");

saveas(gcf, 'mols_filtervsno_9_10.png')