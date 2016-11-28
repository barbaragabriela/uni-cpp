int: n;
set of int: DOM = 1..n;
int: m;
set of int: COD = 1..m;
array[DOM,COD] of int: profit;

% what are the decisions?
array[DOM] of var COD: task;

%constraint forall(t in COD)
%                 (sum(w in DOM)
%                     (bool2int(task[w] = t)) <= 1);

constraint forall(w1, w2 in DOM where w1 < w2)
                (task[w1] != task[w2]);

% whats the objective?
maximize sum(w in DOM)
            (profit[w,task[w]]);