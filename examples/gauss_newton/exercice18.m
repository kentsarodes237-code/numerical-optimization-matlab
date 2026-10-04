
  
   
   
  n = 100; 
X = [linspace(-5, 5, n) ; zeros(1, n)]; % Matrice 2 x n 
  a = [0; 1; 0; 0.5];
  d = randn(4,1);
  
  eps_list = 10.^(-(1:12));
  err = zeros(size(eps_list));
  
  for k = 1:length(eps_list)
  epsi = eps_list(k);
  
  v1 = (calculeh(X, a + epsi*d) - calculeh(X, a))/epsi;
  v2 = calculeDh(X, a)*d;
  
  err(k) = norm(v1 - v2);
  end
  
  loglog(eps_list, err, 'o-');
  grid on;
  xlabel('\epsilon');
  ylabel('Erreur');
  title('Validation numérique de la Jacobienne');
  
   
  
