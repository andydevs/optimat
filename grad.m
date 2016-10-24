function g = grad(f, x, h)
%GRAD The gradient of a function at an x
%   grad(f,x) computes the gradient of the given function at the given x
%             (h defaults to 0.001)
% 
%   grad(f,x,h) computes the gradient of the given function at the guven x
%               with the given h
%
%   Example:
%       f = @(x) 0.5 * ( x(:,1)^2 + x(:,2)^2 )
%       g = grad(f, [1, 4])
%       % g = [1, 4]

% Default h = 0.001
if (nargin < 3); h = 0.001; end

% Create D and X matrix
D = h*eye(length(x));
X = meshgrid(x);

% Compute all gradients
g = (f(X+D) - f(X))/h;

end

