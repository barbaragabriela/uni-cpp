# Symmetries

## X[G,S,W] model

For this model, constraints on how to build the model were given. The results for a small instance `gr = 3; sz = 3; we = 3;` and applying a time limit of 5 minutes are the following:

|              X[i,j,k]               |     3     |    4     |
| :---------------------------------: | :-------: | :------: |
|         without constraints         | 1,131,263 | 176,054  |
|      player permutations const      | 1,425,074 | 240,636  |
|     in-group permutations const     |  245,804  |  19,488  |
|      group permutations const       | 1,252,317 | 208,499  |
|       week permutations const       | 1,318,261 | 227,851  |
|      breaking player and group      | 1,622,365 | 265,279  |
|    breaking player and in-group     |   2592*   |  29,664  |
|      breaking player and week       | 1,405,556 |  14,357  |
| breaking player, in-group and group |    72*    | 165,888* |
|     **breaking all symmetries**     |    36*    | 27,648*  |


`* means the solver didn't need 5 minutes to find the solutions`

As we can see there is a huge difference between the size of the instances, for a smaller size, it works well with all the symmetry breaking but as we go removing one or another the solutions increase hugely.



## Model X[P,W]

For this model, which in my opinion was the hardest, the goal was to build the group schedule as in model 1. More constraints were needed to build it (1). 

For me breaking the symmetries was hard and eventually I gave up because what I was doing was limiting the size of search instead of actually breaking symmetries. I could only break correctly the one about player permutations.



|                X[P,W]                |    3    |    4    |
| :----------------------------------: | :-----: | :-----: |
|         without constraints          | 650,505 |    0    |
| breaking player permutation symmetry |  2592*  | 258,450 |

`* means the solver didn't need 5 minutes to find the solutions`

For this model and a bigger instance (4), without any symmetry breaking it is taking more than 5 minutes to even find one solution.

## Model X[G,W]

This model is really similar to the first one, but using sets. I build the model using three constraints and found all the symmetry breaks.

|                X[G,W]                |    3     |   4   |
| :----------------------------------: | :------: | :---: |
|         without constraints          | 924,192  |   0   |
| breaking player permutation symmetry |  2,592*  | 4,964 |
|     breaking group permutations      | 20,160*  |   0   |
|      breaking week permutation       | 725,760* |   0   |
|      breaking player and group       |   72*    | 2,904 |
|       breaking player an week        |  1,296*  | 3,826 |
|       breaking group and week        |  3,360*  |   0   |
|      **all symmetry breaking**       |   36*    | 1,152 |

`* means the solver didn't need 5 minutes to find the solutions`

This model was quicker for the smaller instance (3), but really slow or even didn't get a sollution in less than 5 minutes for an instance of size 4.

For an instance of size 3, geocode solve almost all the combinations of constraints in less than 5 minutes.

## Conclusion

For this specific problem, at first, I thought the model X[G,W] was better because for an instance of size 3, almost all constraint combinations got solutions in less than 5 minutes. But actually what the organizer of a golf club would like is an actual solution to his problem, and model X[G,S,W] gives actual solutions for the two instances (3 and 4), yes to get all the solutions it will take more than 5 minutes, but he doesn't care how many solutions but he wans A solution.


**NOTE:** Some of the symmetries measures where running in parallel and when running alone acutally got more solutions faster. :hm: