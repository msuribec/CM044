%% Encontrar ptos equilib

%Inicialización
clear all
clc

rep = [2.84 1.5 0.62];
pred = [0.02 0 0.03];
cap = [0.22 0 0.1 8640 ];
ui = [0 20 0];

r1 = rep(1);
r2 = rep(2);
r3 = rep(3);

a = pred(1);
b = pred(2);
c = pred(3);

K = cap(4);
alpha = cap(1);
beta = cap(2);
chi = cap(3);

U1 = ui(1);
U2 = ui(2);
U3 = ui(3);

syms x1 x2 x3;

y1 = r1*x1*(1-(x1/K))-a*x1*x2-b*x1*x3 + U1;
y2 = r2*x2*(1-(x2/(alpha*x1)))-c*x2*x3+ U2;
y3 = r3*x3*(1-(x3/(beta*x1+chi*x2)))+ U3;

sol = vpasolve([y1==0, y2==0,y3==0],[x1,x2,x3]);

xe = double([sol.x1(2) sol.x2(2) sol.x3(2)]);

%% Encontrar ecuaciones

syms x y;

x3 = xe(3);

x1dot = r1*x*(1-(x/K))-a*x*y-b*x*x3 + U1;
x2dot = r2*y*(1-(y/(alpha*x)))-c*y*x3+ U2;
