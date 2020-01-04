package proyecto;

import java.util.Random;

import org.opt4j.core.genotype.IntegerGenotype;
import org.opt4j.core.problem.Creator;

public class ProyectoCreator implements Creator<IntegerGenotype> {
	
	public IntegerGenotype create() {
		
		IntegerGenotype genotipo = new IntegerGenotype(1, Datos.NUM_TURNOS);
		genotipo.init(new Random(), Datos.NUM_CUADRILLAS);
		
		return genotipo;	
	}
}
