/*Kuriou

final(CF):-...
h(CF) :- a(CF1) , b(CF2), c(CF3), cf(h,r1, X), eval(CF, X,[CF1,CF2,CF3]).
h(CF) :- f(CF1) , g(CF2), cf(h, r2, X), eval(CF,X,[CF1,CF2]).
b(CF) :- d(CF1), f(CF2), cf(b,r, X), eval(CF,X,[CF1,CF2]).
d(CF) :- a(CF1), cf(d,r,X), eval(CF,X,[CF1]).
g(CF) :- i(CF1), cf(g, r, X), eval(CF,X,[CF1]).

cf(h,r1,0.8). 
cf(h,r2,0.4). 
cf(b,r,0.6). 
cf(d,r,0.75). 
cf(g, r, 0.3).
*/

cf(a,1.0).  	%Παράγοντες βεβαιότητας γεγονότων
cf(c, 0.5). 
cf(f,0.7). 
cf(i,-0.4).

cf(r1,0.8).		%Παράγοντες βεβαιότητας κανόνων
cf(r2,0.4).
cf(r3,0.6).
cf(r4,0.75).
cf(r5,0.3).

cf(b,B):- cf(d,D) , cf(f,F) , cf(r3,R) , B is min(D,F) * R.

cf(d,D):- cf(a,A) , cf(r4,R), D is A * R.

cf(g,G) :- cf(i,I) , cf(r5,R) , G is I * R.

cf(h1,H) :-  cf(a,A), cf(c,C) , cf(b,B), cf(r1,R) ,  H is min(min(A,C),B) * R.

cf(h2,H) :- cf(f,F) , cf(g,G) , cf(r2,R) , H is min(F,G) * R.

final(CF) :- cf(h1,X) , cf(h2,Y) , CF is ( X + Y ) / (1 - min( abs(X) , abs(Y))).

