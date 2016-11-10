# Channeling

### Solitare practice

The goal was to output the wining stack of a solution of the game.

The input is a shuffled deck devided in 17 stacks, 3 cards each.

```
layout = array2d(1..17,1..3, [
31, 30, 8, 
45, 50, 19, 
37, 12, 47, 
24, 9, 18, 
16, 40, 20, 
38, 36, 49, 
11, 33, 51, 
39, 10, 14, 
3, 27, 46, 
29, 2, 35, 
4, 32, 17, 
15, 13, 5, 
23, 34, 28, 
48, 21, 52, 
22, 6, 42, 
44, 41, 26, 
25, 43, 7
]);
```



### Constraints

Four constraint were written:

- the first element of the stack should be an A

  ` constraint inverse(stack,moment);`

- Applying channeling with inverse

  `constraint inverse(stack,moment);`

- for every stack of the input, check that the values precede in the final stack

  ```
  constraint forall(i in 1..piles)
  			(forall(j in 1..2)
                (value_precede(input[i,j], input[i,j+1], stack))
              );
  ```

- In order for a card to be placed in stack, it must be a rank higher or lower than the top card on the stack, we achieve that with the matrix 'possible_moves'.

  ```
  constraint forall(i in 1..n-1)
               (table([stack[i], stack[i+1]], possible_moves));
  ```



### Times

|                                          | time     |
| ---------------------------------------- | -------- |
| all constraints                          | ~3200ms  |
| instead of value procede, use channeling* | ~25500ms |

```
constraint forall(i in 1..piles, j in 1..2)
                 (moment[input[i,j]] < moment[input[i,j+1]]);
```

