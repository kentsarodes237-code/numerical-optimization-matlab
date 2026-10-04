  
   function J = calculeDh(X, a)
  % J : Jacobienne de h, de taille n x 4
  
  x = X(1,:)';
  
  a2 = a(2);
  a3 = a(3);
  a4 = a(4);
  
  E = exp(-a4*(x-a3).^2);
  
  J = zeros(length(x),4);
  
  J(:,1) = 1;
  J(:,2) = E;
  J(:,3) = 2*a2*a4*(x-a3).*E;
  J(:,4) = -a2*(x-a3).^2.*E;
   end