title "Analysis of Listeria Data - Completely Randomized Design";
title2 "with Two-Way Treatment Structure";
data listeria;
input LogCFU Rep Pressure Time @@;
cards;
7.10 1 400  1  7.29 2 400  1  7.19 3 400  1
6.19 1 400  2  5.86 2 400  2  5.96 3 400  2
5.36 1 400  3  4.89 2 400  3  5.15 3 400  3
4.97 1 400  4  4.66 2 400  4  4.87 3 400  4
4.74 1 400  5  3.36 2 400  5  3.98 3 400  5

7.05 1 450  1  8.10 2 450  1  8.15 3 450  1
5.63 1 450  2  5.16 2 450  2  5.33 3 450  2
5.01 1 450  3  4.99 2 450  3  4.76 3 450  3
4.03 1 450  4  3.03 2 450  4  3.54 3 450  4
3.46 1 450  5  2.15 2 450  5  2.33 3 450  5

5.39 1 500  1  4.78 2 500  1  5.28 3 500  1
4.69 1 500  2  4.38 2 500  2  4.22 3 500  2
3.85 1 500  3  3.21 2 500  3  3.52 3 500  3
2.60 1 500  4  1.54 2 500  4  1.85 3 500  4
2.00 1 500  5  1.80 2 500  5  2.14 3 500  5 
;
Proc sort data = listeria; 
  by rep;
run;
Proc print data = listeria;
run;
Proc glm data = listeria;
Class Pressure Time;
Model LogCFU = Pressure Time Pressure*Time;
output out = diagnostics r=residual p=predicted;
lsmeans Pressure Time Pressure*Time / adjust=tukey pdiff lines cl;
run;
Proc Univariate data = diagnostics normal plot;
  var residual;
proc plot;
plot residual*predicted;
run;
