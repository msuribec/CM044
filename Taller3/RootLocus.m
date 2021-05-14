%% Método lugar de las raíces continuo

clear all; close all; clc;

s = tf('s');

Gc = (s^2 + .8516*s + .1436)/(s^3 + 2.267*s^2 + 4.884*s + 2.3)

rlocus(Gc)

%% Método lugar de las raíces discreto

clear all; close all; clc;

syms k w z

z = (1+w)/(1-w);
P = z^3 + (0.2956*k-.3689)*z^2 + (.08454-.3703*k)*z - .1036 + .113*k;
Q = simplifyFraction(vpa(P));
[n, d] = numden(Q);
n = collect(n, [w^3,w^2,w,1]); % Factorización por agrupación

% Extracción de coeficientes
c(1) = children(children(n,1),1);
c(2) = children(children(n,2),1);
c(3) = children(children(n,3),1);
c(4) = children(n,4);

pretty(n/d)
c

[M, L] = routh_hurwitz(c);
M

