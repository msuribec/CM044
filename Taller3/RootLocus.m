%% Método lugar de las raíces continuo

clear all; close all; clc;

s = tf('s');

Gc = (s^2 + .8516*s + .1436)/(s^3 + 2.267*s^2 + 4.884*s + 2.3)

rlocus(Gc)


%% Método lugar de las raíces discreto

clear all; close all; clc;

G = tf([1 0.8516 0.1436],[1 2.267 4.884 2.3]);
Gd = c2d(G,0.01);

rlocus(Gd) 