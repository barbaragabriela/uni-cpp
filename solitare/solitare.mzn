include "globals.mzn";

int: s;                             % number of suits
set of int: S = 1..s;

int: m;                             % number of cards per suit
set of int: M = 1..m;

int: n = s * m;                     % number of cards
set of int: N = 1..n;

array[N] of var N: stack;           % stack
array[N] of var N: moment;          % channeling

int: pile_size = 3;                 % size of each pile
int: piles = (n - 1) div pile_size; % number of piles
array[1..piles, 1..pile_size] of N: input; % input of shuffled cards

array[1..n*s*2,1..2] of N: possible_moves; % possible combinations of cards

% these are for formating the output
array[M] of string: mappingcards = ["K", "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q"];
array[S] of string: mappingsuits = ["♠", "♣", "♥", "♦"];


% A of spades is always at the bottom of the stack
constraint stack[1] = 1;

% channeling
constraint inverse(stack,moment);

% for every stack check that in the stack one card proceeds another
constraint forall(i in 1..piles)
                 (forall(j in 1..2)
                        (value_precede(input[i,j], input[i,j+1], stack))
                 );
                 
% constraint forall(i in 1..piles, j in 1..2)
%                  (moment[input[i,j]] < moment[input[i,j+1]]);


% In order for a card to be placed in stack, it must be a rank higher or lower than the top card on the stack, we achieve that with the matrix 'possible_moves'.
constraint forall(i in 1..n-1)
                 (table([stack[i], stack[i+1]], possible_moves));


solve satisfy;

output %[show(stack)] ++ ["\n"] ++
[show(mappingcards[(stack[i] mod m)+1]) ++ show(mappingsuits[(stack[i] mod s)+1]) ++ " " | i in N];