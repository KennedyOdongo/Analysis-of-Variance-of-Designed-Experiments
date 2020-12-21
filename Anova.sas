title " homework 1 analysis";
data salt;
input rep salt weight @@;
cards;
1   0   2.4  2   0  10.6  3   0  12.0  4    0   4.6
1  50  40.9  2  50  47.7  3  50  31.9  4   50  36.3
1 100  70.5  2 100  96.7  3 100  26.4  4  100  76.0
1 200 127.2  2 200 134.0  3 200  28.1  4  200  78.3
;
proc print data = salt;
run;
proc glm data = salt;
class  rep salt;
model Weight = salt;
output out = diagnostics r = residuals;
means Salt / hovtest = bf;
run;
proc univariate data = diagnostics normal;
var residuals;
run;
proc plot data = diagnostics;
plot residuals*salt;
run;

title "Homework 1 number 2";
DATA golf;
 INPUT Brand$ Sample @@;
CARDS; 
BrandA 251.2
BrandA 245.1
BrandA 248.0
BrandA 251.1
BrandA 265.5
BrandA 250.0
BrandA 253.9
BrandA 244.6
BrandA 254.6
BrandA 248.8
BrandB 263.2
BrandB 262.9
BrandB 265.0
BrandB 254.5
BrandB 264.3
BrandB 257.0
BrandB 262.8
BrandB 264.4
BrandB 260.9
BrandB 255.9
BrandC 269.7
BrandC 263.2
BrandC 277.5
BrandC 267.4
BrandC 270.5
BrandC 265.5
BrandC 270.7
BrandC 272.9
BrandC 275.6
BrandC 266.5
BrandD 251.6
BrandD 248.6
BrandD 249.4
BrandD 242.0
BrandD 246.5
BrandD 251.3
BrandD 262.8
BrandD 249.0
BrandD 247.1
BrandD 245.9
;
run;

proc print data=golf;
run;
proc glm data=golf plots=all;
class Brand;
model Sample=Brand;
output out=diagnostics r residuals p=predicted;
means Sample/Tukey 














