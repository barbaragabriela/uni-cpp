include "globals.mzn";

int: c;                     % number of courses
set of int: C = 1..c;

int: g;                     % number of groups per course
set of int: G = 1..g;

int: nt;                    % number of theory rooms
int: nl;                    % number of laboratory rooms
int: d;                     % number of days

int: ini;                   % first available hour
int: end;                   % last available hour

array[C] of int: NT;        % number of teachers per course

int: slots = d * (end - ini + 1);  % number of available slots
set of int: SLOTS = 1..slots;

array[1..160,1..2] of SLOTS: lectures_combinations; % possible combinations of lectures, theory and lab

% comulative vars
int: classes = c * g;
int: combinations = c * g * 2;
set of int: CLASSES = 1..classes;
array[1..combinations] of var int: s = [schedule[course,group,lecture] | course in C, group in G, lecture in 0..1];
array[CLASSES] of var int: stheory = [schedule[course,group,0] | course in C, group in G ];
array[CLASSES] of var int: slabs = [schedule[course,group,1] | course in C, group in G ];
array[CLASSES] of int: durations = [1| i in CLASSES]; % lectures duration

array[C,G,0..1] of var SLOTS: schedule;  % final schedule; 0 = theory, 1 = labs

% output
array[1..d] of string: days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

% For every course and group, its two lectures have to be scheduled on different days and the lab has to be scheduled after the theory
constraint forall(course in C, group in G)
                 (table([schedule[course, group, 0], schedule[course, group, 1]], lectures_combinations));

% At every time slot, there must be enough lecture rooms and lecturers available for the scheduled lectures.
constraint cumulative(stheory, durations, [1| i in 1..classes], nt) /\ cumulative(slabs, durations, [1| i in 1..classes], nl) ;

constraint forall(course in C)
                 (
                  cumulative(s, [1| i in 1..combinations],[1| i in 1..combinations], NT[course])
                 );

% In order to allow students to attend to all the courses, and assuming that enrollment is based on groups, for every group there cannot be any %overlapping among its lectures (e.g. no overlapping of any lecture of group 1, 3,...,g)
constraint forall(group in G, lecture in 0..1)
                 (alldifferent([ schedule[course,group,lecture] | course in C ]));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%symetry breaking

% constraint forall(course in C, group in 1..g-1, lecture in 0..1)
%                  (schedule[course,group,lecture] > schedule[course,group+1,lecture] );

% constraint forall(course in 1..c-1, group in G, lecture in 0..1)
%                  (schedule[course,group,lecture] < schedule[course+1,group,lecture] );

solve satisfy;

output[show("SCHEDULE")] ++ ["\n"] ++ 
      [ "c" ++ show(course) ++ "g" ++ show(group) ++ 
      if lecture == 0 then
        " Theory   "
      else
        " Lab      "
      endif
      ++ 
      show(days[(schedule[course,group,lecture] - 1) div (end-ini+1) + 1]) ++ " " ++
      show((schedule[course,group,lecture] - 1) mod (end-ini+1) + ini) ++ ":00" ++ "\n"
      | course in C, group in G, lecture in 0..1];
