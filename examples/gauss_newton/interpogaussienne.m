  function a = interpogaussienne(X, a0)
  
  a = a0(:);
  maxiter = 100;
  tol = 1e-8;
  rho = 0.1;
  
  for k = 1:maxiter
  h = calculeh(X, a);
  J = calculeDh(X, a);
  
  % Direction de Gauss-Newton
  d = -((J' * J) \ (J' * h));
  
  % Mise a jour
  anew = a + rho*d;
  
  % Verification de a4
  if anew(4) <= 0
  warning('Le parametre a4 devient non positif.');
  break;
  end
  
  % Critere d'arret
  if norm(anew - a) <= tol*(1 + norm(a))
  a = anew;
  break;
  end
  
  a = anew;
  end
  
  % Trace du resultat
  x = X(1,:);
  y = X(2,:);
  
  xx = linspace(min(x), max(x), 400);
  yy = a(1) + a(2)*exp(-a(4)*(xx-a(3)).^2);
  
  figure;
  plot(x, y, 'bo', 'MarkerFaceColor', 'b');
  hold on;
  plot(xx, yy, 'r-', 'LineWidth', 2);
  grid on;
  xlabel('x');
  ylabel('y');
  legend('Donnees', 'Gaussienne ajustee');
  title('Ajustement de la gaussienne par la methode de Gauss-Newton');
  
  end