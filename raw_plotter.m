initialisation;

figure(1);
hold on;
t = linspace(0,600,75);

tests = [5 10 11];

for i = tests
    try
        ppms = tests_raw{i}.ppm(1:75);
        scatter(t, ppms, 5, 'filled', colors(find(tests==i)));
        % errorbar(t, ppms, 0.02 * ones(size(ppms)), 'LineStyle', 'none','CapSize',2);
    catch
        fprintf(strcat("RATE_CONSTS.m: tests_molar{",int2str(i),"} has been skipped as no data found\n\n"));
        continue
    end
end

legend(strcat('Test ',int2str(tests(1))), ...
    strcat('Test ',int2str(tests(2))), ...
    strcat('Test ',int2str(tests(3))));

hold off;

ylim([0 4]);

xlabel("Time (s)");
ylabel("Concentration of O3 (ppm)");
%saveas(gcf, 'ppm_filtervsnovsgac_5_10_11.png')