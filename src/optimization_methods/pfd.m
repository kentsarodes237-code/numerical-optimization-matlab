function [x_k,k,X] = pfd(x_0,epsrel)
%PFD Methode de plus forte descente avec pas optimal pour f0.
%   Point de depart recommande dans le TP : x0 = [9;1].

x_k = x_0;
k = 0;
[~,g] = simf0(x_k);
g0 = norm(g);
X = x_k;

% Hessienne constante de f0(x) = 1/2*x1^2 + 9/2*x2^2
H = [1 0; 0 9];

while norm(g) > epsrel*g0
    d = -g;
    alpha = (g'*g)/(g'*H*g);
    x_k = x_k + alpha*d;
    [~,g] = simf0(x_k);
    X = [X x_k]; %#ok<AGROW>
    k = k + 1;
end
end
