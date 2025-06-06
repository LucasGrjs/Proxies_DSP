/*******************************************************************************************************
 *
 * SwitchWorkspaceHandler.java, in gama.ui.shared.shared, is part of the source code of the GAMA modeling and
 * simulation platform .
 *
 * (c) 2007-2024 UMI 209 UMMISCO IRD/SU & Partners (IRIT, MIAT, TLU, CTU)
 *
 * Visit https://github.com/gama-platform/gama for license information and contacts.
 *
 ********************************************************************************************************/
package gama.ui.shared.commands;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.jface.window.Window;
import org.eclipse.ui.PlatformUI;

import gama.ui.application.workspace.PickWorkspaceDialog;

/**
 * The Class SwitchWorkspaceHandler.
 */
public class SwitchWorkspaceHandler extends AbstractHandler {

	@Override
	public Object execute(final ExecutionEvent event) throws ExecutionException {
		if (new PickWorkspaceDialog(false).open() != Window.CANCEL) { PlatformUI.getWorkbench().restart(); }
		return null;
	}

}
