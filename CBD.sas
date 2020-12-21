 title "Question 8.1";
data decision;
input cultivar control row response ;
cards;
1 1 1 202.4
1 1 2 180.8
1 1 3 152.2
1 2 1 161.8
1 2 2 149.6
1 2 3 140.8
1 3 1 51.8
1 3 2 112.6
1 3 3 106.6
1 4 1 101.2
1 4 2 113.6
1 4 3 105.2
1 5 1 59.4
1 5 2 116.6
1 5 3 102.2
2 1 1 132.2
2 1 2 156.2
2 1 3 138.6
2 2 1 123.2
2 2 2 98
2 2 3 75.2
2 3 1 59.6
2 3 2 94.6
2 3 3 83.8
2 4 1 82.4
2 4 2 80.6
2 4 3 64.4
2 5 1 68.0
2 5 2 80.2
2 5 3 67.2
;
proc glm data=decision;
class cultivar control row;
model response=cultivar control row control*cultivar;
output out=diagnostics r=resid p=predicted;
lsmeans control/adjust=tukey lines pdiff cl;
run;
proc plot data=diagnostics;
plot resid*predicted;
run;
proc univariate data=diagnostics normal plot;
var resid;
run;  



proc means data=decision;
	class cultivar control;
	output out=means mean=ym;
	var response;
	types cultivar*control;
run;

proc print data = means;
run;

title1 'Profile plot';
proc sgplot data=means;
	series x=control y=ym / group=cultivar;
run;

title1 'Profile plot-2 ';
proc sgplot data=means;
	series x=cultivar y=ym / group=control;
run;

data tomatoes;
input varieties$ density$ fieldblock$ response@@;
cards;
celebrity 5k 1 32.5
celebrity 5k 2 33.4
celebrity 5k 3 41.1
sunbeam 5k 1 32.2
sunbeam 5k 2 33.4
sunbeam 5k 3 41.8
trust 5k 1 49.9
trust 5k 2 60.8
trust 5k 3 60.8

celebrity 20k 1 39.9
celebrity 20k 2 47.2
celebrity 20k 3 48.7
sunbeam 20k 1 43.2
sunbeam 20k 2 51.3
sunbeam 20k 3 51.2
trust 20k 1 59.0
trust 20k 2 66.1
trust 20k 3 67.6

celebrity 35k 1 42.5
celebrity 35k 2 44.5
celebrity 35k 3 53.5
sunbeam 35k 1 47.6
sunbeam 35k 2 52.2
sunbeam 35k 3 59.9
trust 35k 1 66.3
trust 35k 2 70.7
trust 35k 3 73.2

celebrity 50k 1 38.2
celebrity 50k 2 43.5
celebrity 50k 3 48.4
sunbeam 50k 1 43.5
sunbeam 50k 2 41.1
sunbeam 50k 3 55.9
trust 50k 1 58.3
trust 50k 2 60.6
trust 50k 3 67.8
;

proc glm data=tomatoes;
class varieties density fieldblock;
model response=varieties density fieldblock varieties*density ;
output out=diagnostics r=resid p=predicted;
lsmeans varieties density/adjust=tukey lines pdiff cl;
run;

proc plot data=diagnostics;
plot resid*predicted;
proc univariate data=diagnostics normal plot;
var resid;
run;

proc means data=tomatoes;
class varieties density;
output out=means mean=ym;
var response;
types varieties*density;
run;

title "Profile plot";
proc sgplot data=means;
series x=varieties y=ym/group=density;
run;


title " profile plot 2";
proc sgplot data=means;
series x=density y=ym/group=varieties;
run;    

data Latinsquare;
 input FieldRow $ Column $ SeedingRatesTreatment  $ GrainYield  @@; 
 cards; 
 1 1 E 59.45  
 1 2 A 47.28  
 1 3 C 54.44  
 1 4 B 50.14  
 1 5 D 59.45   
 2 1 C 55.16  
 2 2 D 60.89  
 2 3 B 56.59   
 2 4 E 60.17   
 2 5 A 48.71    
 3 1 B 44.41  
 3 2 C 53.72  
 3 3 D 55.87   
 3 4 A 47.99   
 3 5 E 59.45 
 4 1 A 42.26   
 4 2 B 50.14 
 4 3 E 55.87  
 4 4 D 58.74    
 4 5 C 55.87    
 5 1 D 60.89    
 5 2 E 59.45   
 5 3 A 49.43    
 5 4 C 59.45    
 5 5 B 57.31   
 ; 
proc glm data=Latinsquare; 
class FieldRow Column SeedingRatesTreatment; 
model GrainYield = FieldRow Column SeedingRatesTreatment; 
output out=diagnostics r=resid p=predicted; 
random FieldRow Column; 
lsmeans SeedingRatesTreatment /adjust=tukey lines pdiff cl; 
run; 
proc plot data = diagnostics; 
plot resid*predicted; 
proc univariate data = diagnostics normal plot;
var resid;
run;



