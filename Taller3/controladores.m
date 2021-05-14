%% ROUTH HURWITZ
syms K
[M, L]=routh_hurwitz([1 2.267+K 4.884+0.8516*K 2.3+0.1436*K]);
L1 = simplify(L);
L2 = expand(L1);


sys = tf([1 0.8516 0.1436],[1 2.267 4.884 2.3]);
sysd = c2d(sys,1);
syms s k;


%%
clc; clear all;
syms k z s;

P(z) = z^3 + (0.2956*k - 0.3689)* z^2 + (0.08454 - 0.3703*k)* z - 0.1036  + 0.113*k;
P(z) = subs(P, z, (1+s)/(1-s));
simplify(P)
% [Md, Ld]=routh_hurwitz([]);
% L1d = simplify(Ld);
% L2d = expand(L1d);


