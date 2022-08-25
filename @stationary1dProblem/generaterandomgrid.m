function obj = generaterandomgrid(obj)
%GENERATERANDOMGRID(obj) replaces the domainGrid property with a
%   randomly generated grid. 
%
%   GENERATERANDOMGRID uses either the stored domainPointNumber 
%   property or the stored domainStepNumber property to determine 
%   the number of grid points.
%   
%   If the meshUpperTolerance and meshLowerTolerance properties are
%   preset, then the grid step size will fall within these values.
%   If the domainMeshSize property is pre-set, then the grid will 
%   contain at least one interval of that length and domainMeshSize 
%   will be used as the upper tolerance.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% store interval end points
if ~isempty(obj.domainLowerBound) && ~isempty(obj.domainUpperBound)
    Ia = obj.domainLowerBound;
    Ib = obj.domainUpperBound;
else
    error 'Set domainLowerBound and/or domainUpperBound'
end

% determine desired number of grid points
if ~isempty(obj.domainPointNumber)
    n  = obj.domainPointNumber;
    obj.domainStepNumber = n-1;
elseif ~isempty(obj.domainStepNumber)
    n = obj.domainStepNumber + 1;
    obj.domainStepNumber = n;
else
    error 'Set either domainStepNumber or domainPointNumber';
end

% set upper step size tolerance
if ~isempty(obj.meshUpperTolerance)
    upperTolerance = obj.meshUpperTolerance;
else
    upperTolerance = obj.domainLength;
end

% set lower step size tolerance
if ~isempty(obj.meshLowerTolerance)
    lowerTolerance = obj.meshLowerTolerance;
else
    lowerTolerance = 0;
end

% set mesh size
if ~isempty(obj.domainMeshSize)
    meshSize = obj.domainMeshSize;
else
    meshSize = [];
end

% create random grid object and generate random grid
grid = randomGrid(Ia,Ib,n,upperTolerance,lowerTolerance,meshSize);
grid = grid.generaterandomgrid;

% update stationary 1d problem with random grid
obj.domainGrid = grid.grid;

% if domainMeshSize isn't pre-set, update domainMeshSize
if isempty(obj.domainMeshSize)
    obj.domainMeshSize = grid.meshSize;
end

