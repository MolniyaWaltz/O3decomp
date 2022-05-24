initialisation;

figure(1);
hold on;
t = linspace(0,600,75);

tests = [5 10 11];

for i = tests
    conc = tests_molar{i}.concO3(1:75);
    % errorbar(t, conc, 0.02 .* ((1225 / 28.97)/1E6) * ones(size(conc)), 'LineStyle', 'none','CapSize',2);
    f = fit(t(:), conc, 'exp1');
    pl = plot(f, t(:), conc);

    set(pl,'color',colors(find(tests==i)));
end

hold off;

ylim([0 2E-4]);

xlabel("Time (s)");
ylabel("Concentration of O3 (mol/L)");

%legend(strcat('Test ',int2str(tests(1))), ...
%    strcat('Test ',int2str(tests(1)),' fit curve'), ...
%    strcat('Test ',int2str(tests(2))), ...
%    strcat('Test ',int2str(tests(2)),' fit curve'), ...
%    strcat('Test ',int2str(tests(3))), ...
%    strcat('Test ',int2str(tests(3)),' fit curve'));

legend('1 ACF','1 ACF fit curve','No Carbon','No Carbon fit curve','6g GAC','6g GAC fit curve');

%saveas(gcf, 'mols_filtervsnovsgac_5_10_11.png')