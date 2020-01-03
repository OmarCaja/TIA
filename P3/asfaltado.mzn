include "alldifferent.mzn";

int: layers = 9;
int: a = 1;
int: b = 2;

array[a..b] of var 1..(layers*2): layerMode;

constraint alldifferent(layerMode);

% A constraint.
constraint (layerMode[a,2] != 1 + layerMode[a,1] /\ layerMode[a,2] != 1 - layerMode[a,1]);
constraint (layerMode[a,2] != 1 + layerMode[a,5] /\ layerMode[a,2] != 1 - layerMode[a,5]);
constraint (layerMode[a,2] != 1 + layerMode[a,9] /\ layerMode[a,2] != 1 - layerMode[a,9]);
constraint (layerMode[a,2] != 1 + layerMode[b,4] /\ layerMode[a,2] != 1 - layerMode[b,4]);

% B constraint.
constraint forall(i in 1..layers where i!=7) (layerMode[a,7] != 1 + layerMode[a,i] /\ layerMode[a,7] != 1 - layerMode[a,i]);

% C constraint.
constraint (layerMode[a,4] > 4 + layerMode[b,4] /\ layerMode[a,4] < 4 - layerMode[b,4]);

% D constraint.
constraint (layerMode[a,8] = 2 + layerMode[b,8] \/ layerMode[a,8] = 2 - layerMode[b,8]);

% E constraint.
constraint (layerMode[a,5] = 1 + layerMode[b,5] \/ layerMode[a,5] = 1 - layerMode[b,5]);

% F constraint.
constraint (layerMode[a,4] = 1 + layerMode[a,1] \/ layerMode[a,4] = 1 - layerMode[a,1] \/ 
            layerMode[a,4] = 1 + layerMode[b,1] \/ layerMode[a,4] = 1 - layerMode[b,1] \/ 
            layerMode[a,4] = 1 + layerMode[a,9] \/ layerMode[a,4] = 1 - layerMode[a,9] \/ 
            layerMode[a,4] = 1 + layerMode[b,9] \/ layerMode[a,4] = 1 - layerMode[b,9]);

% G constraint.
constraint (layerMode[a,6] != 1 + layerMode[a,7] /\ layerMode[a,6] != 1 - layerMode[a,7]);

% H constraint.
constraint (layerMode[a,5] = 1 + layerMode[b,4] \/ layerMode[a,5] = 1 - layerMode[b,4] \/
            layerMode[a,5] = 1 + layerMode[b,8] \/ layerMode[a,5] = 1 - layerMode[b,8] \/
            layerMode[a,5] = 1 - layerMode[a,2] \/ layerMode[a,5] = 1 + layerMode[a,2] \/
            layerMode[a,5] = 1 - layerMode[a,3] \/ layerMode[a,5] = 1 + layerMode[a,3] \/
            layerMode[a,5] = 1 - layerMode[a,7] \/ layerMode[a,5] = 1 + layerMode[a,7]);

constraint (layerMode[b,5] != 1 + layerMode[a,6] /\ layerMode[b,5] != 1 - layerMode[a,6]);

% I constraint.
constraint forall(i in 1..(layers - 1)) (layerMode[a,i] < layerMode[a,i + 1]);

% J constraint.
constraint forall(i in 1..(layers - 4)) (layerMode[b,i] > layerMode[b,i + 1]);

% Sol 1.
solve minimize abs(layerMode[a,8] - layerMode[a,9]) + abs(layerMode[b,1] - layerMode[b,2]);

% Sol 2.
solve maximize (layers * 2 - abs(layerMode[a,7] - layerMode[b,7])) + abs(layerMode[a,3] - layerMode[b,9]);

output["Layer A mode positions: "] ++ [(show(layerMode[a,i]) ++ " ") | i in 1..layers] ++
      ["\n"] ++
      ["Layer B mode positions: "] ++ [(show(layerMode[b,i]) ++ " ") | i in 1..layers];
