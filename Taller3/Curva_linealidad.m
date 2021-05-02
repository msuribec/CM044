%% inicialización
clear all;
clc
close all;
rep = [2.84 1.5 0.62];
pred = [0.02 0 0.03];
cap = [0.22 0 0.1 8640 ];
ui = [0 0 0];


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


x10 = 2000;
x20 = 175;
x30 = 200;


entradas =[-100:20:100];
p = size(entradas,2);
yss = zeros(p,3);

for i=1:p
    U1 = entradas(i);
    sim('LVTresEspecies');
    set1 = stepinfo(x(:,1),t,'SettlingTimeThreshold',0.05).SettlingTime;
    set2 = stepinfo(x(:,2),t,'SettlingTimeThreshold',0.05).SettlingTime;
    set3 = stepinfo(x(:,3),t,'SettlingTimeThreshold',0.05).SettlingTime;
    set = [ round(set1,2) round(set2,2) round(set3,2)];
    index1 = round(set(1)*100);
    index2 = round(set(2)*100);
    index3 = round(set(3)*100);
    yss(i,:) = [ x(index1,1) x(index2,2) x(index3,3)]; 
end 
figure;
scatter(entradas,yss(:,1))

figure;
scatter(entradas,yss(:,2))

figure;
scatter(entradas,yss(:,3))

plot(entradas,yss(:,1))

figure;
plot(entradas,yss(:,2))

figure;
plot(entradas,yss(:,3))
