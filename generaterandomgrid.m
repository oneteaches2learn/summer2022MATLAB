function x = generaterandomgrid(Ia,Ib,n,upperTolerance,lowerTolerance)
%GENERATERANDOMGRID(Ia,Ib,n,k,upperTolerance,lowerTolerance) fills interval 
%   (Ia - Ib) with n-many grid points separated by at most k distance and 
%   at least l distance.  
% 
%   Required arguments: Ia, Ib, n
%   Optional arguments: k, l
%
%   version 1       author: Tyler Fara      created: 8/19/22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   NOTE: If only one tolerance value is passed, then GENERATERANDOMGRID
%   assumes that the passed value is an upper bound on the tolerance.
%
%   If two tolerance values are passed, they can be passed in either order.
%   GENERATERANDOMGRID will ensure that the smaller number is set to the 
%   lower tolerance bound and the larger number is set to the upper
%   tolerance bound.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   NOTE: The purpose of this note is to explain the final code block, 
%   in which the intervals that have been generated are shuffled. To
%   explain, the step sizes are not truly random. Rather the step size 
%   will, on average, tend toward the upper or lower tolerance, depending 
%   on the values of the upper and lower tolerances. I'm currently not sure 
%   how to predict for a given choice of upper and lower tolerance whether 
%   the step size will tend toward the upper or lower tolerance. However, 
%   this version of the GENERATERANDOMGRID function is good enough for my 
%   current purposes, so I don't currently plan to investigate further.
%   Instead, the last code block shuffles the intervals that have been
%   generated in order to make the output seem more random.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   EXAMPLES
%   example 1:
%       x = generaterandomgrid(2,5,15,.1,.4)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CHECK INPUT VALIDITY
% Check that bounds are appropriate
if Ia >= Ib
    error('Upper bound must be strictly less than lower bound.')
end

% If two tolerance values passed, ensure upper tolerance is bigger
if nargin > 4
    if upperTolerance < lowerTolerance
        temp = upperTolerance;
        upperTolerance = lowerTolerance;
        lowerTolerance = temp;
    end
end

% If upper tolerance is passed, check its validity
if nargin > 3
    if (n-1)*upperTolerance < (Ib - Ia)
        width = Ib - Ia;
        nBar  = ceil(width/upperTolerance)+1;
        kBar  = width/(n-1);
        error(['Too few grid points for given mesh tolerances. ' ...
            '\nTo use current step size, choose at least %i grid points. ' ...
            '\nTo use current number of grid points, increase mesh size to ' ...
            'more than %f.'],nBar,kBar)
    end
end

% If two tolderance values are passed, check their validity
if nargin > 4
    if n*lowerTolerance > (Ib - Ia)
        width = Ib - Ia;
        nBar = floor(width/lowerTolerance);
        kBar = width/n;
        error(['Too many grid points for given mesh tolerances. ' ...
            '\nTo use current step size, use at most %i grid points, ' ...
            '\nTo use current number of grid points, decrease mesh size to ' ...
            ' less than %f'],nBar,kBar)       
    end
end


% RANDOMLY FILL GRID
% Initialize grid and assign first grid point
x    = zeros(1,n);
x(1) = Ia;
p    = x(1);

% Assign lowerTolerance and upperTolerance, if not passed as arguments
if ~exist('lowerTolerance','var')
    lowerTolerance = 0;
end

if ~exist('upperTolerance','var')
    upperTolerance = Ib - Ia;
end

% Assign remaining grid points
lowerBound = lowerTolerance;
for i = 2:n
    d          = Ib - p;
    upperBound = min([upperTolerance,(Ib - p) - (n-i)*lowerBound]);
    lowerBound = max([lowerTolerance,d - upperBound * (n-i)]);
    r          = lowerBound + (upperBound-lowerBound)*rand;
    p          = x(i-1) + r;
    x(i)       = p;
end


% SHUFFLE INTERVALS
d = diff(x);
d = d(randperm(length(d)));
x(1) = Ia;
x(n) = Ib;
for i = 2:n-1
    x(i) = x(i-1) + d(i-1);
end


