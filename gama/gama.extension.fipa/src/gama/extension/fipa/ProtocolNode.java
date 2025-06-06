/*******************************************************************************************************
 *
 * ProtocolNode.java, in gama.extension.fipa, is part of the source code of the
 * GAMA modeling and simulation platform .
 *
 * (c) 2007-2024 UMI 209 UMMISCO IRD/SU & Partners (IRIT, MIAT, TLU, CTU)
 *
 * Visit https://github.com/gama-platform/gama for license information and contacts.
 * 
 ********************************************************************************************************/
package gama.extension.fipa;

import static org.jgrapht.Graphs.successorListOf;

/**
 * The Class ProtocolNode.
 */
public class ProtocolNode {

	/** Performative to be used for this branch. */
	private Performative performative;

	/** Initiator should send performative at this node?. */
	private boolean sentByInitiator;

	/** The protocol. */
	private final FIPAProtocol protocol;

	/**
	 * Instantiates a new protocol node.
	 */

	public ProtocolNode(FIPAProtocol protocol, Performative perf, boolean initiator) {
		this.protocol = protocol;
		performative = perf;
		sentByInitiator = initiator;
	}

	/**
	 * Gets the performative.
	 *
	 * @return the performative
	 */
	public Performative getPerformative() {
		return performative;
	}

	/**
	 * Checks if is sent by initiator.
	 *
	 * @return the sentByInitiator
	 */
	public boolean isSentByInitiator() {
		return sentByInitiator;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return ("Protocol node for " + performative + " sent by initiator = " + sentByInitiator + " with "
				+ successorListOf(protocol, this).size() + " following nodes");
	}

	/**
	 * Checks if is terminal.
	 *
	 * @return true, if is terminal
	 */
	public boolean isTerminal() {
		return successorListOf(protocol, this).isEmpty();
	}

}
