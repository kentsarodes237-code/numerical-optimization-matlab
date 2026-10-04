    function h = calculeh(X, a)
  % X : matrice 2 x n, chaque colonne est [x_i ; y_i]
  % a : vecteur colonne [a1; a2; a3; a4]
  
  x = X(1,:)';
  y = X(2,:)';
  
  a1 = a(1);
  a2 = a(2);
  a3 = a(3);
  a4 = a(4);
  
  h = a1 + a2*exp(-a4*(x-a3).^2) - y;
  end