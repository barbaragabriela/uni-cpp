include "globals.mzn";

int: gr;                  % number of groups
set of int: G = 1..gr;
int: sz;                  % people by groups
set of int: S = 1..sz;
int: n = gr * sz;         % number of players
set of int: P = 1..n;
int: we;                  % number of weeks
set of int: W = 1..we;

%X[g,w] is the set of people that form group g in week w
array[G,W] of var set of P: X;

% group size
constraint forall(w in W, g in G)
                 (card(X[g,w]) == sz);

% all players play every week
constraint forall(w in W)
                 (forall(g, gg in G where g < gg)
                        (card(X[g,w] intersect X[gg,w]) == 0)
                 );

% Nobody meets more than once
constraint forall(w, ww in W where w < ww)
                 (forall(g, gg in G)
                       (card(X[g,w] intersect X[gg,ww]) <= 1)
                 );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BReaking symmetries
% Player permutations
constraint forall(g in G)
                 ( X[g,1] = (g-1)*sz + 1 .. g*sz );

% Group permutations
constraint forall(w in W)
                 (forall(g in G where g < gr)
                        (X[g,w] > X[g+1,w])
                 );
                 
% Week permutations
constraint forall(w in W where w < we)
                 (X[2,w] < X[2,w+1]);


solve satisfy;


% output[""];
output["#  |  "] ++ ["w" ++ show(W[k]) ++ "         " | k in W] ++ ["\n"] ++
[ if k == 1 then "g" ++ show(i) ++ " | " else "" endif ++ show(X[i,k]) ++ if (k mod we == 0) then "\n" else "   " endif | i in G, k in W];