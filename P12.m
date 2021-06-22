% PART ONE

% Step 1

% import data with headers X,Y,Z  (position) and X1,Y1,Z1 (velocity)
parsedData = readtable('mainData.csv');
sizeOfData = size(parsedData);

angleArray = zeros(sizeOfData(1),1);
%Array to store differences between adjacent angles
differenceArray = zeros(sizeOfData(1),1);
orbitArray = zeros(1,1);

i = 1;

%Getting the angles
while i <= sizeOfData(1)
    angleArray(i) = atan2(parsedData.('Y')(i),parsedData.('X')(i));
    i = i+1;
end 

counter = 1;
for i=1:(sizeOfData(1)-1)
    
    %calculating difference
    differenceArray(i) = angleArray(i+1)-angleArray(i);
    
    
    %checking for absolute value being greater than 4 to determine if an entire orbit has occured
    if abs(differenceArray(i))>4
        orbitArray(counter) = i;
        counter = counter+1;
    end 
    
end


% Print out NASA vals to compare with ellipse for first orbit
    scatter3(parsedData.('X')(orbitArray(1):orbitArray(2)-1),parsedData.('Y')(orbitArray(1):orbitArray(2)-1),parsedData.('Z')(orbitArray(1):orbitArray(2)-1))
     hold on
 

% Step 2 

% Get two points on edge of ellipse with vectors which are 90 degrees apart 
%(4383.99, -705.689, 5140.66) and (2541.44, 6212.21, -1452.89) 

% w (frequency/time it takes for orbit to happen)

% subtract the line numbers at which this orbit happens 

lineDiff = (orbitArray(2)-1) - orbitArray(1);

% multiply by 4 because data is given is 4 minute time increments
period = lineDiff * 4;
t = linspace (0,period,24);
% frequency 
w = (2*pi)/period;

%final calculations and plotting
x = 4383.99*cos(w*t) + 2541.44*sin(w*t);
y = -705.689*cos(w*t) + 6212.21*sin(w*t);
z = 5140.66*cos(w*t) - 1452.89*sin(w*t);

xlabel('x');
ylabel('y');
zlabel('z');

title('Ellipse Plot vs scattered NASA orbit 1 plot values');

plot3(x,y,z);

% ---------------------------------- Part 2 -------------------------------
xd = diff(x);
yd = diff(y);
zd = diff(z);

%Divide by 240 to convert to km/s
xdNew = xd/240;
ydNew = yd/240;
zdNew = zd/240;

%orbital velocity data from NASA
x1 = zeros(1,1);
y1 = zeros(1,1);
z1 = zeros(1,1);

for i = 1:lineDiff
    x1(i) = parsedData.('X1')(i+orbitArray(1)-1);
    y1(i) = parsedData.('Y1')(i+orbitArray(1)-1);
    z1(i) = parsedData.('Z1')(i+orbitArray(1)-1);
end

nasaVels = zeros(1,1);
%array of derivative velocities
dv = zeros(1,1);

for i = 1:lineDiff
   dv(i) = sqrt((xdNew(i)).^2 + (ydNew(i)).^2 + (zdNew(i)).^2);
end

for i = 1:lineDiff
    nasaVels(i) = sqrt((x1(i)).^2 + (y1(i)).^2 + (z1(i)).^2);
end

% Max Error
differences = zeros(1,1);

i = 0; 

while i <= lineDiff
    if(i > 0)
        differences(i) = abs(nasaVels(i)-dv(i));
        
    end
    i = i+1;
end

maxError = max(differences)

% RMSE 

nmrtr = 0;

i = 0;

while i <= lineDiff
    if(i > 0)
        nmrtr = nmrtr + (nasaVels(i)-dv(i))^2;
        
    end
    i = i+1;
end

dnmtr = lineDiff;

RMSE = sqrt(nmrtr/dnmtr)
