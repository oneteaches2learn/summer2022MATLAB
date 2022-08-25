function Y = generaterhs(grid,fxn)

nx = length(grid)-1;
dx = diff(grid)

Y = dx.*fxn(grid(2:nx));

end

