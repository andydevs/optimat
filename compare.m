%% Opimization Compare Script
% Author:  Anshul Kharbanda
% Created: 10 - 24 - 2016
%
% Compares two optimization algorithms, plotting both paths through a curve 
% and changes in minimum value over time.

%% Section 1: Parameters

% Optimizers
name1      = 'Batch Gradient Descent';
optimizer1 = @graddescent;

name2      = 'Stochastic Gradient Descent';
optimizer2 = @stochdescent;

% Target function
Z = @(x,y) 0.5 * (2*x.^4 - 2*x.^2 + 0.5*x.*y + 2*y.^2);

% Minimize wrapper
f = @(x) Z(x(:,1), x(:,2));
n = 2;

% Algorithm Parameters
alpha   = 1e-3;
epsilon = 1e-9;
start   = [0.1,0.9];
sample  = 100;

%% Section 2: Execute and Plot

% Get minimum and path
[xmin1, path1, iter1] = optimizer1(f,n,start,'alpha',alpha,'epsilon',epsilon,'sample',sample);
[xmin2, path2, iter2] = optimizer2(f,n,start,'alpha',alpha,'epsilon',epsilon,'sample',sample);

% Display data from optimizers
disp(name1);
disp(['  xmin: ' num2str(xmin1)]);
disp(['  iterations: ' num2str(iter1)]);
disp(name2);
disp(['  xmin: ' num2str(xmin2)]);
disp(['  iterations: ' num2str(iter2)]);

% Plot target function (and path)
figure;
[X,Y] = meshgrid(-1:0.01:1);
contour(X,Y,Z(X,Y),50);hold on;
plot(path1(:,1),path1(:,2),'r.');
plot(path2(:,1),path2(:,2),'b.');hold off;
title('Objective Function with Optimizer Paths');
legend('Function',name1,name2);

% Plot change in f over samples
figure;
plot(f(path1),'r');hold on;
plot(f(path2),'b');hold off;
title('Value of Objective Function over Samples');
xlabel(['Samples (1 per ', num2str(sample), ' iterations)']);
ylabel('Objective Function');
legend(name1, name2);