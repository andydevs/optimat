function [xmin,path,iter] = stochdescent( f, n, varargin )
%STOCHDESCENT Stochastic Gradient Descent minimization algorithm
%   xmin = STOCHDESCENT(f, n, ....) 
%       computes the mininum of the function f with ninp amount of inputs
%       using the given parameters
%
%   xmin = STOCHDESCENT(f, n, start, ....)
%       computes the mininum of the function f with ninp amount of inputs
%       using the given parameters, and starting at the given start point.
%
%   [xmin,path] = STOCHDESCENT(f, ninp, ....)
%       computes the minimum using the given arguments and stores the path 
%       traveled in the path variable
%
%   [xmin,path,iter] = STOCHDESCENT(f, ninp, ...)
%       computes the minimum using the given arguments, stores the path 
%       traveled in the path variable, and returns the number of iterations
%       made.
%
%   Parameters:
%       alpha:   The learning rate or step size   (default: 1e-3)
%       epsilon: The zero treshold                (default: 1e-6)
%       sample:  The time between path samples    (default: 100)
%       maxiter: The maximum number of iterations (default: 100000)
%
%   Example:
%       f = @(x) 0.5 * (x(:,1).^2 + x(:,2).^2);
%       xmin = STOCHDESCENT(f,2);
%
%   Example (plot using a wrapper function):
%       Z = @(x,y) 0.5 * ( x.^2 + y.^2 );
%
%       f = @(x) Z(x(:,1),x(:,2)); 
%       [xmin, path] = STOCHDESCENT(f,2);
%
%       [X,Y] = meshgrid(-10:10);
%       contour(X,Y,Z(X,Y)); hold on;
%       plot(path(:,1),path(:,2)); hold off;
%
%   Example (with parameters and a starting location):
%       f = @(x) 0.5 * (x(:,1).^4 + x(:,1).^2 + x(:,2).^2);
%       xmin = STOCHDESCENT(f,2,[0,0],'alpha',1e-4,'epsilon',1e-9)

% Init input parser
p = inputParser;

% Is positive checker
isposnumber = @(x) isnumeric(x) && x > 0;

% Set parameters
addRequired(p, 'f');
addRequired(p, 'n',                  @isnumeric);
addOptional(p, 'start',   rand(1,n), @isnumeric);
addParameter(p,'alpha',   1e-3,      @isnumeric);
addParameter(p,'delta',   1e-6,      @isnumeric);
addParameter(p,'epsilon', 1e-6,      @isnumeric);
addParameter(p,'sample',  100,       @isnumeric);
addParameter(p,'maxiter', 100000,    isposnumber);

% Parse it!
parse(p,f,n,varargin{:});

% Get algorithm parameters
f       = p.Results.f;
n       = p.Results.n;
alpha   = p.Results.alpha;
epsilon = p.Results.epsilon;
sample  = p.Results.sample;
maxiter = p.Results.maxiter;

% Initialize algorithm
xmin = p.Results.start; % Initial xmin
g    = grad(f,xmin);    % Initial gradient
delt = epsilon + 1;
path = xmin;            % Start path
iter = 0;               % Iteration

% Until slope becomes level
while delt > epsilon && iter < maxiter
    % Step in negative
    delt                  = alpha*g(mod(iter,n) + 1);
    xmin(mod(iter,n) + 1) = xmin(mod(iter,n) + 1) - delt;
    
    % Increment iter
    iter = iter + 1;
    
    % Recalculate gradient if iterated through all directions
    if mod(iter,n) == 0; g = grad(f,xmin); end;
    
    % Add xmin sample to path if sample time has passed
    if mod(iter,sample) == 0; path = [path; xmin]; end
end



end

