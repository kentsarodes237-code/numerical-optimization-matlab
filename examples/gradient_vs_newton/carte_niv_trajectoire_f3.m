clear; clc; close all;

% Exercice 17 : comparaison sur plusieurs points de depart
% Le premier point est celui suggere dans l'enonce.
X0 = [-1.5  -1.2   0.0 ;
      -1.5   1.0   1.5 ];

nTests = size(X0,2);
iter_grad = zeros(nTests,1);
iter_newton = zeros(nTests,1);

[x1,x2] = meshgrid(-2:0.05:2, -2:0.05:3);
F = (1-x1).^2 + 100*(x2 - x1.^2).^2;

for j = 1:nTests
    x0 = X0(:,j);

    [~, kg, Xg, ~] = gradrl_gen('simf3_2', x0, 1e-8);
    [~, ~, kn, Xn] = newton_loc('simf3_2', x0, 1e-8, 200);

    iter_grad(j) = kg;
    iter_newton(j) = kn;

    figure
    contour(x1,x2,F,30)
    hold on
    plot(Xg(1,:),Xg(2,:),'r-o','LineWidth',1.2,'MarkerSize',4)
    plot(Xn(1,:),Xn(2,:),'b-s','LineWidth',1.2,'MarkerSize',4)
    plot(x0(1),x0(2),'ks','MarkerFaceColor','k')
    plot(1,1,'gp','MarkerFaceColor','g','MarkerSize',10)
    grid on
    xlabel('x_1')
    ylabel('x_2')
    title(sprintf('f_3 : trajectoires depuis x_0=(%.2f, %.2f)',x0(1),x0(2)))
    legend('Courbes de niveau','Gradient','Newton','Point initial','Minimum','Location','best')
end

Resultats_f3 = table(X0(1,:)', X0(2,:)', iter_grad, iter_newton, ...
    'VariableNames', {'x0_1','x0_2','iterations_gradient','iterations_newton'});
disp('Comparaison multi-points de depart pour f_3 :');
disp(Resultats_f3);
