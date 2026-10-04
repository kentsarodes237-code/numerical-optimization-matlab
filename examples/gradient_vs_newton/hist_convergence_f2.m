clear; clc; close all;

X0 = [ 1.5  -1.5   0.8 ;
      -1.5   1.0  -0.5 ];

for j = 1:size(X0,2)
    x0 = X0(:,j);

    [~, ~, Xg, ~] = gradrl_gen('simf2_2', x0, 1e-8);
    [~, ~, ~, Xn] = newton_loc('simf2_2', x0, 1e-8, 100);

    Ng = size(Xg,2);
    fg = zeros(1,Ng);
    ng = zeros(1,Ng);
    for i = 1:Ng
        [fval, gval, ~] = simf2_2(Xg(:,i));
        fg(i) = fval;
        ng(i) = norm(gval);
    end

    Nn = size(Xn,2);
    fn_hist = zeros(1,Nn);
    nn = zeros(1,Nn);
    for i = 1:Nn
        [fval, gval, ~] = simf2_2(Xn(:,i));
        fn_hist(i) = fval;
        nn(i) = norm(gval);
    end

    figure
    subplot(2,1,1)
    semilogy(0:Ng-1, fg, 'r-o', 'LineWidth', 1.2, 'MarkerSize', 4)
    hold on
    semilogy(0:Nn-1, fn_hist, 'b-s', 'LineWidth', 1.2, 'MarkerSize', 4)
    grid on
    xlabel('k')
    ylabel('f(x_k)')
    title(sprintf('f_2 : f(x_k), x_0=(%.2f, %.2f)',x0(1),x0(2)))
    legend('Gradient','Newton','Location','best')

    subplot(2,1,2)
    semilogy(0:Ng-1, ng, 'r-o', 'LineWidth', 1.2, 'MarkerSize', 4)
    hold on
    semilogy(0:Nn-1, nn, 'b-s', 'LineWidth', 1.2, 'MarkerSize', 4)
    grid on
    xlabel('k')
    ylabel('||\nabla f(x_k)||')
    title('Evolution de ||\nabla f(x_k)||')
    legend('Gradient','Newton','Location','best')
end
