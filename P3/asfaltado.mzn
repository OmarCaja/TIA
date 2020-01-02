int layers = 9;

array[1..layers] of set of 1..(layers*2): layerAMode;
array[1..layers] of set of 1..(layers*2): layerAMode;

constraint forall(i in 1..layers) (layerAMode[i] != layerAMode[i]);

% A constraint.
constraint (layerAMode[2] + 1 != layerAMode[1] /\ layerAMode[2] - 1 != layerAMode[1])
constraint (layerAMode[2] + 1 != layerAMode[5] /\ layerAMode[2] - 1 != layerAMode[5])
constraint (layerAMode[2] + 1 != layerAMode[9] /\ layerAMode[2] - 1 != layerAMode[9])
constraint (layerAMode[2] + 1 != layerBMode[4] /\ layerAMode[2] - 1 != layerBMode[4])
