package proyecto;

import org.opt4j.core.problem.Decoder;

public class ProyectoDecoder implements Decoder<IntegerGenotype, ArrayList<Integer>> {
    
    @Override
	public ArrayList<Integer> decode(IntegerGenotype genotype) {

		ArrayList<Integer> phenotype = new ArrayList<>();
		
		for (int i = 0; i < genotype.size(); i++) {

			phenotype.add(genotype.get(id));
		}

		return phenotype;
	}
}
