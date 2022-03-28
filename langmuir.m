function [theta, v] = langmuir(po3, kad, kdes, vm, runtime)
    keq = kad/kdes;
    [~, ~, po3, ~] = o3gen(runtime);
    theta = keq * po3 ./ (1 + keq .* po3);
    v = theta .* vm;
end