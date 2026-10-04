function [xnv,nbsim] = wolfe(sim,xk,alpha,dk,beta1,beta2)
nbsim = 0;
amax = 100;
amin = 0;
[fk,gk] = feval(sim,xk);
nbsim = nbsim + 1;
gtd_initial = gk' * dk;

while (amax - amin) > 1e-10
    xtest = xk + alpha*dk;
    [ftest,gtest] = feval(sim,xtest);
    nbsim = nbsim + 1;

    % test de la premiere condition de Wolfe
    if ftest > fk + beta1*alpha*gtd_initial
        amax = alpha;
        alpha = (amin + amax)/2;
    else
        % test de la deuxieme condition de Wolfe
        gtd_test = gtest' * dk;
        if gtd_test < beta2*gtd_initial
            amin = alpha;
            if amax == 100
                alpha = 2*alpha;
            else
                alpha = (amin + amax)/2;
            end
        else
            break;
        end
    end
end

xnv = xk + alpha*dk;
end




% %version tres commente pour comprehension
% 
% function [xnv, nbsim] = wolfe(sim, xk, alpha, dk, beta1, beta2)
% %--------------------------------------------------------------------------
% % FONCTION : wolfe
% %
% % ROLE :
% % Cette fonction effectue une recherche lineaire de Wolfe afin de trouver
% % un pas alpha acceptable dans la direction de descente dk a partir du point xk.
% %
% % ENTREES :
% %   sim   : nom du simulateur/fonction (par exemple 'simf0')
% %           Cette fonction doit renvoyer [f, g] avec :
% %             f = valeur de la fonction
% %             g = gradient de la fonction
% %
% %   xk    : point courant (vecteur colonne)
% %
% %   alpha : valeur initiale du pas a tester
% %
% %   dk    : direction de descente
% %
% %   beta1 : parametre de la 1ere condition de Wolfe
% %           (condition de diminution suffisante)
% %
% %   beta2 : parametre de la 2eme condition de Wolfe
% %           (condition de courbure)
% %
% % SORTIES :
% %   xnv   : nouveau point obtenu apres recherche du pas
% %   nbsim : nombre total d'appels au simulateur
% %
% % IDEE :
% % On cherche un pas alpha tel que :
% %
% % 1) f(xk + alpha*dk) <= f(xk) + beta1*alpha*gradf(xk)'*dk
% %    -> le pas ne doit pas etre trop grand
% %
% % 2) gradf(xk + alpha*dk)'*dk >= beta2*gradf(xk)'*dk
% %    -> le pas ne doit pas etre trop petit
% %
% % Si le pas est trop grand, on le reduit.
% % Si le pas est trop petit, on l'augmente.
% %--------------------------------------------------------------------------
%     
%     %----------------------------------------------------------------------
%     % Initialisation du compteur d'appels au simulateur
%     %----------------------------------------------------------------------
%     nbsim = 0;
%     
%     %----------------------------------------------------------------------
%     % Bornes initiales de la recherche du pas
%     % amin : borne inferieure
%     % amax : borne superieure
%     %
%     % Au debut, on ne connait pas encore le bon intervalle.
%     % On prend donc une grande borne superieure arbitraire.
%     %----------------------------------------------------------------------
%     amax = 100;
%     amin = 0;
%     
%     %----------------------------------------------------------------------
%     % Evaluation initiale de la fonction et du gradient au point xk
%     %
%     % feval(sim, xk) signifie :
%     % "appeler la fonction dont le nom est contenu dans sim,
%     %  en lui donnant xk comme argument"
%     %
%     % Par exemple, si sim = 'simf0', alors Matlab fait :
%     % [fk, gk] = simf0(xk)
%     %----------------------------------------------------------------------
%     [fk, gk] = feval(sim, xk);
%     
%     % On compte cet appel au simulateur
%     nbsim = nbsim + 1;
%     
%     %----------------------------------------------------------------------
%     % Produit scalaire initial gradient-direction :
%     % gradf(xk)' * dk
%     %
%     % Cette quantite represente la pente initiale de la fonction
%     % dans la direction dk au point xk.
%     %
%     % Comme dk est une direction de descente, cette quantite est
%     % normalement negative.
%     %----------------------------------------------------------------------
%     gtd_initial = gk' * dk;
%     
%     %----------------------------------------------------------------------
%     % Boucle principale de recherche du pas
%     %
%     % Tant que l'intervalle [amin, amax] n'est pas suffisamment petit,
%     % on continue a ajuster alpha.
%     %----------------------------------------------------------------------
%     while (amax - amin) > 1e-10
%         
%         %------------------------------------------------------------------
%         % Point teste pour la valeur actuelle du pas alpha
%         %------------------------------------------------------------------
%         x_test = xk + alpha * dk;
%         
%         %------------------------------------------------------------------
%         % Evaluation de la fonction et du gradient au point teste
%         %------------------------------------------------------------------
%         [f_test, g_test] = feval(sim, x_test);
%         
%         % On compte cet appel supplementaire
%         nbsim = nbsim + 1;
%         
%         %------------------------------------------------------------------
%         % TEST 1 : premiere condition de Wolfe
%         %
%         % Condition d'acceptation :
%         % f(xk + alpha*dk) <= f(xk) + beta1*alpha*gradf(xk)'*dk
%         %
%         % Si cette condition n'est pas verifiee, alors le pas est juge
%         % trop grand : la fonction n'a pas suffisamment diminue.
%         %------------------------------------------------------------------
%         if f_test > fk + beta1 * alpha * gtd_initial
%             
%             % Le pas est trop grand : on le borne par le haut
%             amax = alpha;
%             
%             % Nouveau pas = milieu de l'intervalle [amin, amax]
%             alpha = (amin + amax) / 2;
%             
%         else
%             %--------------------------------------------------------------
%             % Si on arrive ici, la 1ere condition de Wolfe est satisfaite.
%             % On teste alors la 2eme condition de Wolfe.
%             %--------------------------------------------------------------
%             
%             % Produit scalaire gradient-direction au point teste
%             gtd_test = g_test' * dk;
%             
%             %--------------------------------------------------------------
%             % TEST 2 : deuxieme condition de Wolfe
%             %
%             % Condition d'acceptation :
%             % gradf(xk + alpha*dk)'*dk >= beta2*gradf(xk)'*dk
%             %
%             % Si cette condition n'est pas verifiee, cela signifie que
%             % la pente n'a pas assez change : le pas est trop petit.
%             %--------------------------------------------------------------
%             if gtd_test < beta2 * gtd_initial
%                 
%                 % Le pas est trop petit : on le borne par le bas
%                 amin = alpha;
%                 
%                 %----------------------------------------------------------
%                 % Si amax vaut encore 100, cela signifie qu'on n'a pas
%                 % encore trouve de vraie borne superieure utile.
%                 % Dans ce cas, on essaye d'aller plus loin en doublant alpha.
%                 %----------------------------------------------------------
%                 if amax == 100
%                     alpha = 2 * alpha;
%                 else
%                     % Sinon, on prend le milieu de l'intervalle
%                     alpha = (amin + amax) / 2;
%                 end
%                 
%             else
%                 %----------------------------------------------------------
%                 % Si on arrive ici, alors les deux conditions de Wolfe
%                 % sont satisfaites.
%                 %
%                 % Le pas alpha est donc accepte.
%                 %----------------------------------------------------------
%                 break;
%             end
%         end
%     end
%     
%     %----------------------------------------------------------------------
%     % Nouveau point renvoye par l'algorithme
%     %----------------------------------------------------------------------
%     xnv = xk + alpha * dk;
%     
% end