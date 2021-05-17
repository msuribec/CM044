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

% Simplificación realizada en Symbolab

syms k

c = [7.9096-0.0396835*k, 0.0397945*k+0.0892, 0.0008-0.0002545*k, ...
     0.0001435*k+0.0004];
[M, L] = routh_hurwitz(c);
M_ans = vpa(M,4)
L_ans = vpa(L,4)
