include "globals.mzn";

int: gr;                  % number of groups
set of int: G = 1..gr;
int: sz;                  % people by groups
set of int: S = 1..sz;
int: n = gr * sz;         % number of players
set of int: P = 1..n;
int: we;                  % number of weeks
set of int: W = 1..we;

%X[p,w]=g means that person p in week w plays in group g
array[P,W] of var G: X;

% every week every player has a group
constraint forall(p in P, w in W)
                 (X[p,w] in G);

% every group has sz players
constraint forall(w in W, g in G)
                 (sum(p in P)(bool2int(X[p,w] == g)) == sz
                 );
                 
% Nobody meets more than once
constraint forall(w, ww in W where w != ww)
                 (forall(p, pp in P where p < pp)
                        ( X[p,w] != X[pp,w] \/ X[p,ww] != X[pp,ww] )
                 );


constraint forall(p in P)
                (X[p,1] = (p-1) div 3 + 1);

constraint forall(w in W)
                 (X[1,w] = 1);
                 
% constraint forall(w in W)
%                  (X[4,w] = 2);


solve satisfy;

output[""];
% output["# | "] ++ ["w" ++ show(W[k]) ++ "  " | k in W] ++ ["\n"] ++
% [ if k == 1 then show(x) ++ " | " else "" endif ++ show(X[x,k]) ++ if (k mod we == 0) then "\n" else "   " endif | x in P, k in W];