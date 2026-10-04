 	clear; 
    clc; 
    close all;
 	
 	% Definition de la fonction et du gradient
 	f = @(x) 0.5*x(1)^2 + 4.5*x(2)^2;
 	gradf = @(x) [x(1); 9*x(2)];
 	
 	% Point initial
 	x0 = [10; 1];
 	f0_val = f(x0);
 	g0 = gradf(x0);
 	
 	% Directions
 	D1 = [-10; -9];
 	D2 = [-2; 1];
 	d1 = D1 / norm(D1);
 	d2 = D2 / norm(D2);
 	
 	% Produits scalaires
 	gTd1 = g0' * d1;
 	gTd2 = g0' * d2;
 	
 	% Pas alpha
 	alpha = linspace(0, 5, 200);
 	
 	% Calcul des courbes f(x0 + alpha*d)
 	f_alpha1 = arrayfun(@(a) f(x0 + a*d1), alpha);
 	f_alpha2 = arrayfun(@(a) f(x0 + a*d2), alpha);
 	
 	% Valeurs pour les droites tangentes
 	L1_d1 = f0_val + alpha * gTd1;
 	L1_d2 = f0_val + alpha * gTd2;
 	
 	% Boucle sur les deux valeurs de beta1
 	beta_vals = [0.5, 0.1];
 	
 	for i = 1:length(beta_vals)
 	beta1 = beta_vals(i);
 	
 	% Droites d'Armijo
 	Armijo_d1 = f0_val + beta1 * alpha * gTd1;
 	Armijo_d2 = f0_val + beta1 * alpha * gTd2;
 	
 	% Figure pour cette beta1
 	figure;
 	
 	% Sous-figure pour d1
 	subplot(1,2,1);
 	plot(alpha, f_alpha1, 'b-', 'LineWidth', 1.5);
 	hold on;
 	plot(alpha, L1_d1, 'r--', 'LineWidth', 1.2);
 	plot(alpha, Armijo_d1, 'g--', 'LineWidth', 1.2);
 	xlabel('\alpha');
 	ylabel('f_0(x_0 + \alpha d_1)');
 	title(['d_1, \beta_1 = ' num2str(beta1)]);
 	legend('f_0(x_0+\alpha d_1)', 'Tangente', 'Armijo', 'Location', 'best');
 	grid on;
 	
 	% Sous-figure pour d2
 	subplot(1,2,2);
 	plot(alpha, f_alpha2, 'b-', 'LineWidth', 1.5);
 	hold on;
 	plot(alpha, L1_d2, 'r--', 'LineWidth', 1.2);
 	plot(alpha, Armijo_d2, 'g--', 'LineWidth', 1.2);
 	xlabel('\alpha');
 	ylabel('f_0(x_0 + \alpha d_2)');
 	title(['d_2, \beta_1 = ' num2str(beta1)]);
 	legend('f_0(x_0+\alpha d_2)', 'Tangente', 'Armijo', 'Location', 'best');
 	grid on;
 	end