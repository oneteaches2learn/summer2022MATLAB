function obj = generateuniformgrid(obj)
%GENERATEUNIFORMGRID(obj) replaces the grid property with a uniform grid.
% 
%   The new grid is created by dividing the interval defined by the
%   lowerBound and upperBound properties using the value stored in the 
%   meshSize property.
%
%   GENERATEUNIFORMGRID will overwrite the stepNumber and pointNumber 
%   properties with new values based on the generated grid.
%
%   The stored meshSize property may not be compatible with length of the 
%   interval in that the desired mesh size may not evenly divide the 
%   interval. In this case, GENERATEUNIFORMGRID will round up the current 
%   mesh size to the nearest value that divides the interval. Then 
%   GENERATEUNIFORMGRID will overwrite the stored meshSize property.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% store interval end points
if ~isempty(obj.lowerBound) && ~isempty(obj.upperBound)
    Ia = obj.lowerBound;
    Ib = obj.upperBound;
else
    error 'Set lowerBound and/or upperBound for grid.'
end

% round step-size to be compatible with end points; update object data 
n = floor(obj.length/obj.meshSize);
obj.stepNumber    = n;
obj.pointNumber   = n+1;
dx = obj.length/obj.stepNumber;
obj.meshSize      = dx;

% compute uniform grid          
obj.grid = [Ia:dx:Ib];

obj = obj;
end
