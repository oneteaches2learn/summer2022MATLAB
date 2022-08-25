function q = generaterhs(obj,grid,fxn)
%GENERATERHS(obj,grid,fxn) computes the RHS vector for a 1D poisson problem
%   solved using a nodal finite element method.
%
%   GENERATERHS is an overloaded function, so the obj input tells the
%   compiler which version of this function to call.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set variables
x  = grid;
m  = length(x)-1;
f  = fxn(x(2:m));

% compute output as vector of areas of triangles
q = .5*(x(3:m+1) - x(1:m-1)) .* f;

end

