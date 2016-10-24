function g = grad(f, x, h)
%GRAD The gradient of a function at an x
%   g = GRAD(f,x) 
%       computes the gradient of the given function at the given x
%       (h defaults to 1e-3)
% 
%   g = GRAD(f,x,h) 
%       computes the gradient of the given function at the guven x
%       with the given h
%
%   Parameters:
%       h: The change in x used to compute slopes
%
%   Example:
%       f = @(x) 0.5 * ( x(1)^2 + x(2)^2 )
%       g = GRAD(f, [1, 4])

% Default h = 1e-3
if (nargin < 3); h = 1e-3; end

% Create D and X matrix
D = h*eye(length(x));
X = meshgrid(x);

% Compute all gradients (transpose)
g = ((f(X+D) - f(X))/h)';

end

