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
 

package org.opt4j.operators.crossover;

import org.opt4j.core.common.random.Rand;
import org.opt4j.operators.normalize.NormalizeDouble;

import com.google.inject.Inject;

/**
 * The {@link CrossoverDoubleDefault} is a {@link CrossoverDoubleSBX} with
 * {@code nu=15}.
 * 
 * @author lukasiewycz
 * 
 */
public class CrossoverDoubleDefault extends CrossoverDoubleSBX {

	/**
	 * Constructs a new {@link CrossoverDoubleSBX} with {@code nu=15}.
	 * 
	 * @param normalize
	 *            the normalize operator
	 * @param random
	 *            the random number generator
	 */
	@Inject
	public CrossoverDoubleDefault(NormalizeDouble normalize, Rand random) {
		super(15, normalize, random);
	}

}
