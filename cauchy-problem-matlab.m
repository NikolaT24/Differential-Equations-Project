function solveCauchyProblem()
    clc; close all;

    syms y(x)
    ode = diff(y, x) == (2 / (x^2 - 1)) * y + ((x - 1) / (x + 1)) * cos(x)^4;
    cond = y(0) == 0;

    try
        solY = dsolve(ode, cond);

        solY_func = matlabFunction(solY);

        x_vals = linspace(0.1, 0.9, 100);
        x_vals = [x_vals, linspace(1.1, 5, 200)];

        figure;
        plot(x_vals, solY_func(x_vals), 'LineWidth', 1.5);
        grid on;

        xlabel('x');
        ylabel('y(x)');
        title('Exact Solution of the Cauchy Problem');
        legend('Exact solution', 'Location', 'best');

    catch
        ode_func = @(x, y) (2 / (x^2 - 1)) * y + ((x - 1) / (x + 1)) * cos(x)^4;

        [x1, y1] = ode45(ode_func, [0.1 0.9], 0);
        [x2, y2] = ode45(ode_func, [1.1 5], y1(end));

        x_vals = [x1; x2];
        y_vals = [y1; y2];

        figure;
        plot(x_vals, y_vals, 'LineWidth', 1.5);
        grid on;

        xlabel('x');
        ylabel('y(x)');
        title('Numerical Solution of the Cauchy Problem');
        legend('Numerical solution', 'Location', 'best');
    end
end
