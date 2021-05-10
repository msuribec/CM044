%% inicialización
clear all;
clc
close all;
rep = [2.84 1.5 0.62];
pred = [0.02 0 0.03];
cap = [0.22 0 0.1 8640 ];
ui = [0 0 0];
initial_c = [2000 175 200];

ri = strcat('[',num2str(rep),']');
K = num2str(cap(4));
ic =  strcat('[',num2str(pred),']');
pc =  strcat('[',num2str(cap([1:3])),']');
ci =  strcat('[',num2str(initial_c),']');

load_system('LVTresEspecies')
set_param('LVTresEspecies/eco','ci',ci,'ri',ri,'K',K,'ic',ic,'pc',pc)
     
U1 = ui(1);
U2 = ui(2);
U3 = ui(3);

entradas =[0:1:200];
p = size(entradas,2);
yss = zeros(p,3);

for i=1:p
    U2 = entradas(i);
    sim('LVTresEspecies');
    yss(i,:) = x(end,:);
end 
in =[5:15];
tbl = table(entradas(in)',yss(in,1),yss(in,2),yss(in,3));
tbl.Properties.VariableNames{'Var1'} = 'U';
tbl.Properties.VariableNames{'Var2'} = 'x1';
tbl.Properties.VariableNames{'Var3'} = 'x2';
tbl.Properties.VariableNames{'Var4'} = 'x3';

mdl1 = fitlm(tbl,'x1 ~ U');
coef1=mdl1.Coefficients.Estimate;

figure;
plot(entradas,yss(:,1))
hold on;
plot(entradas,entradas*coef1(2)+coef1(1));
xlabel('U') 
xlabel('tasa de ingreso de depredadores de primer nivel') 
ylabel('x1_{ss}') 
title('Estabilización de presas vs entrada(tasa de ingreso de depredadores de primer nivel)')


mdl2 = fitlm(tbl,'x2 ~ U');
coef2=mdl2.Coefficients.Estimate;

figure;
plot(entradas,yss(:,2))
hold on;
plot(entradas,entradas*coef2(2)+coef2(1));
xlabel('tasa de ingreso de depredadores de primer nivel') 
ylabel('x2_{ss}') 
title('Estabilización de depredadores de primer nivel vs entrada (tasa de ingreso de depredadores de primer nivel)')


mdl3 = fitlm(tbl,'x3 ~ U');
coef3=mdl3.Coefficients.Estimate;

figure;
plot(entradas,yss(:,3))
hold on;
plot(entradas,entradas*coef3(2)+coef3(1));
xlabel('tasa de ingreso de depredadores de primer nivel') 
ylabel('x3_{ss}') 
title('Estabilización de depredadores de segundo nivel vs entrada (tasa de ingreso de depredadores de primer nivel)')

