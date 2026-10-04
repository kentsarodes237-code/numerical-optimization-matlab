function [xk, fk, iter, X] = newton_loc(sim, x0, tol, maxit)
%NEWTON_LOC Methode de Newton locale avec pas adaptatif de Wolfe.
%   [xk,fk,iter,X] = newton_loc(sim,x0,tol,maxit)
%
%   La direction de Newton est utilisee lorsque la Hessienne est definie
%   positive. Sinon, on utilise -grad f afin de conserver une direction de
%   descente. Le pas est choisi avec la recherche lineaire de Wolfe deja
%   implementee dans wolfe.m.

xk = x0;
X = xk;
iter = 0;

% Parametres de Wolfe (les memes que pour gradrl_gen)
beta1 = 0.1;
beta2 = 0.9;

for k = 1:maxit
    [f, g, h] = feval(sim, xk);

    % Arret : aucun nouvel pas de Newton n'est effectue si le gradient est
    % deja suffisamment petit.
    if norm(g) < tol
        break;
    end

    % Direction locale de Newton si H est definie positive ; sinon repli
    % sur la plus forte descente.
    if all(eig(h) > 0)
        d = -h \ g;
    else
        d = -g;
    end

    % Securite : la direction utilisee doit etre une direction de descente.
    if g' * d >= 0
        d = -g;
    end

    % Pas adaptatif satisfaisant les deux conditions de Wolfe.
    [xnew, ~] = wolfe(sim, xk, 1, d, beta1, beta2);

    % Mise a jour et stockage de l'itere effectivement calcule.
    xk = xnew;
    X = [X xk]; %#ok<AGROW>
    iter = iter + 1;
end

% Evaluation finale coherente avec le point retourne.
[fk, ~, ~] = feval(sim, xk);

end
