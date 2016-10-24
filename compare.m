%% Opimization Compare Script
% Author:  Anshul Kharbanda
% Created: 10 - 24 - 2016
%
% Compares two optimization algorithms, plotting both paths through 
% a curve and changes in minimum value over time.

%% Section 1: Optimizers

% Optimizer 1
opters(1).name = 'Batch Gradient Descent';
opters(1).func = @graddescent;

% Optimizer 2
opters(2).name = 'Stochastic Gradient Descent';
opters(2).func = @stochdescent;

% Optimizer 3
opters(3).name = 'Newton''s Method';
opters(3).func = @newton;

%% Section 2: Parameters

% Target function
Z = @(x,y) 0.5 * (2*x.^4 - 2*x.^2 + 0.5*x.*y + 2*y.^2);

% Minimize wrapper
f = @(x) Z(x(:,1), x(:,2));
n = 2;

% Algorithm Parameters
alpha   = 1e-3;
epsilon = 1e-9;
start   = [-0.45,0.8];
sample  = 200;

%% Section 2: Execute

% Cell Array of Parameters
params = {f, n, start, ...
    'alpha', alpha, 'epsilon', epsilon, 'sample', sample};

% For each optimizer
for i = 1:length(opters)
    % Get minimum, path, and iterations
    [opters(i).xmin, opters(i).path, opters(i).iter] = ...
        opters(i).func(params{:});
    
    % Display iterations, minimum x, and minimum f
    disp(opters(i).name);
    disp(['    iterations: ' num2str(opters(i).iter)]);
    disp(['    xmin: '       num2str(opters(i).xmin)]);
    disp(['    fmin: '       num2str(f(opters(i).xmin))]);
end

%% Section 3: Plot

% Value Space
[X,Y] = meshgrid(-1:0.01:1);

% Plot target function (and paths)
figure(1);hold on;
% Contour Map
contour(X,Y,Z(X,Y),50);
% Paths for each optimizer
for opter = opters; plot(opter.path(:,1),opter.path(:,2),'.'); end
hold off;
% Graph info
title('Objective Function with Optimizer Path');
legend('Function',opters(:).name);

% Plot change in f over samples
figure(2); hold on;
% Paths for each optimizer
for opter = opters; plot(f(opter.path),'.'); end
hold off;
title('Value of Objective Function over Samples');
xlabel(['Samples (1 per ', num2str(sample), ' iterations)']);
ylabel('Objective Function');
legend(opters(:).name);