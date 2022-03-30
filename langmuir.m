function [theta, v] = langmuir(po3, kad, kdes, vm)
    keq = kad/kdes;
    theta = keq * po3 ./ (1 + keq .* po3);
    v = theta .* vm;
end