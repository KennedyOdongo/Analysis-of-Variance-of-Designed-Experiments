data lifetest; 
input Hours Temperature Replicate @@; 
InvSqrt_Hours = 1/sqrt(Hours);
cards;
1953 1520 1 2135 1520 2 2471 1520 3 4727 1520 4 6134 1520 5 6314 1520 6
1190 1620 1 1286 1620 2 1550 1620 3 2125 1620 4 2557 1620 5 2845 1620 6
651 1660 1  837 1660 2  848 1660 3 1038 1660 4 1361 1660 5 1543 1660 6
511 1708 1  651 1708 2  651 1708 3  652 1708 4  688 1708 5  729 1708 6
;
proc glm data = lifetest;   
class Temperature;   
model InvSqrt_Hours = Temperature;   
contrast "Linear Trend" Temperature -0.773254 -0.050587 0.2384801 0.5853604; run;
proc plot data=lifetest;
plot hours*Temperature;
run;
proc plot data=lifetest;
plot InvSqrt_Hours *Temperature;
run;
OPTIONS LS=72 pageno = 1;
title "Construction of Orthogonal Polynomials Using SAS Proc IML"; title2 "Orthogonal Polynomials for Equal Spaced Levels"; 
title3 "Temperature Levels: 1520, 1620, 1660 and 1708";
/***
ENTER INTO VECTOR A THE FACTOR LEVELS FOR WHICH THE ORTHOGONAL POLYNOMIALS ARE REQUIRED. THE LINEAR ORTHOGONAL POLYNOMIAL IS ROW #1, QUADRATIC IS ROW #2, CUBIC IS ROW # 3, ETC. CONTRASTS ARE HORIZONTAL.
***/    
PROC iml;
A	= {1520 1620 1660 1708};
   Nentries = ncol(A)- 1;
   Labels = {Linear Quadratic Cubic Quartic Quintic Sestetic Septupic Octupic};
   Labels = Labels[ ,1:Nentries]`;
B	= ORPOL(A);
   B = B[ ,2:(Nentries+1)]`;
PRINT "Input Vector of Factor Levels" A;
PRINT "";
PRINT "Orthogonal Polynomials";
PRINT  B [rowname = Labels];
RUN;
