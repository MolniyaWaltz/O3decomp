function [rateconst] = rateconst_getter(test_table, which_test, no_of_secs)
    points = no_of_secs/8;
    time_range = linspace(0,no_of_secs,points);
    fit = polyfit(time_range, test_table{which_test}.lnO3(1:points), 1);
    rateconst = -fit(1);
end