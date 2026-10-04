clear; clc;

% Classification analytique des points critiques de f1 :
%   grad f1 = 0 donne deux familles.
%   1) (0, pi/2 + k*pi) : det(H) = -1, donc points selles.
%   2) ((-1)^(k+1), k*pi) : H = I, donc minima stricts (et globaux),
%      avec f1 = -1/2.
% Cette classification complete l'etude numerique demandee dans l'exercice 16.

% Parametres
tol = 1e-8;
maxit = 50;
sim = 'simf1_2';

% Differents points de depart
Tests = [...
   -0.9   0.4;
   -1.2   0.2;
    0.5   2.5;
    2.0   1.0;
   -2.0   3.0;
    3.0  -1.0];

n = size(Tests,1);

% Tableaux de stockage
x01 = zeros(n,1);
x02 = zeros(n,1);
xf1 = zeros(n,1);
xf2 = zeros(n,1);
fval = zeros(n,1);
nb_iter = zeros(n,1);
conv = strings(n,1);

for i = 1:n
    
    % point initial
    x0 = [Tests(i,1); Tests(i,2)];
    
    % appel de la methode de Newton
    [xk, fk, iter, X] = newton_loc(sim, x0, tol, maxit);
    
    % recalcul propre de f et g au point final
    [f_fin, g_fin, ~] = feval(sim, xk);
    
    % stockage
    x01(i) = x0(1);
    x02(i) = x0(2);
    xf1(i) = xk(1);
    xf2(i) = xk(2);
    fval(i) = f_fin;
    nb_iter(i) = iter;
    
    if norm(g_fin) < tol
        conv(i) = "oui";
    else
        conv(i) = "non";
    end
    
    % affichage des iteres pour chaque test
    fprintf('Test %d\n', i);
    disp('Iteres :');
    disp(X);
    fprintf('-----------------------------\n');
end

% Creation du tableau final
Resultats = table(x01, x02, xf1, xf2, fval, nb_iter, conv, ...
    'VariableNames', {'x0_1','x0_2','xfinal_1','xfinal_2','f_final','iterations','convergence'});

% Affichage
disp('Tableau final des resultats :');
disp(Resultats);