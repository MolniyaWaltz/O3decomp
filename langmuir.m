function [theta, v, vm] = langmuir(po3, kad, kdes, temp, carbon_S_BET, carbon_mass)
    keq = kad/kdes;
    theta = keq * po3 ./ (1 + keq .* po3);
    vm = carbon_S_BET * carbon_mass * (thermal.gas_const * temp ./ po3) / (thermal.avogadro * ozone.oxygen_cs_area);
    v = theta .* vm;
end