# glpsol --math l2CMI2021gmpImplicite.mod

# Variables definition

param n;
param c{i in 1..n};
param s{i in 1..n};

var x{i in 1..n} >= 0; 

var n2, integer, >= 0; # number of taken edges between two Bus Stops
var n3, integer, >= 0; # number of taken edges between tow Shared Bike Stations


/* Objective */
minimize z: sum{i in 1..n} c[i]*x[i]; # Objective function

/* Constraints */

subject to 
  conA: 0.5 * n2 / 20 = x[2] ;
  conB: 1.0 * n3 / 15 = x[3] ;
  con1: sum{i in 1..n} x[i] <= 1;
  con2: sum{i in 1..n} s[i]*x[i] <= 17;
  con3: sum{i in 1..n} s[i]*x[i] >= 13;
  con4: sum{i in 1..2} x[i] <= 3/4;

/* Resolve */
solve;

printf "Results:\n";
printf "x1 = %3.2f euros \n",z;
printf "x1 = %3.2f -> %2d min / taxi \n", x[1], x[1]*60;  
printf "x2 = %3.2f -> %2d min / bus  \n", x[2], x[2]*60;  
printf "x3 = %3.2f -> %2d min / bicycle \n", x[3], x[3]*60;  
printf "x4 = %3.2f -> %2d min / foot \n", x[4], x[4]*60;  
printf "n2 =   %2d segments by bus\n", n2;
printf "n3 =   %2d segments by bicycle\n", n3;

data;

param n := 4;
param c := 1 60.0 
           2  0.5  
           3  0.3 
           4. 0.0;
                  
param s := 1 25.0 
           2 20.0 
           3 15.0 
           4  4.5;

end;
