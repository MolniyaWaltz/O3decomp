initialisation;

figure(1);
t = linspace(0,600,75);
for i = [9 10]
    try
        ppms = tests_raw{i}.ppm(1:75);
        scatter(t, ppms, 5, 'filled');
        hold on;
        errorbar(t, ppms, 0.02 * ones(size(ppms)), 'LineStyle', 'none','CapSize',2);
    catch
        fprintf(strcat("RATE_CONSTS.m: tests_molar{",int2str(i),"} has been skipped as no data found\n\n"));
        continue
    end
end

hold off;
xlabel("Time (s)");
ylabel("Concentration of O3 (ppm)");
saveas(gcf, 'ppm_filtervsno_9_10.png')