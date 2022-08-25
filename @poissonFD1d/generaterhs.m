function q = generaterhs(obj,grid,fxn)
%GENERATERHS(obj,grid,fxn) computes the RHS vector for a 1D poisson problem
%   solved using a centered in space finite difference method.
%
%   GENERATERHS is an overloaded function, so the obj input tells the
%   compiler which version of this function to call.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set variables
x  = grid;
m  = length(x)-1;
f  = fxn(x(2:m));

% output vector simply is the function evaluated at interior grid points
q = f;

end

