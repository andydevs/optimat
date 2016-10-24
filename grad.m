function G = grad(f, x, h)
%GRAD The gradient of a function at an x
%   G = GRAD(f,x) 
%       computes the gradient of the given function at the given x
%       (h defaults to 1e-3)
% 
%   G = GRAD(f,x,h) 
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

% Init gradient and D matrix
G = zeros(size(x));
D = h*eye(size(x,2));

for i = 1:size(x,1)
    % Create meshgrid of X
    X = meshgrid(x(i,:));
    
    % Compute gradient by summation
    G(i,:) = (f(X+D) - f(X))'/h;
end

end

