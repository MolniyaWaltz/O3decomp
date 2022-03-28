function [theta, vm, v] = langmuir(po3)
keq = k1/kd1
theta = keq * po3 / (1 + keq * po3)
vm = 