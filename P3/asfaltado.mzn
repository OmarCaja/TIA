int layers = 9;

array[1..layers] of set of 1..(layers*2): layerAMode;
array[1..layers] of set of 1..(layers*2): layerBMode;

constraint forall(i in 1..layers) (layerAMode[i] != layerBMode[i]);

% A constraint.
constraint (layerAMode[2] + 1 != layerAMode[1] /\ layerAMode[2] - 1 != layerAMode[1]):
constraint (layerAMode[2] + 1 != layerAMode[5] /\ layerAMode[2] - 1 != layerAMode[5]);
constraint (layerAMode[2] + 1 != layerAMode[9] /\ layerAMode[2] - 1 != layerAMode[9]);
constraint (layerAMode[2] + 1 != layerBMode[4] /\ layerAMode[2] - 1 != layerBMode[4]);

% B constraint.
constraint forall(i in 1..layers where i!=7) (layerAMode[7] + 1 != layerAMode[i] /\ layerAMode[7] - 1 != layerAMode[i]);

% C constraint.
constraint (layerAMode[4] > 4 + layerBMode[4] \/ layerAMode[4] < 4 - layerBMode[4]);

% D constraint.
constraint (layerAMode[8] > 1 + layerBMode[8] \/ layerAMode[8] < 1 - layerBMode[8]);

% E constraint.
constraint (layerAMode[5] = 1 + layerBMode[5] \/ layerAMode[5] = 1 - layerBMode[5]);

% F constraint.
constraint (layerAMode[4] = 1 + layerAMode[1] \/ layerAMode[4] = 1 - layerAMode[1] \/ layerAMode[4] = 1 + layerBMode[1] \/ layerAMode[4] = 1 - layerMode[1] \/ layerAMode[4] = 1 + layerAMode[9] \/ layerAMode[4] = 1 - layerAMode[9] \/ layerAMode[4] = 1 + layerBMode[9] \/ layerAMode[4] = 1 - layerMode[9]);

% G constraint.
constraint (layerAMode[6] != 1 + layerAMode[7] \/ layerAMode[6] != 1 - layerAMode[7]);

% H constraint.
constraint (layerAMode[5] = 1 + layerBMode[4] \/ layerAMode[5] = 1 - layerBMode[4] \/ layerAMode[5] = 1 + layerBMode[8] \/ layerAMode[5] = 1 - layerBMode[8] \/ \/ layerAMode[5] = 1 - layerBMode[4] \/ layerAMode[5] = 1 + layerAMode[2] \/ layerAMode[5] = 1 - layerAMode[2] \/ layerAMode[5] = 1 + layerAMode[3] \/ layerAMode[5] = 1 - layerAMode[3] \/ layerAMode[5] = 1 + layerAMode[7] \/ layerAMode[5] = 1 - layerAMode[7]);
constraint (layerBMode[5] = 1 + layerAMode[6] \/ layerBMode[5] = 1 - layerAMode[6]);

% I Constraint.
constraint forall(i in 1..(layers - 1)) (layerAMode[i] < layerAMode[i + 1]);

% J Constraint.
constraint forall(i in 1..(layers - 4)) (layerBMode[i] > layerBMode[i + 1]);

% Sol 1.
solve minimize abs(layerAMode[8] - layerAMode[9]) + abs(layerBMode[1] - layerBMode[2]);

% Sol 2.
solve maximize (layers * 2 - (layerAMode[7] - layerBMode[7])) + (layerAMode[3] - layerBMode[9]);

output["Layer A mode positions: "] ++ [(show(layerAMode[i]) ++ " ") | i in 1..layers] ++
      ["\n"] ++
      ["Layer B mode positions: "] ++ [(show(layerBMode[i]) ++ " ") | i in 1..layers];
