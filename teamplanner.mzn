int: m; % missions to be done
set of int: MISSION = 1..m;

int: n; % number of people
set of int: PERSONS = 1..n;

array[1..m] of int: lm; % minimum missions per person
array[1..m] of int: um; % max size of team

array[1..n] of int: lp; % minimum missions per person
array[1..n] of int: up; % max missions per person

%set of 1..n: teams; % card from lp to up
array[1..m] of var set of PERSONS: missions;

array[1..m] of var int: missions_card = [card(missions[j]) | j in 1..m];
array[1..n] of var int: persons_by_mission_card = [sum(j in MISSION) (card({i} intersect missions[j])) | i in PERSONS];

% Each mission mi requires a team of people of size at least lmi and at most umi
constraint forall(i in MISSION)
                (missions_card[i] >= lm[i] /\ missions_card[i] <= um[i]);

% Each person pi has to participate in at least lpi missions and at most upi missions
constraint forall(i in PERSONS)
                 (persons_by_mission_card[i] >= lp[i] /\ persons_by_mission_card[i] <= up[i]);
%                 (sum(j in MISSION) (card({i} intersect missions[j])) >= lp[i] /\ sum(j in MISSION) (card({i} intersect missions[j])) <= up[i]);

% for any pair of missions %there must be exactly one person that participates in both of them
constraint forall(i, j in MISSION where i<j)
                (card(missions[i] intersect missions[j]) == 1);

solve satisfy;

output ["Mission "++ show(i) ++ ": " ++ show(missions[i]) ++ "\n"| i in MISSION];
