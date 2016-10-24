function H = hessian( f, x, h1, h2 )
%HESSIAN The hessian matrix of the function f
%
%   H = HESSIAN(f, x) 
%       computes the hessian matrix of the function f at the input x. 
%       (h1 defaults to 1e-3. h2 defaults to h1^2)
%
%   H = HESSIAN(f, x, h1) 
%       computes the hessian matrix of the function f at the input x using
%       the given h1. (h2 defualts to h1^2)
%
%   H = HESSIAN(f, x, h1, h2)
%       computes the hessian matrix of the function f at the input x using
%       the given h1 and h2
%
%   Parameters:
%       f:  The function to compute the hessian matrix of
%       x:  The input value to compute the hessian at
%       h1: The first delta change (used by gradient)
%       h2: The second delta change (used by hessian)

% Default arguments
if nargin < 3; h1 = 1e-3; end
if nargin < 4; h2 = h1^2; end

% Create X and D matrices (point and change value)
X =      meshgrid(x);
D = h2 * eye(length(x));

% Compute Hessian (gradient per row)
H = (grad(f,X+D,h1) - grad(f,X,h1))/h2;

end

