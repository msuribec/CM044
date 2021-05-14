%% inicialización
clear all
clc

rep = [2.84 1.5 0.62];
pred = [0.02 0 0.03];
cap = [0.22 0 0.1 8640 ];
ui = [0 20 0];


%% Encontrar ptos equilibrios

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

res = round(double([sol.x1 sol.x2 sol.x3]),4);

%% Linealización manual


syms x1 x2 x3 r1 r2 r3 a b c alpha beta chi u1 u2 u3 K;

y1 = r1*x1*(1-(x1/K))-a*x1*x2-b*x1*x3 + u1;
y2 = r2*x2*(1-(x2/(alpha*x1)))-c*x2*x3+u2;
y3 = r3*x3*(1-(x3/(beta*x1+chi*x2)))+u3;

A1 = [diff(y1,x1) diff(y1,x2) diff(y1,x3);
         diff(y2,x1) diff(y2,x2) diff(y2,x3);
         diff(y3,x1) diff(y3,x2) diff(y3,x3)
    ];

B1 = [diff(y1,u2);
      diff(y2,u2);
      diff(y3,u2);
    ];

A = subs(A1,{x1 x2 x3 r1 r2 r3 a b c alpha beta chi K u1 u2 u3},{xe(1) xe(2) xe(3) rep(1) rep(2) rep(3) pred(1) pred(2) pred(3) cap(1) cap(2) cap(3) cap(4) ui(1) ui(2) ui(3)});
B = subs(B1,{x1 x2 x3 r1 r2 r3 a b c alpha beta chi K u1 u2 u3},{xe(1) xe(2) xe(3) rep(1) rep(2) rep(3) pred(1) pred(2) pred(3) cap(1) cap(2) cap(3) cap(4) ui(1) ui(2) ui(3)});
 

C = [0 1 0];
D = 0;


A_teor = double(A);
B_teor = double(B);
%% Linealización con función Linmod

ri = strcat('[',num2str(rep),']');
K = num2str(cap(4));
ic =  strcat('[',num2str(pred),']');
pc =  strcat('[',num2str(cap([1:3])),']');
ci =  strcat('[',num2str(xe),']');

load_system('LVTresEspecies')
set_param('LVTresEspecies/eco','ci',ci,'ri',ri,'K',K,'ic',ic,'pc',pc)
      
A_num = linmod('LVTresEspecies').a;

%% Función de transferencia

sys =ss(A_teor,B_teor,C,D);
figure;
pzmap(sys)
g=tf(sys);

%% Comparar modelos
close all;

x20 = xe(2);
u0 = ui(2);
deltau = 0.05;
U2= ui(2) + deltau;

A = strcat('[',num2str(A_num(1,:)),';',num2str(A_num(2,:)),';',num2str(A_num(3,:)),']');
B = strcat('[',num2str(B_teor(1)),';',num2str(B_teor(2)),';',num2str(B_teor(3)),']');
C = strcat('[',num2str(C),']');
D = '0';

load_system('LVLineal')
set_param('LVLineal/eco', 'ci', ci,'ri', ri, 'K', K, 'ic', ic, ...
          'pc', pc)
      
set_param('LVLineal/lin', 'A',A,'B',B, 'C', C, 'D', D)
sim('LVLineal')

hFig = figure;
set(0,'CurrentFigure',hFig) % you say to Matlab to make hFig thecurrent figure 
h1=subplot(3,1,1);
plot(t,x(:,1))

xlabel('Tiempo') 
ylabel('Población') 
title('Población de presas vs tiempo')

set(0,'CurrentFigure',hFig) % you say to Matlab to make hFig thecurrent figure 
h1=subplot(3,1,2);
plot(t,x(:,2))


xlabel('Tiempo') 
ylabel('Población') 
title('Población de depredadores de primer nivel vs tiempo')

set(0,'CurrentFigure',hFig) % you say to Matlab to make hFig thecurrent figure 
h1=subplot(3,1,3);
plot(t,x(:,3))

xlabel('Tiempo') 
ylabel('Población') 
title('Población de depredadores de segundo nivel vs tiempo')

figure;
plot(t,x(:,2))
hold on
plot(t,linx2)
legend('Modelo No lineal','Modelo Lineal')
xlabel('Tiempo') 
ylabel('Población') 
title('Población de presas vs tiempo')


%% Comparación con entrada sinusoidal
load_system('LVLineal')

delete_line('LVLineal','u2/1','eco/2');
delete_line('LVLineal','u2/1','Sum/1');
delete_line('LVLineal','u2/1','Mux1/2');
delete_block('LVLineal/u2')
add_block('simulink/Sources/Sine Wave','LVLineal/u2');
amp = 1;
set_param('LVLineal/u2','Amplitude',num2str(amp),'Bias',num2str(u0))
    
add_line('LVLineal','u2/1','eco/2');
add_line('LVLineal','u2/1','Mux1/2');
add_line('LVLineal','u2/1','Sum/1');

sim('LVLineal')

figure;
subplot(2,1,1)
plot(t,x(:,2))
hold on
plot(t,linx2)
legend('Modelo No lineal','Modelo Lineal')
xlabel('Tiempo') 
ylabel('Población') 
title('Población de presas vs tiempo')

subplot(2,1,2)
plot(t,u(:,2))
xlabel('Tiempo') 
ylabel('U') 
title('Entrada(tasa de ingreso de depredadores) vs tiempo')
close_system('LVLineal',0)


%% Controlador continuo

ref = 0.0006;
deltax = 0;
deltau = 0.05;
x20 = xe(2)+ deltax;
u0 = ui(2);
U2= ui(2) + deltau;
k = -2;

sim('ControladorContinuo')

plot(t,y(:,1))
hold on
plot(t,y(:,2))

xlabel('Tiempo') 
ylabel('Respuesta temporal') 
legend('Controlador modelo lineal','Controlador modelo NL')
title('Respuesta de los sistemas (lineal y no lineal) con el controlador k continuo ')


