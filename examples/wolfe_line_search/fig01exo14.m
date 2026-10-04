
clc;
clear;
close all;

% --- Données du problème ---
x0 = [10 ; 1];          % Point de départ (vecteur colonne)
D1 = [-10 ; -9];        % Direction 1
D2 = [-2 ; 1];          % Direction 2

% --- Normalisation des directions ---
% On divise chaque vecteur par sa longueur (norme) pour avoir une taille de 1
d1 = D1 / norm(D1); 
d2 = D2 / norm(D2);

% --- Paramètres de test ---
alpha_max = 5;          % On teste alpha de 0 à 5
pas = 0.1;              % On avance de 0.1 en 0.1
alphas = 0 : pas : alpha_max; 

% Seuils beta2 à tester
beta2_valeurs = [0.1, 0.5, 0.9];

% Calcul du gradient au point initial x0
% f0 = 1/2*x1^2 + 9/2*x2^2  => grad = [x1 ; 9*x2]
grad_initial = [x0(1) ; 9*x0(2)];

% Produit scalaire initial (pente au départ)d1
pente_initialed1 = grad_initial(1)*d1(1) + grad_initial(2)*d1(2);
% Produit scalaire initial (pente au départ)d2
pente_initialed2 = grad_initial(1)*d2(1) + grad_initial(2)*d2(2);

% Création d'un tableau vide pour stocker les résultats d1
rapports_d1 = zeros(1, length(alphas));
% Création d'un tableau vide pour stocker les résultats d1
rapports_d2 = zeros(1, length(alphas));

for i = 1:length(alphas)
    % 1. On trouve le nouveau point x
    a = alphas(i);
    x_actueld1 = x0 + a * d1;
    x_actueld2 = x0 + a * d2;
    
    % 2. On calcule le gradient à ce nouveau point
    grad_actueld1 = [x_actueld1(1) ; 9*x_actueld1(2)];
    grad_actueld2 = [x_actueld2(1) ; 9*x_actueld2(2)];
    
    % 3. On calcule la nouvelle pente (produit scalaire)
    pente_actuelled1 = grad_actueld1(1)*d1(1) + grad_actueld1(2)*d1(2);
    pente_actuelled2 = grad_actueld2(1)*d2(1) + grad_actueld2(2)*d2(2);
    
    % 4. On calcule le rapport R
    rapports_d1(i) = pente_actuelled1 / pente_initialed1;
    rapports_d2(i) = pente_actuelled2 / pente_initialed2;
end


figure(1);
hold on; % Pour dessiner plusieurs choses sur le même graphique
% Tracer la courbe du rapport
plot(alphas, rapports_d1, 'b', 'LineWidth', 2);
plot(alphas, rapports_d2, 'r', 'LineWidth', 2); 

% Tracer les lignes horizontales pour les conditions de Wolfe
plot([0 5], [0.1 0.1], 'y--', 'LineWidth', 2); % Ligne pour beta2 = 0.1
plot([0 5], [0.5 0.5], 'g--', 'LineWidth', 2); % Ligne pour beta2 = 0.5
plot([0 5], [0.9 0.9], 'k--', 'LineWidth', 2); % Ligne pour beta2 = 0.9

grid on;
title('Condition de Courbure pour d1 et d2');
xlabel('Valeur de alpha');
ylabel('Rapport des pentes');
%legend('Dans la diretion d1','Dans la diretion d2')
legend('Rapport R(\alpha) de d1', 'Rapport R(\alpha) de d2', '\beta_2 = 0.1', '\beta_2 = 0.5', '\beta_2 = 0.9');