package proyecto;

import java.util.ArrayList;

import org.opt4j.core.Objectives;
import org.opt4j.core.Objective.Sign;
import org.opt4j.core.problem.Evaluator;

public class ProyectoEvaluator implements Evaluator<ArrayList<Integer>> {

    private static final int MINIMUM_ASSIGNMENT_IN_ONE_TURN = 3;
    
    @Override
	public Objectives evaluate(ArrayList<Integer> phenotype) {

        int cost = 0;
        int productivity = 0;

        if (areTurnsFullyAssigned(phenotype)) {

            for (int i = 0; i < phenotype.size(); i++) {

            	cost += Datos.matrizCostes[phenotype.get(i) - 1][i];
            	productivity += Datos.matrizProductividad[phenotype.get(i) -1][i];
			}

        } else {

            cost = Integer.MAX_VALUE;
            productivity = 0;
        }

        Objectives objectives = new Objectives();
		objectives.add("Coste-Min", Sign.MIN, Math.abs(cost));
		objectives.add("Productividad-MAX", Sign.MAX, productivity);
		
		return objectives;
    }

    private boolean areTurnsFullyAssigned(ArrayList<Integer> phenotype) {
        
        int turnsAssignment[] = new int[4];

        for (int i = 0; i < phenotype.size(); i++) {

			turnsAssignment[phenotype.get(i)]++;
		}

        for (int i = 1; i < turnsAssignment.length; i++) {

            if (turnsAssignment[i] < MINIMUM_ASSIGNMENT_IN_ONE_TURN) {

                return false;
            }
        }

        return true;
    }
}
