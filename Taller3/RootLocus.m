%% Método lugar de las raíces continuo

clear all; close all; clc;

s = tf('s');

Gc = (s^2 + .8516*s + .1436)/(s^3 + 2.267*s^2 + 4.884*s + 2.3)

rlocus(Gc)


%% Método lugar de las raíces discreto

clear all; close all; clc;

z = tf('z', -1);
% z = (1+s)/(1-s);
Gd = (0.009929*z^2 - 0.01977*z + 0.0099845)/(z^3 - 2.977*z^2 + 2.955*z - 0.9776);

rlocus(Gd)