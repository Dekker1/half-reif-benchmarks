% Prize collecting problem.
%
int: n; % size
array[1..n,  0..n] of int: p;

array[1..n] of var 0..n: next;% next posn in tour : 
                              % 1 for last edge, 0 for unused

array[1..n] of var 0..n: pos; % posn of node i in path, 0 = notin

constraint pos[1] = 1;

constraint forall(i in 1..n) (
  let {
    var bool: b;
    constraint array_var_int_element_imp(next[i], pos, pos[i]+1, b);
  } in (pos[i] > 0 <-> next[i] > 0) /\ (next[i] > 1 -> b)
);

constraint all_different_except_0(next);

predicate all_different_except_0(array[int] of var int: x) =
  forall(i in index_set(x)) (
    x[i] = 0 \/ forall(j in index_set(x) where j > i)(x[i] != x[j])
  );
solve 
  :: seq_search([
    int_search(next, largest, indomain_max, complete),
    int_search(pos, largest, indomain_max, complete)])
  maximize sum(i in 1..n)(p[i, next[i]]);

output 
  [ "next =" ++ show(next) ++ "\n", 
    "pos =" ++ show(pos) ++ "\n",
    "obj =" ++ show(sum(i in 1..n)(p[i, next[i]])) ++ "\n"
  ];
