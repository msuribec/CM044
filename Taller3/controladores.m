%% Routh-Hurwitz Continuo
syms K
[M, L]=routh_hurwitz([1 2.267+K 4.884+0.8516*K 2.3+0.1436*K]);
L1 = simplify(L);
L2 = expand(L1);


sys = tf([1 0.8516 0.1436],[1 2.267 4.884 2.3]);
sysd = c2d(sys,0.01);
syms s k;


%% Routh-Hurwitz Discreto

clear all; close all; clc;

syms k s z
sympref('FloatingPointOutput',true);

z = (1+s)/(1-s);
P = z^3 + (0.009929*k-2.977)*z^2 + (2.955-0.01977*k)*z - 0.9776 + 0.0099845*k;
Q = simplifyFraction(vpa(P));
[n, d] = numden(Q);
n = collect(n, [s^3,s^2,s,1]); % Factorización por agrupación

% Extracción de coeficientes
c(1) = children(children(n,1),1);
c(2) = children(children(n,2),1);
c(3) = children(children(n,3),1);
c(4) = children(n,4);

pretty(n/d)
-n
-c

[M, L] = routh_hurwitz(-c);
M
SL = L;
SL(4) = SL(3);
simplify(SL)
expand(SL)
