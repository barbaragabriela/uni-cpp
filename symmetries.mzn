include "alldifferent.mzn";


int: gr;                  % number of groups
set of int: G = 1..gr;
int: sz;                  % people by groups
set of int: S = 1..sz;
int: n = gr * sz;         % number of players
set of int: P = 1..n;
int: we;                  % number of weeks
set of int: W = 1..we;

%X[g,s,w]=k means that the s-th person of group g in week w  is k
array[G,S,W] of var P: X;

% every player plays every week
constraint forall(k in W)
                  (alldifferent([X[i, j, k] | i in G, j in S]));

constraint forall(k1, k2 in W where k1 < k2)
                  (forall(i1, i2 in G)
                          (forall(j1, j2 in S where j1 < j2)
                                  (X[i1,j1,k1] != X[i2,j2,k2] \/ X[i1,j2,k1] != X[i2,j2,k2])
                          )
                  );


solve satisfy;

output ["w" ++ show(W[k]) ++ "  " | k in W] ++ ["\n"] ++
  [show(X[i, j, k]) ++ if (k mod we == 0) then
                          if (j mod sz == 0) then
                              "\n\n"
                          else
                          "\n"
                          endif
                        else
                              "   "
                        endif | i in G, j in S, k in W];