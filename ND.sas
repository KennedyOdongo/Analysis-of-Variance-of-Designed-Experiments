data nested;
input supplier batch rep purity @@;
cards;
1 1 1 94 1 2 1 91 1 3 1 91 1 4 1 94
1 1 2 92 1 2 2 90 1 3 2 93 1 4 2 97
1 1 3 93 1 2 3 89 1 3 3 94 1 4 3 93
2 1 1 94 2 2 1 93 2 3 1 92 2 4 1 93
2 1 2 93 2 2 2 97 2 3 2 93 2 4 2 96
2 1 3 90 2 2 3 95 2 3 3 91 2 4 3 95
3 1 1 95 3 2 1 91 3 3 1 94 3 4 1 95
3 1 2 97 3 2 2 93 3 3 2 92 3 4 2 95
3 1 3 93 3 2 3 95 3 3 3 95 3 4 3 94
3 1 3 93 3 2 3 95 3 3 3 95 3 4 3 94
;

data Leaf;
input plant leaf sample calcium @@;
cards;
1 1 1 3.28 1 2 1 3.52 1 3 1 2.88
1 1 2 3.09 1 2 2 3.48 1 3 2 2.80
2 1 1 2.46 2 2 1 1.87 2 3 1 2.19
2 1 2 2.44 2 2 2 1.92 2 3 2 2.19
3 1 1 2.77 3 2 1 3.74 3 3 1 2.55
3 1 2 2.66 3 2 2 3.44 3 3 2 2.55
4 1 1 3.78 4 2 1 4.07 4 3 1 3.31
4 1 2 3.87 4 2 2 4.12 4 3 2 3.31
;
proc print data=Leaf;
run;

proc glm data=Leaf;
class plant leaf sample;
model calcium=plant leaf(plant);
test h=plant e =leaf(plant);
lsmeans plant /pdiff stderr e=leaf(plant);
*lsmeans plant leaf /pdiff stderr e=sample(plant leaf); 
run;

proc glm data=Leaf;
class plant leaf sample;
model calcium= plant Leaf(plant);
random leaf(plant)/test;
run;

data decision;
input team observer size response @@;
cards;
1 1 1 16
1 1 1 20 
1 1 2 21
1 1 2 25
1 2 1 14
1 2 1 19
1 2 2 28
1 2 2 19
2 3 1 7
2 3 1 5
2 3 2 11
2 3 2 17
2 4 1 4
2 4 1 9
2 4 2 12
2 4 2 15
;
proc glm data=decision;
class team observer size;
model response=team observer(team) size team*size size*observer(team);
output out=diagnostics r=resid p=predicted;
lsmeans team /adjust=tukey lines pdiff cl;
random observer(team) size*observer(team)/test;
run;

proc plot data=diagnostics;
plot resid*predicted;
proc univariate data=diagnostics normal plot;
var resid;
run;





















