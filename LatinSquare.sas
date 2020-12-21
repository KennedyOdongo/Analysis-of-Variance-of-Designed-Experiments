data FinalQ1;
input time tech method$ min @@;
cards;
1 1 C 90 1 2 D 96 1 3 A 84 1 4 B 88
2 1 B 90 2 2 C 91 2 3 D 96 2 4 A 88
3 1 A 89 3 2 B 97 3 3 C 98 3 4 D 98
4 1 D 104 4 2 A 100 4 3 B 104 4 4 C 106
;
proc print data = FinalQ1;
run;
data FinalQ2;
input diet subject time sgl@@;
cards;
1 1 15 28 1 1 30 34 1 1 45 32
1 2 15 15 1 2 30 29 1 2 45 27
1 3 15 12 1 3 30 33 1 3 45 28
1 4 15 21 1 4 30 44 1 4 45 39
2 5 15 22 2 5 30 18 2 5 45 12
2 6 15 23 2 6 30 22 2 6 45 10
2 7 15 18 2 7 30 16 2 7 45 9
2 8 15 25 2 8 30 24 2 8 45 15
3 9 15 31 3 9 30 30 3 9 45 39
3 10 15 28 3 10 30 27 3 10 45 36
3 11 15 24 3 11 30 26 3 11 45 36
3 12 15 21 3 12 30 26 3 12 45 32
;
proc print data = FinalQ2;
run;
proc glm data=FinalQ2;
class diet subject time;
model sgl=diet subject time;
output out=diagnostics r=resid p=predicted;
lsmeans subject/adjust=tukey lines pdiff cl;
run;
proc plot data=FinalQ2;
plot time*diet;
run;
proc univariate data=diagnostics normal plot;
var resid;
run;
data FinalQ3;
input summer water$ gains@@;
cards;
1 NN 2.65 1 NS 2.46 1 SN 2.56 1 SS 2.43
1 NN 2.53 1 NS 2.36 1 SN 2.38 1 SS 2.50
2 NN 2.25 2 NS 1.95 2 SN 2.01 2 SS 2.14
2 NN 2.20 2 NS 2.25 2 SN 1.98 2 SS 2.37
;
proc print data = FinalQ3;
run;
proc glm data=FinalQ3;
class summer water ;
model gains = summer water summer*water; 
random summer summer*Water /test;   
*means Summer Water / lsd lines;
lsmeans summer water summer*water/ pdiff stderr;
run;
