function S = generatestiffnessmatrix(obj,grid)
%GENERATESTIFFNESSMATRIX(obj,grid) computes the stiffness matrix for a
%   1d poisson problem solved using the nodal finite element method. 
%
%   GENERATESTIFFNESSMATRIX is an overloaded function, thus the input obj
%   tells the compiler which type of problem is being solved, and therefore 
%   which version of this function to use.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% VARIABLES
m = length(grid)-2;

% STIFFNESS MATRIX
% Inverval lengths and inverses
dx    = diff(grid);
dxInv = 1./dx;

% Main diagonal
mainDiag = dxInv(1:m) + dxInv(2:m+1);

% Off diagonal
offDiag  = -dxInv(2:m);

% Stiffness matrix
S = sparse(diag(mainDiag,0) + diag(offDiag,1) + diag(offDiag,-1));

end

