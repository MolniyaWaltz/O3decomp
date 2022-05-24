initialisation;

figure(1);
hold on;
t = linspace(0,600,75);

tests = [5 10 12];

for i = tests
    logs = tests_log{i}.lnO3(1:75);
    % errorbar(t, conc, 0.02 .* ((1225 / 28.97)/1E6) * ones(size(conc)), 'LineStyle', 'none','CapSize',2);
    sc = scatter(t, logs, 5, colors(find(tests==i)), 'filled','DisplayName', strcat('Test',int2str(i)));

    c = polyfit(t, logs, 1);
    disp(['ln[O3] = ' num2str(c(1)) ' * t + ' num2str(c(2))]);
    disp(['Implying that kt prime = ' num2str(-3600 * c(1)) ' /hr, and initial [O3] = ' num2str(exp(c(2))) ' mol/L']);

    lnO3_est = polyval(c,t);
    pl = plot(t,lnO3_est,'r--','LineWidth',1,'DisplayName',strcat('Test',int2str(i), ' Fit line'), 'color', colors(find(tests==i)));

    fprintf(strcat("RATE_CONSTS.m: tests_molar{",int2str(i),"} has been skipped as no data found\n\n"));
end

hold off;
xlabel("Time (s)");
ylabel("ln(Concentration of O3) (mol/L)");

legend('show')

%saveas(gcf, 'lnO3_filtervsno.png')