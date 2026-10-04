function [x_k, k, X, nbsim_total] = gradrl_f1(x_0, epsrel)

    x_k = x_0;
    k = 0;
    X = x_k;

    beta1 = 0.1;
    beta2 = 0.9;
    f1_sim = 'simf1';

    [~, g] = simf1(x_k);
    g0 = norm(g);

    nbsim_total = 1;

    while norm(g) > epsrel * g0

        % direction de descente
        dk = -g;

        % recherche lineaire de Wolfe
        [xnv, nbsim_wolfe] = wolfe(f1_sim, x_k, 1, dk, beta1, beta2);

        % mise a jour
        x_k = xnv;

        % nombre total d'appels au simulateur
        nbsim_total = nbsim_total + nbsim_wolfe;

        % recalcul du gradient
        [~, g] = simf1(x_k);
        nbsim_total = nbsim_total + 1;

        % stockage des iteres
        X = [X x_k];

        % compteur d'iterations
        k = k + 1;
    end

end