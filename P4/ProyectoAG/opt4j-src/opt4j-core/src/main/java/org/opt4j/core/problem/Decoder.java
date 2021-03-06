/*******************************************************************************
 * Copyright (c) 2014 Opt4J
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *******************************************************************************/


package org.opt4j.core.problem;

import org.opt4j.core.Genotype;

/**
 * The {@link Decoder} decodes {@link Genotype}s into phenotype {@link Object}s.
 * 
 * @author glass, lukasiewycz
 * @see Genotype
 * @param <G>
 *            the type of genotype that is decoded
 * @param <P>
 *            the type of the resulting phenotype}
 */
public interface Decoder<G extends Genotype, P extends Object> {

	/**
	 * Decodes a given {@link Genotype} to the corresponding phenotype.
	 * 
	 * @param genotype
	 *            the genotype to decode
	 * @return the decoded phenotype
	 */
	public P decode(G genotype);

}
