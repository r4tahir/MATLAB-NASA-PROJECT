 %using earth's radius at the equator - 6378 km
   inputV = [pi/2,pi/4];
   
    X = 6378*cos(inputV(1))*cos(inputV(2));
    Y = 6378*cos(inputV(1))*sin(inputV(2));
    Z = 6378*sin(inputV(1));
    
    outputV = [X, Y, Z]
    
% Part 4 
% Step 2

%fminsearch to get the minimum distance from ISS to earth

x0 = [0, 0, 10];
[x,y] = fminsearch(@p4,x0);

%where y is the shortest distance
