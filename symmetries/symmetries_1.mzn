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

% Nobody meets more than once
constraint forall(k, kk in W where k < kk)
                 (forall(i, ii in G)
                        (forall(j, jj in S where j != jj)
                               (forall(j2, jj2 in S where j2 != jj2)
                                      (X[i,j,k] != X[ii,j2,kk] \/ X[i,jj,k] != X[ii,jj2,kk])
                               )
                        )
                 );

% Player permutations and in-group permutations
constraint forall(i in G)
                 (forall(j in S)
                       ( X[i,j,1] = j+we*(i-1) )
                 );

% Group permutations
constraint forall(k in W)
                 (forall(i in G)
                        (forall(j in S where j < sz)
                               ( X[i,j,k] < X[i,j+1,k] )
                        )
                 );

% Week permutations
constraint forall(i in G)
                 (forall(k in 2..we)
                        ( X[i,1,k] = i)
                 );

% constraint forall(k in W)
%                  (X[1,1,k] = 1);
% constraint forall(j in S)
%                  (forall(k in W where k < we)
%                         ( X[1,j,k] != X[1,j,k+1] )
%                  );

solve satisfy;
output [""];
% output ["w" ++ show(W[k]) ++ "  " | k in W] ++ ["\n"] ++
%    [show(X[i, j, k]) ++ if (k mod we == 0) then
%                            if (j mod sz == 0) then
%                                "\n\n"
%                            else
%                            "\n"
%                            endif
%                          else
%                                "   "
%                          endif | i in G, j in S, k in W];