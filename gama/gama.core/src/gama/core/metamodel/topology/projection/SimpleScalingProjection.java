/*******************************************************************************************************
 *
 * SimpleScalingProjection.java, in gama.core, is part of the source code of the
 * GAMA modeling and simulation platform .
 *
 * (c) 2007-2024 UMI 209 UMMISCO IRD/SU & Partners (IRIT, MIAT, TLU, CTU)
 *
 * Visit https://github.com/gama-platform/gama for license information and contacts.
 * 
 ********************************************************************************************************/
package gama.core.metamodel.topology.projection;


import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.opengis.referencing.operation.MathTransform;

import gama.core.common.geometry.Envelope3D;
import gama.core.runtime.IScope;

import org.locationtech.jts.geom.CoordinateFilter;
import org.locationtech.jts.geom.Geometry;

/**
 * The Class SimpleScalingProjection.
 */
public class SimpleScalingProjection implements IProjection{

	/** The inverse scaling. */
	public CoordinateFilter scaling, inverseScaling;

	@Override
	public void createTransformation(MathTransform t) {
		
	}
	
	/**
	 * Instantiates a new simple scaling projection.
	 *
	 * @param scale the scale
	 */
	public SimpleScalingProjection(Double scale) {
		if (scale != null) {
			createScalingTransformations(scale);
		}
		
	}

	@Override
	public Geometry transform(Geometry geom) {
		if (scaling != null) {
			geom.apply(scaling);
			geom.geometryChanged();
		}
		return geom;
	}

	@Override
	public Geometry inverseTransform(Geometry geom) {
		if (inverseScaling != null) {
			geom.apply(inverseScaling);
			geom.geometryChanged();
		}
		return geom;
	}
	
	/**
	 * Creates the scaling transformations.
	 *
	 * @param scale the scale
	 */
	public void createScalingTransformations(final Double scale) {
		scaling = coord -> {
			coord.x *= scale;
			coord.y *= scale;
			coord.z *= scale;
		};
		inverseScaling = coord -> {
			coord.x /= scale;
			coord.y /= scale;
			coord.z /= scale;
		};
	}

	@Override
	public CoordinateReferenceSystem getInitialCRS(IScope scope) {
		return null;
	}

	@Override
	public CoordinateReferenceSystem getTargetCRS(IScope scope) {
		return null;
	}

	@Override
	public Envelope3D getProjectedEnvelope() {
		return null;
	}

	@Override
	public void translate(Geometry geom) {
		
	}

	@Override
	public void inverseTranslate(Geometry geom) {
		
	}

	@Override
	public void convertUnit(Geometry geom) {
	}

	@Override
	public void inverseConvertUnit(Geometry geom) {
		
	}

}
