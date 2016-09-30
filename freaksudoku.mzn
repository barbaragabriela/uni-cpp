include "alldifferent.mzn";

int: S = 3;
int: N = S * S;
array[1..N, 1..N] of var 1..N: grid;

array[1..9, 1..6] of var string: horizontal;
array[1..6, 1..9] of var string: vertical;

% columns
constraint forall(i in 1..N)
                 (alldifferent([grid[i,j] | j in 1..N]));

% rows
constraint forall(j in 1..N)
                  (alldifferent([grid[i,j] | i in 1..N]));

% squares
constraint forall(i in 0..S-1, j in 0..S-1)
                 (alldifferent( [ grid[r, c] | r in i*S+1..i*S+S, c in j*S+1..j*S+S] ));

% horizontal > < comparisions
constraint forall(i in 1..N, j in 1..N-S)
                 (if horizontal[i,j] == ">" then
                     grid[i,j + (j-1) div 2] > grid[i,j+ (j-1) div 2 + 1]
                  else
                     grid[i,j + (j-1) div 2] < grid[i,j+ (j-1) div 2 + 1]
                  endif
                  );

% vertical ^ v comparisions
constraint forall(j in 1..N, i in 1..N-S)
                 (if vertical[i,j] == "^" then
                     grid[i + (i-1) div 2,j] < grid[i + (i-1) div 2 + 1,j]
                  else
                     grid[i + (i-1) div 2,j] > grid[i + (i-1) div 2 + 1,j]
                  endif
                 );

solve satisfy;

output ["solution:\n"] ++
[show(grid[i,j]) ++ if (j mod 3 == 0) then
                        if j == N then
                          if i mod 3 == 0 then
                            "\n\n"
                          else
                            "\n"
                          endif
                        else
                          "  "
                        endif
                    else
                      " "
                    endif | i, j in 1..N ];