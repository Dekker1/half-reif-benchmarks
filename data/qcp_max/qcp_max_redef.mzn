% QCP max problem.

include "globals.mzn";

var 0..2*n : obj;
int: n; % size
array[1..n*n] of 0..n: s; % 0 = unfixed 1..n = fixed
array[1..n,1..n] of 0..n: s2 = array2d(1..n, 1..n, s);

array[1..n,1..n] of var 1..n: q; % qcp array;

predicate my_all_different_reif(array[int] of var int: x, var bool: r) =
  r <-> forall(i,j in index_set(x) where i < j) ( x[i] != x[j] );

constraint forall(i,j in 1..n where s2[i,j] > 0)(q[i,j] = s2[i,j]);

constraint obj <= sum(i in 1..n)(
  let {
    array[1..2] of var bool: b;
    constraint my_all_different_reif([q[j,i] | j in 1..n], b[1]);
    constraint my_all_different_reif([q[i,j] | j in 1..n], b[2]);
  } in bool2int(b[1]) + bool2int(b[2])
);

solve ::int_search([obj] ++ [q[i, j] | i in 1..n, j in 1..n], input_order, 
  indomain_max, complete ) maximize obj;

output [
  "obj = " ++ show(obj) ++ "\n",
  "q = " ++ show(q) ++ "\n",
];
