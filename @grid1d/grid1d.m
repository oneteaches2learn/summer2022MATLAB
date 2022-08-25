classdef grid1d
%GRID1D A 1d grid object spanning interval (Ia, Ib) using n-many points.
%   Grid points may be spaced uniformly or randomly throughout the
%   interval.
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CONSTRUCTOR
%   Constructor calls can take the forms:
%       (1) GRID1D
%       (2) GRID1D(Ia,Ib,n)
%       (3) GRID1D(Ia,Ib,n,h)
%       (4) GRID1D(Ia,Ib,n,tol1,tol2)
%       (5) GRID1D(Ia,Ib,n,tol1,tol2,h)
%   where Ia and Ib are the bounds of the interval, n is the number of
%   grid points in the interval, h is the desired mesh size and tol1/tol2
%   are bounds on the step size. 
%
%   These calls yeild the following results:
%       (1) Property defaults are used. A uniform grid with n = 11 and 
%            h = .1 spans interval (0,1) is created.
%       (2) A uniform grid spanning inveral (Ia,Ib) with n points.
%       (3) A random grid with largest step size h is created.
%       (4) A random grid with step sizes between tol1 and tol2 is created.
%       (5) A random grid is created with step sizes bounded below by the 
%            smaller of tol1 and tol2 and bounded above by h, and with
%            largest step size equal to h.
%   Note that for case (5), the algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

properties
    % grid dimensions
    % lowerBound comment hi dude
    grid        = [0:.1:1]
    lowerBound  = 0
    upperBound  = 1
    length      = 1
    stepNumber  = 10
    pointNumber = 11

    % mesh properties
    meshSize           = .1
    meshLowerTolerance = .05;
    meshUpperTolerance = .1;
end

methods
    function obj = grid1d(Ia,Ib,n,varargin)
    

    if nargin > 0
        % check that required arguments have been passed
        if nargin < 3
            error 'At least three inputs required: lowerBound, upperBound, pointNumber'

        else
            % check validity of required arguments
            if Ib < Ia
                error 'lowerBound must be less than upperBound'
            end
            if n < 2
                error 'pointNumber must be at least 2'
            end
            
            % assign required arguments
            obj.lowerBound  = Ia;
            obj.upperBound  = Ib;
            obj.pointNumber = n;

            % compute additional properties from required properties
            obj.length     = Ib - Ia;
            obj.stepNumber = n - 1;

            % delete preset grid, mesh size, and mesh tolerances
            obj.grid = [];
            obj.meshSize = [];
            obj.meshUpperTolerance = [];
            obj.meshLowerTolerance = [];
        end

        % if only three arguments are passed, create a uniform grid
        if nargin < 4
            obj.grid = linspace(Ia,Ib,n);
            dx = diff(obj.grid);
            obj.meshSize = dx(1);
        end

        % if 4 arguments passed, generate random grid with mesh size = arg4
        if nargin == 4
            obj.meshSize = varargin{1};
            obj = obj.generaterandomgrid;
        end
        
        % if >4 arguments passed, arg4/5 interpretted as tolerances
        if nargin > 4
            if varargin{1} < varargin{2}
                obj.meshLowerTolerance = varargin{1};
                obj.meshUpperTolerance = varargin{2};
            else
                obj.meshLowerTolerance = varargin{2};
                obj.meshUpperTolerance = varargin{1};
            end
            
            % if 6 arguments passed, arg4/5 are tolerances, arg6 is mesh size
            if nargin == 6
                obj.meshSize = varargin{3};
            end

            % generate random grid with desird properties
            obj = obj.generaterandomgrid;
        end
    end
    end
    
    %function obj = grid1d(mesh)
    
    %end

    function outputArg = method1(obj,inputArg)
    %METHOD1 Summary of this method goes here
    %   Detailed explanation goes here
    outputArg = obj.Property1 + inputArg;
    end

    obj = generateuniformgrid(obj)

    obj = generaterandomgrid(obj)

end

end

