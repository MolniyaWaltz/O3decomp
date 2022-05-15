initialisation;

figure(1);
t = linspace(0,800,100);
for i = [3 4]
    try
        scatter(t, tests_log{i}.lnO3(1:100));
        hold on;
    catch
        fprintf(strcat("RATE_CONSTS.m: tests_molar{",int2str(i),"} has been skipped as no data found\n\n"));
        continue
    end
end

hold off;
xlabel("Time (s)");
ylabel("ln(Concentration of O3) (mol/L)");
saveas(gcf, 'lnO3_filtervsnone.png')