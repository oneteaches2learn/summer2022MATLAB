classdef poissonFEM1d
%POISSONFEM1d Summary of this class goes here
%   Detailed explanation goes here
    
properties

end

methods
    function obj = poissonFEM1d
        %POISSONFEM Construct an instance of this class
    end
    
    S = generatestiffnessmatrix(obj,grid)

    q = generaterhs(obj,grid,fxn)

    function U = solve(obj,problem)
        %parameters
        grid = problem.domainGrid;
        fxn  = problem.source;
        m    = length(grid);

        % instantiate solution vector
        U = zeros(1,length(grid));
        
        % generate stiffness matrix and rhs vector
        S = generatestiffnessmatrix(obj,grid);
        q = generaterhs(obj,grid,fxn);
        
        % solve and store solution
        xsoln = S \ q';
        U(2:m-1) = xsoln';
    end
    
end

end
