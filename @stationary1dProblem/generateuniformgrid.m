function obj = generateuniformgrid(obj)
%GENERATEUNIFORMGRID(obj) replaces the domainGrid property with a
%   uniform grid.
% 
%   The new grid is created by dividing the interval defined by 
%   domainLowerBound and domainUpperBound using the value stored in
%   domainMeshSize.
%
%   GENERATEUNIFORMGRID will overwrite the domainStepNumber and
%   domainPointNumber properties with new values based on the
%   generated grid.
%
%   The stored domainMeshSize property may not be compatible with
%   the domainLowerBound and domainUpperBound properties in that 
%   the desired mesh size may not evenly divide the interval
%   defined by these upper and lower bounds. In this case,
%   GENERATEUNIFORMGRID will round up the current mesh size to the 
%   nearest value that divides the interval. Then
%   GENERATEUNIFORMGRID will overwrite the stored domainMeshSize
%   property.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% store interval end points
if ~isempty(obj.domainLowerBound) && ~isempty(obj.domainUpperBound)
    Ia = obj.domainLowerBound;
    Ib = obj.domainUpperBound;
else
    error 'Set domainLowerBound and/or domainUpperBound'
end

% round step-size to be compatible with end points and
% update object data 
n = floor(obj.domainLength/obj.domainMeshSize);
obj.domainStepNumber    = n;
obj.domainPointNumber   = n+1;
dx = obj.domainLength/obj.domainStepNumber;
obj.domainMeshSize      = dx;

% compute uniform grid          
obj.domainGrid = [Ia:dx:Ib];
end
