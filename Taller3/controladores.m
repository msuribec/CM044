syms K
[M, L]=routh_hurwitz([1 K 1.731*K 0.93*K+1]);
L1 = simplify(L);
L2 = expand(L1);