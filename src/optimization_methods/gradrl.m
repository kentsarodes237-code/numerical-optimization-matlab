function [x_k, k, X, nbsim_total] = gradrl(x_0, epsrel)

x_k = x_0;
k = 0;
X = x_k;

beta1 = 0.1;
beta2 = 0.9;
f0_sim = 'simf0';

[~, g] = simf0(x_k);
g0 = norm(g);
nbsim_total = 1;

while norm(g) > epsrel * g0
dk = -g;
[xnv, nbsim_wolfe] = wolfe(f0_sim, x_k, 1, dk, beta1, beta2);
x_k = xnv;
nbsim_total = nbsim_total + nbsim_wolfe;

[~, g] = simf0(x_k);
nbsim_total = nbsim_total + 1;

X = [X x_k];
k = k + 1;
end

end

% % version tre commente pour comprehnesion
% function [x_k, k, X, nbsim_total] = gradrl(x_0, epsrel)
% %--------------------------------------------------------------------------
% % FONCTION : gradrl
% %
% % ROLE :
% % Cette fonction applique la methode du gradient avec recherche lineaire
% % de Wolfe pour minimiser une fonction.
% %
% % ENTREES :
% %   x_0    : point initial (vecteur colonne)
% %   epsrel : tolerance relative pour le critere d'arret
% %
% % SORTIES :
% %   x_k         : approximation finale du minimum
% %   k           : nombre d'iterations effectuees
% %   X           : matrice contenant tous les iteres successifs
% %   nbsim_total : nombre total d'appels au simulateur
% %
% % IDEE :
% % A chaque iteration :
% %   1) on calcule la direction de descente dk = -grad f(xk)
% %   2) on appelle la fonction wolfe pour trouver un pas acceptable
% %   3) on met a jour le point courant
% %   4) on recommence jusqu'a ce que le gradient soit suffisamment petit
% %--------------------------------------------------------------------------
% 
%     %----------------------------------------------------------------------
%     % Initialisation du point courant
%     %----------------------------------------------------------------------
%     x_k = x_0;
% 
%     %----------------------------------------------------------------------
%     % Initialisation du compteur d'iterations
%     %----------------------------------------------------------------------
%     k = 0;
% 
%     %----------------------------------------------------------------------
%     % Matrice qui stockera tous les iteres successifs
%     % Au debut, elle contient seulement le point initial
%     %----------------------------------------------------------------------
%     X = x_k;
% 
%     %----------------------------------------------------------------------
%     % Parametres de Wolfe
%     % beta1 : parametre de la 1ere condition de Wolfe
%     % beta2 : parametre de la 2eme condition de Wolfe
%     %----------------------------------------------------------------------
%     beta1 = 0.1;
%     beta2 = 0.9;
% 
%     %----------------------------------------------------------------------
%     % Nom du simulateur utilise
%     % Ici, on utilise la fonction simf0
%     %----------------------------------------------------------------------
%     f0_sim = 'simf0';
% 
%     %----------------------------------------------------------------------
%     % Premier calcul du gradient au point initial
%     % On ne garde pas la valeur de la fonction, seulement le gradient
%     %----------------------------------------------------------------------
%     [~, g] = simf0(x_k);
% 
%     %----------------------------------------------------------------------
%     % Norme du gradient initial
%     % Elle sert pour le critere d'arret relatif
%     %----------------------------------------------------------------------
%     g0 = norm(g);
% 
%     %----------------------------------------------------------------------
%     % Compteur total d'appels au simulateur
%     % On a deja fait un premier appel ci-dessus
%     %----------------------------------------------------------------------
%     nbsim_total = 1;
% 
%     %----------------------------------------------------------------------
%     % Boucle principale :
%     % on continue tant que la norme du gradient courant reste
%     % plus grande que epsrel * norme(gradient initial)
%     %----------------------------------------------------------------------
%     while norm(g) > epsrel * g0
% 
%         %------------------------------------------------------------------
%         % Direction de descente :
%         % on choisit l'oppose du gradient
%         %------------------------------------------------------------------
%         dk = -g;
% 
%         %------------------------------------------------------------------
%         % Recherche lineaire de Wolfe :
%         % on demande a la fonction wolfe de trouver un pas acceptable
%         % en partant de alpha = 1
%         %
%         % xnv         : nouveau point trouve
%         % nbsim_wolfe : nombre d'appels au simulateur effectues par wolfe
%         %------------------------------------------------------------------
%         [xnv, nbsim_wolfe] = wolfe(f0_sim, x_k, 1, dk, beta1, beta2);
% 
%         %------------------------------------------------------------------
%         % Mise a jour du point courant
%         %----------------------------------------------------------------------
%         x_k = xnv;
% 
%         %------------------------------------------------------------------
%         % On ajoute au compteur total les appels faits dans wolfe
%         %------------------------------------------------------------------
%         nbsim_total = nbsim_total + nbsim_wolfe;
% 
%         %------------------------------------------------------------------
%         % Recalcul du gradient au nouveau point
%         %------------------------------------------------------------------
%         [~, g] = simf0(x_k);
% 
%         % Cet appel supplementaire doit aussi etre compte
%         nbsim_total = nbsim_total + 1;
% 
%         %------------------------------------------------------------------
%         % On stocke le nouvel itere dans la matrice X
%         % Chaque nouvel itere est ajoute comme nouvelle colonne
%         %------------------------------------------------------------------
%         X = [X x_k];
% 
%         %------------------------------------------------------------------
%         % Incrementation du compteur d'iterations
%         %------------------------------------------------------------------
%         k = k + 1;
%     end
% 
% end