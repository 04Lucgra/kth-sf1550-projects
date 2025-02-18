%% 1a - plotta f(x)

figure(1)

x = -10:.001:10;
y = func1(x);

plot(x, y);





%% 1b - fixpunktiterationer

format long

num_to_check = [1.81, 2.17, 3.44, 5.27, 5.77, 4.08];
error_margin = 10^(-10);

for num = num_to_check
    iteration_array = fixpoint(num, error_margin);
    disp(['Starting Point: ', num2str(num), '   Total Iterations: ', num2str(length(iteration_array)-1, '%.11g'), '    Approximate root: ', num2str(iteration_array(end), '%.11g')]);
end

fprintf('\nLast 10 |xn+1 - xn| values for starting point 5.77:\n')

for element = iteration_array(end-10:end)
    disp(element)
end






%% 1c - Newton

format long

for num = num_to_check
    iteration_array = newton(num, error_margin);
    disp(['Starting Point: ', num2str(num), '   Total Iterations: ', num2str(length(iteration_array)-1, '%.11g'), '    Approximate root: ', num2str(iteration_array(end), '%.11g')]);
end

fprintf('\n|xn+1 - xn| values for starting point 4.08:\n')

for element = iteration_array
    disp(element)
end





%% 1d - konvergensplottar

figure(2)

reference_x = newton(1.81, 10^(-16));
reference_x = reference_x(end);
% Reference Value of x: 1.815260247632966


e_newton_array = newton(1.81, 0.5*10^(-15));
e_fixpoint_array = fixpoint(1.81, 0.5*10^(-15));

semilogy(0:length(e_newton_array)-1, abs(e_newton_array-reference_x), '-o');
hold on;
semilogy(0:length(e_fixpoint_array)-1, abs(e_fixpoint_array-reference_x), '-o');

xlabel('Iteration Number');
ylabel('Error');

figure(3)

e_newton_array_n = e_newton_array(1:end-1);
e_fixpoint_array_n = e_fixpoint_array(1:end-1);

e_newton_array_n1 = e_newton_array(2:end);
e_fixpoint_array_n1 = e_fixpoint_array(2:end);

loglog(abs(e_newton_array_n-reference_x), abs(e_newton_array_n1-reference_x), '-o');
hold on;
loglog(abs(e_fixpoint_array_n-reference_x), abs(e_fixpoint_array_n1-reference_x), '-o');

xlabel('e_n');
ylabel('e_{n+1}');





%%%% FUNCTIONS

function y = func1(x)
    y = x.^2 - (8 * x) - 10 * sin( (3.5 * x) + 1) + 20;
end

function y = func1_derivative(x)
    y = 2*x - 8  - 35 * cos( (3.5 * x) + 1);
end

function xit = fixpoint(x0,tau)

    max_iter = 1000;
    xit = x0;
    xn = x0;
    iter = 1;

    while abs(func1(xn)) > tau && max_iter > iter
        xn = 0.05 * (xn.^2 + (12*xn) - (10 * sin((3.5 * xn) + 1 ))) + 1;
        xit = [xit, xn];
        iter = iter + 1;
    end
end

function xit = newton(x0,tau)

    max_iter = 1000;
    xit = x0;
    xn = x0;
    iter = 1;

    while abs(func1(xn)) > tau && max_iter > iter
        xn = xn - (func1(xn)/func1_derivative(xn));
        xit = [xit, xn];
        iter = iter + 1;
    end
end