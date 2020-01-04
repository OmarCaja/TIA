package proyecto;

import java.util.Random;

import org.opt4j.core.genotype.IntegerGenotype;
import org.opt4j.core.problem.Creator;

public class ProyectoCreator implements Creator<IntegerGenotype> {
	
    @Override
	public IntegerGenotype create() {
		
		IntegerGenotype genotype = new IntegerGenotype(1, Datos.NUM_TURNOS);
		genotype.init(new Random(), Datos.NUM_CUADRILLAS);
		
		return genotype;	
	}
}
