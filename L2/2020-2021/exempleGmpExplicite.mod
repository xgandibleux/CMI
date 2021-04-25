# glpsol --math exempleGmpExplicite.mod

# Variables definition

var x1 >= 0; # time in Taxi
var x2 >= 0; # time in Bus
var x3 >= 0; # time in Bike
var x4 >= 0; # walking time

var n2, integer, >= 0; # number of taken edges between two Bus Stops
var n3, integer, >= 0; # number of taken edges between tow Shared Bike Stations

var y2, binary;
var y3, binary; 

minimize z : 60*x1 + 1.7*y2 + 0.75* y3 + 0.001*x4; # Objective function

# Constraints

subject to 
  switch1: x2<= y2; # modified to pay only the fare for a ride
  switch2: x3<= y3;
  conA: 0.5 * n2 / 20 = x2 ;
  conB: 1.0 * n3 / 12 = x3 ;
  con1: x1 + x2 + x3 + x4 <= 1.0;
  con2: x1 + x2 <= 3/4;
  con3: 35*x1 + 20*x2  + 12*x3 + 4.5*x4 <= 17;
  con4: 35*x1 + 20*x2  + 12*x3 + 4.5*x4 >= 13;

solve;

printf "Results:\n";
printf "y2 = %3.2f ticket \n",y2;
printf "y3 = %3.2f ticket \n",y3;
printf " c = %3.2f euros \n",z;
printf " d = %3.2f km \n",35*x1 + 20*x2  + 12*x3 + 4.5*x4;
printf "x1 = %3.2f -> %2d min / taxi \n", x1, x1*60;  
printf "x2 = %3.2f -> %2d min / bus  \n", x2, x2*60;  
printf "x3 = %3.2f -> %2d min / bicycle \n", x3, x3*60;  
printf "x4 = %3.2f -> %2d min / foot \n", x4, x4*60;  
printf "n2 =   %2d segments by bus\n", n2;
printf "n3 =   %2d segments by bicycle\n", n3;

end;
