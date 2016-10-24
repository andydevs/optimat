%% Opimization Test Script
% Author:  Anshul Kharbanda
% Created: 10 - 24 - 2016
%
% Tests an optimization algorithm, plotting the path through a curve and
% change in minimum value over time.

%% Section 1: Parameters

% Optimizer
opter.name = 'Newton''s Method';
opter.func = @newton;

% Target function
Z = @(x,y) 0.5 * (2*x.^4 - 2*x.^2 + 0.5*x.*y + 2*y.^2);

% Minimize wrapper
f = @(x) Z(x(:,1), x(:,2));
n = 2;

% Algorithm Parameters
alpha   = 1e-3;
epsilon = 1e-9;
start   = [-0.45,0.8];
sample  = 100;

% Cell Array of Parameters
params = {f, n, start, ...
    'alpha', alpha, 'epsilon', epsilon, 'sample', sample};

%% Section 2: Execute and Plot

% Get minimum and path
[opter.xmin, opter.path, opter.iter] = opter.func(params{:});

% Display minimum x
disp(['iterations: ' num2str(opter.iter)]);
disp(['xmin: '       num2str(opter.xmin)]);
disp(['fmin: '       num2str(f(opter.xmin))]);

% Plot target function (and path)
[X,Y] = meshgrid(-1:0.01:1);
figure(1);
contour(X,Y,Z(X,Y),50);hold on;
plot(opter.path(:,1),opter.path(:,2),'.');hold off;
title('Objective Function with Optimizer Path');
legend('Function','Optimizer Path');

% Plot change in f over samples
figure(2);
plot(f(opter.path),'r');
title('Value of Objective Function over Samples');
xlabel(['Samples (1 per ', num2str(sample), ' iterations)']);
ylabel('Objective Function');