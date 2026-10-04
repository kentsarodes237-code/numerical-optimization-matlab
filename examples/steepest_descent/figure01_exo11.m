% Script Exercice 11
clc;
clear;
close all;

X0 = [1; 1];
alpha = linspace(0, 1, 100);
f = @(x) 0.5*x(1)^2 + 2*x(2)^2;
g0 = [1; 4];

% Directions
d1 = -g0;
d2 = [-1; -1];
d3 = [1; -3];

% Calculs des valeurs f(X0 + alpha*d)
% la commande arrayfunc a ete utilise pour eviter d'ecrire une boucle for
% pour caque valeur de alpha
y1 = arrayfun(@(a) f(X0 + a*d1), alpha);
y2 = arrayfun(@(a) f(X0 + a*d2), alpha);
y3 = arrayfun(@(a) f(X0 + a*d3), alpha);

% Tracé
figure;
plot(alpha, y1, 'r', 'LineWidth', 2); 
hold on;
plot(alpha, y2, 'g', 'LineWidth', 2);
plot(alpha, y3, 'b', 'LineWidth', 2);
grid on;
xlabel('\alpha'); 
ylabel('f(X_0 + \alpha d)');
title('Décroissance de f selon différentes directions');
legend('d_1 (Plus forte pente)', 'd_2', 'd_3');