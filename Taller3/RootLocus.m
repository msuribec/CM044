%% Método lugar de las raíces continuo

clear all; close all; clc;

s = tf('s');

Gc = (s^2 + .8516*s + .1436)/(s^3 + 2.267*s^2 + 4.884*s + 2.3)

rlocus(Gc)

%% Routh Hurwitz discreto

clear all; close all; clc;

syms k s z

z = (1+s)/(1-s);
P = z^3 + (0.2956*k-.3689)*z^2 + (.08454-.3703*k)*z - .1036 + .113*k;
Q = simplifyFraction(vpa(P));
[n, d] = numden(Q);
n = collect(n, [s^3,s^2,s,1]); % Factorización por agrupación

% Extracción de coeficientes
c(1) = children(children(n,1),1);
c(2) = children(children(n,2),1);
c(3) = children(children(n,3),1);
c(4) = children(n,4);

pretty(n/d)
-c

[M, L] = routh_hurwitz(-c);
M
SL = simplify(L)


%% Método lugar de las raíces discreto

clear all; close all; clc;

z = tf('z', -1);
% z = (1+s)/(1-s);
Gd = (0.2956*z^2 - 0.3703*z + 0.113)/(z^3 - 0.3689*z^2 + 0.08454*z - 0.1036);

rlocus(Gd)