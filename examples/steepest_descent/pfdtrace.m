% [xk,k,X] = pfd([9;1],1e-8);
% [x1,x2] = meshgrid(-10:0.1:10,-10:0.1:10);
% f = 0.5*x1.^2 + 4.5*x2.^2;
% 
% figure
% contour(x1,x2,f,20)
% hold on
% plot(X(1,:),X(2,:),'r-','LineWidth',1.5)
% axis equal
% xlabel('x_1')
% ylabel('x_2')
% title('Trajectoire des iteres')

[xk,k,X] = pfd([9;1],1e-8);

[x1,x2] = meshgrid(-10:0.1:10,-10:0.1:10);
f = 0.5*x1.^2 + 4.5*x2.^2;
disp(k);
figure
contour(x1,x2,f,20)
hold on

% trajectoire des itérés
plot(X(1,:),X(2,:),'r-o','LineWidth',1.5,'MarkerSize',4)

% point initial
plot(X(1,1),X(2,1),'ks','MarkerFaceColor','k','MarkerSize',8)

% point final
plot(X(1,end),X(2,end),'go','MarkerFaceColor','g','MarkerSize',8)

axis equal
grid on
xlabel('x_1')
ylabel('x_2')
title('Trajectoire des itérés de la méthode de plus forte descente')
legend('Courbes de niveau de f','Itérés successifs','Point initial','Point final','Location','best')