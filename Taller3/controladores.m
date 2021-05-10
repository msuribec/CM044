%% ROUTH HURWITZ
syms K
[M, L]=routh_hurwitz([1 K 1.731*K 0.93*K+1]);
L1 = simplify(L);
L2 = expand(L1);


sys = tf([1 1.731 0.93],[1 2.005 4.284 2.04]);
sysd = c2d(sys,1);
syms s k;

g = (k*(s^2+1.731*s +0.93))/(1+ k*(s^3 + 2.005*s^2 + 4.284*s + 2.04));
[num den]= numden(g);
