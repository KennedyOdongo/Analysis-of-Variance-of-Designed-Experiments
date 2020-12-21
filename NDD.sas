options pageno = 1;
data spectrophotometer;
input Triglycerides Machine Day Replicate @@;
cards;
142.3 1 1 1 144.0 1 1 2 148.6 2 1 1 146.9 2 1 2 142.9 3 1 1 147.4 3 1 2 133.8 4 1 1 133.2 4 1 2
134.9 1 2 1 146.3 1 2 2 145.2 2 2 1 146.3 2 2 2 125.9 3 2 1 127.6 3 2 2 108.9 4 2 1 107.5 4 2 2
148.6 1 3 1 156.5 1 3 2 148.6 2 3 1 153.1 2 3 2 135.5 3 3 1 139.9 3 3 2 132.1 4 3 1 149.7 4 3 2
152.0 1 4 1 151.4 1 4 2 149.7 2 4 1 152.0 2 4 2 142.9 3 4 1 142.3 3 4 2 141.7 4 4 1 141.2 4 4 2
;
proc glm data = spectrophotometer;
  class Machine Day;
  model Triglycerides = Machine Day Machine*Day;
random Day Machine Machine*Day  / test; 
run;

data nested;
input day run response;
cards;
1 1 42.5
1 1 43.3
1 1 42.9
1 2 42.2
1 2 41.4
1 2 41.8
2 1 48.0
2 1 44.6
2 1 43.7
2 2 42.0
2 2 42.8
2 2 42.8
3 1 41.7
3 1 43.4
3 1 42.5
3 2 40.6
3 2 41.8
3 2 41.8
;
proc glm data=nested;
class day run;
model response= day run(day);
random day run(day)/test;
run;
proc varcomp;
class day run;
model response=day run(day);
run;
