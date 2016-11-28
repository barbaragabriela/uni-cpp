int: n;
set of int: OBJ = 1..n;
int: k;
set of int: SET = 1..k;
array[SET] of set of OBJ: s;
int: u;

var set of OBJ: x;

constraint forall(i in SET)
                (card(x intersect s[i]) <= 1);
                
constraint card(x) = u;

solve maximize sum(i in x)(i);

output [show(x)];