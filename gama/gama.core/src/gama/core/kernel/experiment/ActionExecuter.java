/*******************************************************************************************************
 *
 * ActionExecuter.java, in gama.core, is part of the source code of the GAMA modeling and simulation platform
 * .
 *
 * (c) 2007-2024 UMI 209 UMMISCO IRD/SU & Partners (IRIT, MIAT, TLU, CTU)
 *
 * Visit https://github.com/gama-platform/gama for license information and contacts.
 *
 ********************************************************************************************************/
package gama.core.kernel.experiment;

import java.util.Collection;
import java.util.concurrent.CopyOnWriteArrayList;

import gama.core.runtime.IScope;
import gama.dev.DEBUG;
import gama.gaml.statements.IExecutable;

/**
 * The Class ActionExecuter.
 */
public class ActionExecuter {
	
	static
	{
		DEBUG.OFF();
	}

	/** The Constant BEGIN. */
	private static final int BEGIN = 0;

	/** The Constant END. */
	private static final int END = 1;

	/** The Constant DISPOSE. */
	private static final int DISPOSE = 2;

	/** The Constant ONE_SHOT. */
	private static final int ONE_SHOT = 3;

	/** The actions. */
	@SuppressWarnings ("unchecked") final Collection<IExecutable>[] actions =
			new Collection[] { new CopyOnWriteArrayList<>(), new CopyOnWriteArrayList<>(), new CopyOnWriteArrayList<>(),
					new CopyOnWriteArrayList<>() };

	/** The scope. */
	protected final IScope scope;

	/**
	 * Instantiates a new action executer.
	 *
	 * @param scope
	 *            the scope
	 */
	public ActionExecuter(final IScope scope) {
		this.scope = scope.copy("of ActionExecuter");
	}

	/**
	 * Insert action.
	 *
	 * @param action
	 *            the action
	 * @param type
	 *            the type
	 * @return the i executable
	 */
	private IExecutable insertAction(final IExecutable action, final int type) {
		if (actions[type].add(action)) return action;
		return null;
	}

	/**
	 * Insert dispose action.
	 *
	 * @param action
	 *            the action
	 * @return the i executable
	 */
	public IExecutable insertDisposeAction(final IExecutable action) {
		return insertAction(action, DISPOSE);
	}

	/**
	 * Insert end action.
	 *
	 * @param action
	 *            the action
	 * @return the i executable
	 */
	public IExecutable insertEndAction(final IExecutable action) {
		return insertAction(action, END);
	}

	/**
	 * Insert one shot action.
	 *
	 * @param action
	 *            the action
	 * @return the i executable
	 */
	public IExecutable insertOneShotAction(final IExecutable action) {
		return insertAction(action, ONE_SHOT);
	}

	/**
	 * Execute end actions.
	 */
	public void executeEndActions() {
		if (scope.interrupted()) return;
		executeActions(END);
	}

	/**
	 * Execute dispose actions.
	 */
	public void executeDisposeActions() {
		executeActions(DISPOSE);
	}

	/**
	 * Execute one shot actions.
	 */
	public void executeOneShotActions() {
		DEBUG.OUT("executeOneShotActions");
		if (scope.interrupted()) return;
		try {
			executeActions(ONE_SHOT);
		} finally {
			actions[ONE_SHOT].clear();
		}
	}

	/**
	 * Execute actions.
	 *
	 * @param type
	 *            the type
	 */
	private void executeActions(final int type) {

		DEBUG.OUT("executeActions " + type);
		for (final IExecutable action : actions[type]) { 
			DEBUG.OUT("actionaction " + action);
			if (!scope.interrupted()) { 
				action.executeOn(scope); 
			} 
		}
	}

	/**
	 * Execute one action.
	 *
	 * @param action
	 *            the action
	 */
	public synchronized void executeOneAction(final IExecutable action) {

		DEBUG.OUT("executeOneAction " + action);
		final boolean paused = scope.isPaused();
		if (paused) {
			DEBUG.OUT("actionaction22 " + action);
			action.executeOn(scope);
		} else {
			insertOneShotAction(action);
		}
	}

	/**
	 * Execute begin actions.
	 */
	public void executeBeginActions() {
		if (scope.interrupted()) return;
		executeActions(BEGIN);
	}

}
