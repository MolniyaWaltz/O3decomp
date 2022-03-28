function [theta, vm, v] = langmuir(po3, k1, kd1, runtime)
    keq = k1/kd1;
    theta = keq * po3 / (1 + keq * po3);
    [~, ~, po3, ~] = o3gen(runtime);
    vm = const.A_AC_BET * const.m_AC * (const.R * const.T / po3) / (const.Na * const.A_o2);
    v = theta * vm
end