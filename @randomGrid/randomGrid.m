classdef randomGrid
    %XGRID Generates a one dimensional grid
    %   Detailed explanation goes here

    properties
        meshSize
        meshUpperTolerance
        meshLowerTolerance
        grid
        gridLowerBound
        gridUpperBound
        gridLength
        gridStepNumber
        gridPointNumber
    end

    methods
        function obj = randomGrid(Ia,Ib,n,upperTolerance,lowerTolerance,meshSize)
            %RANDOMGRID(Ia,Ib,n,upperTolerance,lowerTolerance,meshSize)
            %   constructs an instance of this class.
            %   
            %   Variables Ia and Ib represent the end points of the grid.
            %   Variable n is the desired number of grid points. 
            % 
            %   Variables upperTolerance and lowerTolerance are optional 
            %   and represent the upper and lower bounds on grid step size.
            %   if only one tolerance value is passed, the constructor
            %   assumes it is an upperTolerance. If both tolerances are
            %   passed, they can be passed in either order. 
            %
            %   Variable meshSize is optional and represents a target
            %   meshSize. If meshSize is passed, then the upper tolerance
            %   for grid step size will automatically be set equal to
            %   meshSize. 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if nargin > 1
                % assign required properties    
                obj.gridLowerBound     = Ia;
                obj.gridUpperBound     = Ib;
                obj.gridPointNumber    = n;          
                
                % assign optional properties
                if nargin > 3
                    obj.meshUpperTolerance = upperTolerance;
                end
                if nargin > 4
                    obj.meshLowerTolerance = lowerTolerance;
                end
                if nargin > 5
                    obj.meshSize = meshSize;
                end

                % check order of upper and lower tolerances
                if nargin > 4
                    if upperTolerance < lowerTolerance
                        temp = obj.meshUpperTolerance;
                        obj.meshUpperTolerance = obj.meshLowerTolerance;
                        obj.meshLowerTolerance = temp;
                    end
                end

                % compute additional properties
                obj.gridLength             = Ib - Ia;
                obj.gridStepNumber         = obj.gridPointNumber - 1;

                % set upper tolerance as mesh size, if available
                if nargin > 5
                    obj.meshUpperTolerance = obj.meshSize;
                end
            end
        end

        obj = generaterandomgrid(obj);

        function obj = clearmeshsize(obj)
            obj.meshSize = [];
        end
    end
end