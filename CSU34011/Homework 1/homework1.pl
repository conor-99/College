/* Set up */
% - numeral
numeral(0).
numeral(s(A)) :- numeral(A).
numeral(A+B) :- numeral(A), numeral(B). % ex. 1
numeral(p(A)) :- numeral(A). % ex. 2
numeral(-A) :- numeral(A). % ex. 4
numeral(A-B) :- numeral(A), numeral(B). % ex. 6
% - add
add(0,A,A).
add(s(A),B,s(C)) :- add(A,B,C).
add(p(A),B,p(C)) :- add(A,B,C). % ex. 2
 
/* add2(...) */
% - exercise 1
add2(A,B,C) :- add(A,B,C).
add2(A+B,D,E) :- add2(A,B,C), add2(C,D,E).
add2(A,B+D,E) :- add2(B,D,C), add2(A,C,E).
add2(A+B,D+E,G) :- add2(A,B,C), add2(D,E,F), add2(C,F,G). % is this needed?
add2(s(A+B),C,s(D)) :- add2(A+B,C,D).
add2(A,s(B+C),s(D)) :- add2(A,B+C,D).
add2(s(A+B),s(C+D),s(s(E))) :- add2(A+B,C+D,E). % is this needed?
% - exercise 2
add2(p(s(A)),B,C) :- add2(A,B,C).
add2(A,p(s(B)),C) :- add2(A,B,C).
add2(s(p(A)),B,C) :- add2(A,B,C).
add2(A,s(p(B)),C) :- add2(A,B,C).
% - exercise 4
add2(-A,B,D) :- minus(A,C), add2(C,B,D).
add2(A,-B,D) :- minus(B,C), add2(A,C,D).
% - exercise 6
add2(A-B,C,E) :- subtract(A,B,D), add2(D,C,E).
add2(A,B-C,E) :- subtract(B,C,D), add2(A,D,E).
 
/* subtract(...) */
% - exercise 5
subtract(A,B,D) :- minus(B,C), add2(A,C,D).
subtract(-A,B,D) :- minus(A,C), subtract(C,B,D).
subtract(A,-B,D) :- minus(B,C), subtract(A,C,D).
subtract(-A,-B,E) :- minus(A,C), minus(B,D), subtract(C,D,E).
% - exercise 6
subtract(A-B,C,E) :- subtract(A,B,D), subtract(D,C,E).
subtract(A,B-C,E) :- subtract(B,C,D), subtract(A,D,E).
subtract(A-B,C-D,G) :- subtract(A,B,E), subtract(C,D,F), subtract(E,F,G). % is this needed?
 
/* minus(...) */
% - exercise 3
minus(0,0).
minus(s(A),p(B)) :- minus(A,B).
minus(p(A),s(B)) :- minus(A,B).
minus(s(p(A)),B) :- minus(A,B).
minus(p(s(A)),B) :- minus(A,B).