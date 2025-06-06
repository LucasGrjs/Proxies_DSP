/*******************************************************************************************************
 *
 * SpeciesFactory.java, in gama.core, is part of the source code of the GAMA modeling and simulation platform
 * .
 *
 * (c) 2007-2024 UMI 209 UMMISCO IRD/SU & Partners (IRIT, MIAT, TLU, CTU)
 *
 * Visit https://github.com/gama-platform/gama for license information and contacts.
 *
 ********************************************************************************************************/
package gama.gaml.factories;

import java.util.Set;

import org.eclipse.emf.ecore.EObject;

import gama.gaml.compilation.IAgentConstructor;
import gama.gaml.descriptions.IDescription;
import gama.gaml.descriptions.SpeciesDescription;
import gama.gaml.descriptions.SymbolProto;
import gama.gaml.descriptions.TypeDescription;
import gama.gaml.statements.Facets;

/**
 * SpeciesFactory.
 *
 * @author drogoul 25 oct. 07
 */

// @factory (
// handles = { SPECIES })
@SuppressWarnings ({ "rawtypes" })
public class SpeciesFactory extends SymbolFactory {

	@Override
	protected TypeDescription buildDescription(final String keyword, final Facets facets, final EObject element,
			final Iterable<IDescription> children, final IDescription sd, final SymbolProto proto) {
		return new SpeciesDescription(keyword, null, (SpeciesDescription) sd, null, children, element, facets);
	}

	/**
	 * Creates a new Species object.
	 *
	 * @param name
	 *            the name
	 * @param clazz
	 *            the clazz
	 * @param superDesc
	 *            the super desc
	 * @param parent
	 *            the parent
	 * @param helper
	 *            the helper
	 * @param skills
	 *            the skills
	 * @param userSkills
	 *            the user skills
	 * @param plugin
	 *            the plugin
	 * @return the species description
	 */
	public SpeciesDescription createBuiltInSpeciesDescription(final String name, final Class clazz,
			final SpeciesDescription superDesc, final SpeciesDescription parent, final IAgentConstructor helper,
			final Set<String> skills, final Facets userSkills, final String plugin) {
		DescriptionFactory.addSpeciesNameAsType(name);
		return new SpeciesDescription(name, clazz, superDesc, parent, helper, skills, userSkills, plugin);
	}

}
