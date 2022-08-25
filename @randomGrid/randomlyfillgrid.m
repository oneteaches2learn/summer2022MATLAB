function obj = randomlyfillgrid(obj)
%RANDOMLYFILLGRID(obj) fills interval (Ia - Ib) with n-many grid points 
%   separated by at most k distance and at least l distance. If mesh size k
%   has been specified, RANDOMLYFILLGRID ensures that one interval has
%   length k.
%
%   version 1       author: Tyler Fara      created: 8/19/22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PARAMETERS
Ia = obj.gridLowerBound;
Ib = obj.gridUpperBound;
n  = obj.gridPointNumber;

% lower tolerance, depends on optional preset lower tolerance
if isempty(obj.meshLowerTolerance)
    lowerTolerance = 0;
else
    lowerTolerance = obj.meshLowerTolerance;
end

% upper tolerance, depends on optional preset upper tolerance and mesh size
if isempty(obj.meshUpperTolerance) && isempty(obj.meshSize)
    upperTolerance = Ib - Ia;
elseif isempty(obj.meshUpperTolerance) && ~isempty(obj.meshSize)
    upperTolerance = obj.meshSize;
else    
    upperTolerance = obj.meshUpperTolerance;
end


% CALL GLOBAL FUNCTION
% if no preset mesh size, generate mesh within tolerance parameters
if isempty(obj.meshSize)
    obj.grid = randomlyfillgrid(Ia,Ib,n,upperTolerance,lowerTolerance);
    obj.meshSize = norm(diff(obj.grid),"inf");

% if mesh size k is preset, ensure one interval has length k 
else
    k        = obj.meshSize;
    x        = zeros(1,n);
    x(1:n-1) = randomlyfillgrid(Ia,Ib-k,n-1,upperTolerance,lowerTolerance);
    x(n)     = Ib;

    % permute intervals so position of k-length interval is random    
    d = diff(x);
    d = d(randperm(length(d)));
    x(1) = Ia;
    x(n) = Ib;
    for i = 2:n-1
        x(i) = x(i-1) + d(i-1);
    end
    
    obj.grid = x;
end

