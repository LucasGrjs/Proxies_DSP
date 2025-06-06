/*******************************************************************************************************
 *
 * WorkaroundForIssue2476.java, in gama.ui.display.java2d, is part of the source code of the GAMA modeling and simulation
 * platform .
 *
 * (c) 2007-2024 UMI 209 UMMISCO IRD/SU & Partners (IRIT, MIAT, TLU, CTU)
 *
 * Visit https://github.com/gama-platform/gama for license information and contacts.
 *
 ********************************************************************************************************/
package gama.ui.display.java2d;

import java.awt.Container;
import java.awt.event.MouseMotionListener;

import org.eclipse.swt.SWT;

import gama.core.common.interfaces.IDisplaySurface;
import gama.core.runtime.GAMA;
import gama.dev.DEBUG;

/**
 * The Class WorkaroundForIssue2476.
 */
public class WorkaroundForIssue2476 {

	static {
		DEBUG.OFF();
	}

	/**
	 * Sets the mouse position.
	 *
	 * @param surface
	 *            the surface
	 * @param x
	 *            the x
	 * @param y
	 *            the y
	 */
	private static void setMousePosition(final IDisplaySurface surface, final int x, final int y) {
		surface.setMousePosition(x, y);
		// GAMA.getGui().setMouseLocationInDisplay(new GamaPoint(x, y));
		GAMA.getGui().setMouseLocationInDisplay(surface.getWindowCoordinates());
		GAMA.getGui().setMouseLocationInModel(surface.getModelCoordinates());
	}

	/**
	 * Install on.
	 *
	 * @param applet
	 *            the applet
	 * @param surface
	 *            the surface
	 */
	public static void installOn(final Container applet, final IDisplaySurface surface) {
		// Install only on Linux
		if (!gama.core.runtime.PlatformHelper.isLinux()) return;
		applet.addMouseWheelListener(e -> {
			if (e.getPreciseWheelRotation() > 0) {
				surface.zoomOut();
			} else {
				surface.zoomIn();
			}
		});
		applet.addMouseMotionListener(new MouseMotionListener() {

			@Override
			public void mouseMoved(final java.awt.event.MouseEvent e) {
				DEBUG.OUT("Mouse move on applet");
				setMousePosition(surface, e.getX(), e.getY());
			}

			@Override
			public void mouseDragged(final java.awt.event.MouseEvent e) {
				DEBUG.OUT("Mouse drag on applet");
				// Moves the surface view
				surface.draggedTo(e.getX(), e.getY());
				// Updates the mouse position. If the surface view is locked, the
				// mouse actually moves in the environment. Is the surface is
				// dragged, the environment follows the mouse so the #user_location
				// technically does not change, but approximations are not likely to
				// break anything.
				setMousePosition(surface, e.getX(), e.getY());
			}
		});
		applet.addMouseListener(new java.awt.event.MouseListener() {

			volatile boolean inMenu;

			@Override
			public void mouseReleased(final java.awt.event.MouseEvent e) {
				setMousePosition(surface, e.getX(), e.getY());
				surface.dispatchMouseEvent(SWT.MouseUp, e.getX(), e.getY());
			}

			@Override
			public void mousePressed(final java.awt.event.MouseEvent e) {
				// DEBUG.OUT("Click on " + e.getX() + " " + e.getY());
				setMousePosition(surface, e.getX(), e.getY());
				surface.dispatchMouseEvent(SWT.MouseDown, e.getX(), e.getY());
			}

			@Override
			public void mouseExited(final java.awt.event.MouseEvent e) {
				surface.dispatchMouseEvent(SWT.MouseExit, e.getX(), e.getY());
			}

			@Override
			public void mouseEntered(final java.awt.event.MouseEvent e) {
				surface.dispatchMouseEvent(SWT.MouseEnter, e.getX(), e.getY());
			}

			@Override
			public void mouseClicked(final java.awt.event.MouseEvent e) {
				if (e.getClickCount() == 2) { surface.zoomFit(); }
				if (e.getButton() == 3 && !inMenu) {
					inMenu = surface.canTriggerContextualMenu();
					setMousePosition(surface, e.getX(), e.getY());
					if (inMenu) { surface.selectAgentsAroundMouse(); }
					surface.dispatchMouseEvent(SWT.MenuDetect, e.getX(), e.getY());
					return;
				}

				if (inMenu) { inMenu = false; }
			}
		});

	}

}
