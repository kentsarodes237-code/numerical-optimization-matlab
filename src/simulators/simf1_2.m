		function [f,g,h] = simf1_2(x)
		% x est un vecteur colonne [x1; x2]
		
		f = 0.5*x(1)^2 + x(1)*cos(x(2));
		
		g = [x(1) + cos(x(2));
		-x(1)*sin(x(2))];
		
		h = [1, -sin(x(2));
		-sin(x(2)), -x(1)*cos(x(2))];
		
		end