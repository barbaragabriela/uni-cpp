% Colouring Australia
int: nc;

var 1..nc: wa;
var 1..nc: sa;
var 1..nc: nsw;
var 1..nc: t;
var 1..nc: nt;
var 1..nc: q;
var 1..nc: v;

constraint wa != nt;
constraint wa != sa;
constraint sa != nt;
constraint sa != q;
constraint sa != nsw;
constraint sa != v;
constraint nt != q;
constraint q != nsw;
constraint nsw != v;

solve satisfy;

output ["wa=\(wa), ", "nt=\(nt), ", "sa=\(sa), ", "q=\(q), ", "nsw=\(nsw), ", "v=\(v), ", "t=\(t)"]
