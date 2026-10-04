		function [f,g,h] = simf0_2(x)
		% x est un vecteur colonne [x1; x2]
		
		f = 0.5*x(1)^2 + 4.5*x(2)^2;
		g = [x(1); 9*x(2)];
		h = [1 0; 0 9];
		
		end