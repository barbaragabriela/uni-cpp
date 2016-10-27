##Symmetry Breaking
###The social golfers problem as a case study

#### Model 1: array[G,S,W] of var P: X;
With 3 constraints = 72

Without Player permutations and in-group permutations constraint = 8640  
Without Group permutations constraint = 4608  
Without Week permutations constraint = 2592  

Without Group and Week permutations constraints = 1558224  
Without Week and Player permutations and in-group permutations constraints = 363540  
Without Group and Player permutations and in-group permutations constraints = 1781173  

Without **all** constraints = 2355408


#### Model 2: array[P,W] of var G: X;

With 2 constraints = 289  
With 1 constraint = 2592  

Without **all** constraints = 2444004



#### Model 3: array[G,W] of var set of P: X;
