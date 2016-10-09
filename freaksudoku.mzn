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
% For these two contraints I loop through 1 to 9 and 1 to 6 (N-S, to reuse it)
% I use integer division / 2 to grab two > or < symbols for each sudoku 3x3 square
% I adding to the index 0, 1 or 2.
% Of course this only will work for a sudoku of 9x9, for another size, the expression has
% to change and make the int division by the value equals to length of symbols columns / S (size of squares)
% like for this we take to because 6/3 = 2, for a sudoku of 25x25, S=5, we would divide by 4
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
% For the solver I tried with all the options but I found that the Gecode or G12 fd took less time than the others
% both of them finished between 36 and 48ms.

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