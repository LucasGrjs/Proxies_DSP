/*******************************************************************************************************
 *
 * SelectionBest.java, in gama.core, is part of the source code of the
 * GAMA modeling and simulation platform .
 *
 * (c) 2007-2024 UMI 209 UMMISCO IRD/SU & Partners (IRIT, MIAT, TLU, CTU)
 *
 * Visit https://github.com/gama-platform/gama for license information and contacts.
 * 
 ********************************************************************************************************/

package gama.core.kernel.batch.optimization.genetic;

import static java.lang.Double.compare;
import static one.util.streamex.StreamEx.of;

import java.util.Collections;
import java.util.List;

import gama.core.runtime.IScope;

/**
 * The Class SelectionBest.
 */
public class SelectionBest implements Selection {

	/**
	 * Instantiates a new selection best.
	 */
	public SelectionBest() {}

	@Override
	public List<Chromosome> select(final IScope scope, final List<Chromosome> population, final int populationDim,
			final boolean maximize) {

		final List<Chromosome> nextGen =
				of(population).sorted((e1, e2) -> compare(e1.getFitness(), e2.getFitness())).toList();
		if (maximize) {
			Collections.reverse(nextGen);
		}
		if (nextGen.size() > populationDim)
			return nextGen.subList(0, populationDim - 1);
		return nextGen;
	}
}
