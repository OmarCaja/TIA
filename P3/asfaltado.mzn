include "alldifferent.mzn";

int: layers = 9;
int: a = 1;
int: b = 2;

array[a..b, 1..layers] of var 1..(layers*2): layerPosition;

constraint alldifferent(layerPosition);

% A constraint.
constraint (layerPosition[a,2] != 1 + layerPosition[a,1] /\ layerPosition[a,2] != 1 - layerPosition[a,1]);
constraint (layerPosition[a,2] != 1 + layerPosition[a,5] /\ layerPosition[a,2] != 1 - layerPosition[a,5]);
constraint (layerPosition[a,2] != 1 + layerPosition[a,9] /\ layerPosition[a,2] != 1 - layerPosition[a,9]);
constraint (layerPosition[a,2] != 1 + layerPosition[b,4] /\ layerPosition[a,2] != 1 - layerPosition[b,4]);

% B constraint.
constraint forall(i in 1..layers where i!=7) (layerPosition[a,7] != 1 + layerPosition[a,i] /\ layerPosition[a,7] != 1 - layerPosition[a,i]);

% C constraint.
constraint (layerPosition[a,4] > abs(4 + layerPosition[b,4]) \/ layerPosition[a,4] < abs(4 - layerPosition[b,4]));

% D constraint.
constraint (layerPosition[a,8] = 2 + layerPosition[b,8] \/ layerPosition[a,8] = 2 - layerPosition[b,8]);

% E constraint.
constraint (layerPosition[a,5] = 1 + layerPosition[b,5] \/ layerPosition[a,5] = 1 - layerPosition[b,5]);

% F constraint.
constraint (layerPosition[a,4] = 1 + layerPosition[a,1] \/ layerPosition[a,4] = 1 - layerPosition[a,1] \/ 
            layerPosition[a,4] = 1 + layerPosition[b,1] \/ layerPosition[a,4] = 1 - layerPosition[b,1] \/ 
            layerPosition[a,4] = 1 + layerPosition[a,9] \/ layerPosition[a,4] = 1 - layerPosition[a,9] \/ 
            layerPosition[a,4] = 1 + layerPosition[b,9] \/ layerPosition[a,4] = 1 - layerPosition[b,9]);

% G constraint.
constraint (layerPosition[a,6] != 1 + layerPosition[a,7] /\ layerPosition[a,6] != 1 - layerPosition[a,7]);

% H constraint.
constraint (layerPosition[a,5] = 1 + layerPosition[b,4] \/ layerPosition[a,5] = 1 - layerPosition[b,4] \/
            layerPosition[a,5] = 1 + layerPosition[b,8] \/ layerPosition[a,5] = 1 - layerPosition[b,8] \/
            layerPosition[a,5] = 1 + layerPosition[a,2] \/ layerPosition[a,5] = 1 - layerPosition[a,2] \/
            layerPosition[a,5] = 1 + layerPosition[a,3] \/ layerPosition[a,5] = 1 - layerPosition[a,3] \/
            layerPosition[a,5] = 1 + layerPosition[a,7] \/ layerPosition[a,5] = 1 - layerPosition[a,7]);

constraint (layerPosition[b,5] != 1 + layerPosition[a,6] /\ layerPosition[b,5] != 1 - layerPosition[a,6]);

% I constraint.
constraint forall(i in 1..(layers - 1)) (layerPosition[a,i] < layerPosition[a,i + 1]);

% J constraint.
constraint forall(i in 1..(layers - 4)) (layerPosition[b,i] > layerPosition[b,i + 1]);

% Sol 1.
solve minimize abs(layerPosition[a,8] - layerPosition[a,9]) + abs(layerPosition[b,1] - layerPosition[b,2]);

% Sol 2.
solve maximize (layers * 2 - abs(layerPosition[a,7] - layerPosition[b,7])) + abs(layerPosition[a,3] - layerPosition[b,9]);

output["Layer A mode positions: "] ++ [(show(layerPosition[a,i]) ++ " ") | i in 1..layers] ++
      ["\n"] ++
      ["Layer B mode positions: "] ++ [(show(layerPosition[b,i]) ++ " ") | i in 1..layers];
