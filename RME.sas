data hw10p1;
input drug$ time$ score@@;
cards;
A pre 11 A pre 8 A pre 5 A pre 14 A pre 19
A pre 6 A pre 10 A pre 6 A pre 11 A pre 3
A post 6 A post 0 A post 2 A post 8 A post 11
A post 4 A post 13 A post 1 A post 8 A post 0
B pre 6 B pre 6 B pre 7 B pre 8 B pre 18
B pre 8 B pre 19 B pre 8 B pre 5 B pre 15
B post 0 B post 2 B post 3 B post 4 B post 18
B post 4 B post 14 B post 9 B post 1 B post 9
c pre 16 c pre 13 c pre 11 c pre 9 c pre 21
c pre 16 c pre 12 c pre 12 c pre 7 c pre 12
c post 13 c post 10 c post 18 c post 5 c post 23
c post 12 c post 5 c post 16 c post 1 c post 20
proc print data=hw10p1;
run;
proc glm data=hw10p1;
class drug time;
model score = drug time drug*time;
output out=diagnostics r=resid p=predicts;
lsmeans drug/pdiff stderr adjust=tukey lines pdiff cl;
run;

proc mixed data=hw10p1;
class drug time;
model score = drug time drug*time;
repeated/type=un(1) subject= drug(time) r;
lsmeans drug/pdiff adjust=tukey cl;
run;
options pageno = 1;
Data Leprosy;
input Subject Score Time $ Drug $  @@;
cards;
1   11  Pre   Drug_A  1    6  Pre   Drug_B  1   16  Pre   Control
2    8  Pre   Drug_A  2    6  Pre   Drug_B  2   13  Pre   Control
3    5  Pre   Drug_A  3    7  Pre   Drug_B  3   11  Pre   Control
4   14  Pre   Drug_A  4    8  Pre   Drug_B  4    9  Pre   Control
5   19  Pre   Drug_A  5   18  Pre   Drug_B  5   21  Pre   Control
6    6  Pre   Drug_A  6    8  Pre   Drug_B  6   16  Pre   Control
7   10  Pre   Drug_A  7   19  Pre   Drug_B  7   12  Pre   Control
8    6  Pre   Drug_A  8    8  Pre   Drug_B  8   12  Pre   Control
9   11  Pre   Drug_A  9    5  Pre   Drug_B  9    7  Pre   Control
10   3  Pre   Drug_A  10  15  Pre   Drug_B  10  12  Pre   Control
1    6  Post  Drug_A  1    0  Post  Drug_B  1   13  Post  Control
2    0  Post  Drug_A  2    2  Post  Drug_B  2   10  Post  Control
3    2  Post  Drug_A  3    3  Post  Drug_B  3   18  Post  Control
4    8  Post  Drug_A  4    1  Post  Drug_B  4    5  Post  Control
5   11  Post  Drug_A  5   18  Post  Drug_B  5   23  Post  Control
6    4  Post  Drug_A  6    4  Post  Drug_B  6   12  Post  Control
7   13  Post  Drug_A  7   14  Post  Drug_B  7    5  Post  Control
8    1  Post  Drug_A  8    9  Post  Drug_B  8   16  Post  Control
9    8  Post  Drug_A  9    1  Post  Drug_B  9    1  Post  Control
10   0  Post  Drug_A  10   9  Post  Drug_B  10  20  Post  Control

run;
proc print data = Leprosy;
run;
proc mixed data = Leprosy;
  class Drug Time Subject;
  model Score = Drug Time Drug*Time / ddfm = satterth outp = diagnostics residual;
  repeated / type = csh subject = Subject(Drug);
  lsmeans Drug Time / pdiff;
run;
proc univariate data = diagnostics normal;
  var resid;
run;
data hw10p2;
input judge wine response@@;
cards;
1 1 20 1 2 24 1 3 28 1 4 28
2 1 15 2 2 18 2 3 23 2 4 24
3 1 18 3 2 19 3 3 24 3 4 23
4 1 26 4 2 26 4 3 30 4 4 30
5 1 22 5 2 24 5 3 28 5 4 26
6 1 19 6 2 21 6 3 27 6 4 25
;
proc print data=hw10p2;
proc glm data=hw10p2;
class wine judge;
model response = wine judge;
output out=diagnostics r=resid p=predicts;
lsmeans wine/pdiff stderr adjust=tukey lines pdiff cl;
run;

proc mixed data=hw10p2;
class judge wine;
model response=wine judge;
repeated/type=un(1) subject=judge(wine) r;
lsmeans wine /pdiff adjust=tukey cl;
run;
