data one;
input ration$ age steers shearforce @@;
cards;

ratio1 1 1 3.1 ratio1 7 1 2.9 ratio1 14 1 2.4 ratio1 21 1 2.1
ratio1 1 2 3.2 ratio1 7 2 2.1 ratio1 14 2 2.5 ratio1 21 2 2.1
ratio1 1 3 4.9 ratio1 7 3 4.1 ratio1 14 3 3.4 ratio1 21 3 3.7
ratio1 1 4 6.0 ratio1 7 4 5.2 ratio1 14 4 5.1 ratio1 21 4 5.0

ratio2 1 5 4.9 ratio2 7 5 5.2 ratio2 14 5 4.4 ratio2 21 5 4.6
ratio2 1 6 5.9 ratio2 7 6 5.8 ratio2 14 7 3.1 ratio2 21 6 4.9
ratio2 1 7 3.1 ratio2 7 7 2.8 ratio2 14 7 3.1 ratio2 21 7 2.1
ratio2 1 8 4.6 ratio2 7 8 4.4 ratio2 14 8 4.7 ratio2 21 8 3.8

ratio3 1 9 5.3  ratio3 7 9 5.2  ratio3 14 9 5.1  ratio3 21 9 4.8
ratio3 1 10 4.8 ratio3 7 10 4.6 ratio3 14 10 4.2 ratio3 21 10 4.1
ratio3 1 11 4.7 ratio3 7 11 4.5 ratio3 14 11 4.2 ratio3 21 11 3.8
ratio3 1 12 4.9 ratio3 7 12 4.8 ratio3 14 12 4.7 ratio3 21 12 4.4
;

proc print data=one;
run;


proc glm data=one;
class steers ration age;
model shearforce = ration steers(ration) age ration*age;
test h = ration e=steers(ration);
output out=diagnostics r=resid p=predicted;
lsmeans ration age/pdiff stderr;
run;



proc mixed data=one;
class steers ration age;
model shearforce=ration age ration*age/ddfm =satterth;
random steers(ration);
lsmeans ration age ration*age/pdiff adjust=tukey;
run;
proc plot data=diagnostics;
plot resid*predicted;
proc univariate data=diagnostics normal plot;
var resid;
run;
proc means;
class steers ration age;
output out=means mean=ym;
var shearforce;
types ration*age;
run;


proc means data=one;
class steers ration age;
output out=means mean=ym;
var shearforce;
types ration*age;
run;
proc print data= means;
run;
title1 'Profile plot';
proc sgplot data=means;
	series x=ration y=ym / group=age;
	run;
title2 'Profile plot 2';
proc sgplot data=means;
	series x=age y=ym / group=ration;
run;

data exercise2;
input block $ Phosphorous $ Variety $ yields @@;
cards;
B1 0 V1 53.5
B1 0 V2 44.8
B1 0 V3 50.7
B2 0 V1 62.2
B2 0 V2 52.5
B2 0 V3 61.4
B3 0 V1 53.4	
B3 0 V2 43.1	
B3 0 V3 50.6

B1 30 V1 60.6	 
B1 30 V2 51.0	
B1 30 V3 54.9	
B2 30 V1 68.8	
B2 30 V2 58.7	
B2 30 V3 64.9	
B3 30 V1 59.5		
B3 30 V2 49.6		
B3 30 V3 54.8

B1 60 V1 60.8		 
B1 60 V2 51.5		
B1 60 V3 59.4		
B2 60 V1 70.9		
B2 60 V2 59.4		
B2 60 V3 70.0		
B3 60 V1 61.0		
B3 60 V2 49.7				
B3 60 V3 60.5

B1 90 V1 59.6			 
B1 90 V2 49.9			
B1 90 V3 64.7			
B2 90 V1 67.8			
B2 90 V2 58.1			
B2 90 V3 74.4			
B3 90 V1 60.3			
B3 90 V2 49.5				
B3 90 V3 65.0	
;
proc print data = exercise2;
proc glm data = exercise2;
class block Phosphorous Variety;
model yields = block Variety block*Variety Phosphorous Phosphorous*Variety;
output out=diagnostics r=resid p=predicted;
test h = Variety e = block*Variety;
run;
proc mixed data = exercise2;
 class block Phosphorous Variety;
 model yields = Phosphorous Variety Phosphorous*Variety / ddfm = satterth;
 random block block*Variety;
 lsmeans Phosphorous Variety Phosphorous*Variety/ pdiff adjust=tukey cl;
run;
proc plot data = diagnostics;
plot resid*predicted;
proc univariate data = diagnostics normal plot;
var resid;
run;
proc means data=exercise2;
class block Phosphorous Variety;
output out=means mean=ym;
var yields ;
types Phosphorous*Variety;
run;
proc print data= means;
run;
title1 'Profile plot';
proc sgplot data=means;
	series x=Phosphorous y=ym / group=Variety;
	run;
title2 'Profile plot 2';
proc sgplot data=means;
	series x=Variety y=ym / group=Phosphorous;
run;


 