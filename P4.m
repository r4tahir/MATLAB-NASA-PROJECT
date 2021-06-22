% Part 4
function distCalc = p4(inputV)
    w = (2*pi)/inputV(1);
    v1 = [4383.99, -705.689, 5140.66];
    v2 = [2541.44, 6212.21, -1452.89];
    
    %ISS x y and z values
    x1 = v1(1)*cos(w*inputV(1)) - v2(1)*sin(w*inputV(1));
    y1 = v1(2)*cos(w*inputV(1)) - v2(2)*sin(w*inputV(1));
    z1 = v1(3)*cos(w*inputV(1)) + v2(3)*sin(w*inputV(1));

    % using same logic as function in p3 with earth's radius at equator = 6378km
    X = 6378*cos(inputV(2))*cos(inputV(3));
    Y = 6378*cos(inputV(2))*sin(inputV(3));
    Z = 6378*sin(inputV(2));
    
    outputV = [X, Y, Z]
    
    %output
    distCalc = norm([x1, y1, z1] - outputV)
end   
