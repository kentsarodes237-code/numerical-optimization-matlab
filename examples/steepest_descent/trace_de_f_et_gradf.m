% Script pour tracer f(x_k) et ||grad f(x_k)|| en fonction de k
% en echelle semi-logarithmique

clear; clc; close all;

% Lancement de l'algorithme de plus forte descente
[xk, k, X] = pfd([9;1], 1e-8);

% Nombre total d'iteres stockes dans X
N = size(X,2);

% Tableaux pour stocker f(x_k) et ||grad f(x_k)||
fk = zeros(1,N);
ng = zeros(1,N);

% Calcul de la valeur de la fonction et de la norme du gradient
% pour chaque itere
for i = 1:N
    [fval, gval] = simf0(X(:,i));  % evaluation en X(:,i)
    fk(i) = fval;                  % stockage de f(x_k)
    ng(i) = norm(gval);            % stockage de ||grad f(x_k)||
end

% Indices des iterations
iters = 0:N-1;

% Ouverture d'une nouvelle figure
figure;

% Premier graphique : evolution de f(x_k)
subplot(2,1,1);
semilogy(iters, fk, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 4);
grid on;
xlabel('k');
ylabel('f(x_k)');
title('Evolution de f(x_k)');

% Deuxieme graphique : evolution de la norme du gradient
subplot(2,1,2);
semilogy(iters, ng, 'r-o', 'LineWidth', 1.5, 'MarkerSize', 4);
grid on;
xlabel('k');
ylabel('||\nabla f(x_k)||');
title('Evolution de la norme du gradient');