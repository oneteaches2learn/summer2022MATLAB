classdef stationary1dProblem
    
    properties
        % Domain 
        domainMeshSize      =   .1
        domainGrid          =   [0:.1:1]
        domainLowerBound    =   0
        domainUpperBound    =   1
        domainLength        =   1
        domainStepNumber    =   10
        domainPointNumber   =   11

        % Boundary Conditions
        bcLeftEdge          =   0
        bcRightEdge         =   0

        % Additional Parameters
        meshUpperTolerance  =   .2
        meshLowerTolerance  =   .05  

        % Source Equation
        source              =   @(x)(pi^2 * sin(pi*x))

        % Solver
        solver

        % Storage for Results
        result
    end


    methods
        % constructor
        function obj = stationary1dProblem(m,L,ua,ub)
            if nargin > 0
                % pass given inputs
                obj.domainStepCount         = m;
                obj.domainLength            = L;
                obj.bcLeftEdge              = ua;
                obj.bcRightEdge             = ub;

                % compute remaining DOMAIN terms
                obj.domainMeshSize      =   L/m;
                obj.domainUpperBound    =   L;
                obj.domainGrid          =   (obj.domainLowerBound:obj.domainMeshSize:obj.domainUpperBound)';
                obj.domainGridPtCount   =   length(obj.domainGrid);        
            end
        end
    
        % setters
        function obj = setmeshsize(obj,meshSize)
            n = floor(obj.domainLength/meshSize);
            obj.domainStepNumber = n;
            obj.domainMeshSize      = obj.domainLength/obj.domainStepNumber;
            obj.domainGrid          = [obj.domainLowerBound:obj.dx:obj.domainUpperBound];
            obj.domainPointNumber   = length(obj.domainGrid);
        end

        
        % actions
        obj = generateuniformgrid(obj)
        
        obj = generaterandomgrid(obj)
        
        function obj = solve(obj)
            obj.result = obj.solver.solve(obj);
        end

    end
end

