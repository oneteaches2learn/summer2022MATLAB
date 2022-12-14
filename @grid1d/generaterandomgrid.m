function obj = generaterandomgrid(obj)
%GENERATERANDOMGRID(obj) replaces the grid property with a randomly 
%   generated grid. 
%
%   GENERATERANDOMGRID uses either the stored pointNumber property or the 
%   stored stepNumber property to determine the number of grid points.
%   
%   If the meshUpperTolerance and meshLowerTolerance properties are
%   preset, then the grid step size will fall within these values.
%   If the domainMeshSize property is pre-set, then the grid will 
%   contain at least one interval of that length and domainMeshSize 
%   will be used as the upper tolerance.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% store interval end points
if ~isempty(obj.lowerBound) && ~isempty(obj.upperBound)
    Ia = obj.lowerBound;
    Ib = obj.upperBound;
else
    error 'Set lowerBound and/or upperBound'
end

% determine desired number of grid points
if ~isempty(obj.pointNumber)
    n  = obj.pointNumber;
    obj.stepNumber = n-1;
elseif ~isempty(obj.stepNumber)
    n = obj.stepNumber + 1;
    obj.stepNumber = n;
else
    error 'Set either stepNumber or pointNumber';
end

% set upper step size tolerance
if ~isempty(obj.meshUpperTolerance)
    upperTolerance = obj.meshUpperTolerance;
else
    upperTolerance = obj.length;
end

% set lower step size tolerance
if ~isempty(obj.meshLowerTolerance)
    lowerTolerance = obj.meshLowerTolerance;
else
    lowerTolerance = 0;
end

% set mesh size
if ~isempty(obj.meshSize)
    meshSize = obj.meshSize;
else
    meshSize = [];
end

% create random grid object and generate random grid
grid = randomGrid(Ia,Ib,n,upperTolerance,lowerTolerance,meshSize);
grid = grid.generaterandomgrid;

% update stationary 1d problem with random grid
obj.grid = grid.grid;

% if domainMeshSize isn't pre-set, update domainMeshSize
if isempty(obj.meshSize)
    obj.meshSize = grid.meshSize;
end

