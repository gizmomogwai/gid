module gtk.root;

public import gtk.root_iface_proxy;
import gdk.display;
import gid.global;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.types;
import gtk.widget;

/**
 * `GtkRoot` is the interface implemented by all widgets that can act as a toplevel
 * widget.
 * The root widget takes care of providing the connection to the windowing system
 * and manages layout, drawing and event delivery for its widget hierarchy.
 * The obvious example of a `GtkRoot` is `GtkWindow`.
 * To get the display to which a `GtkRoot` belongs, use
 * [gtk.root.Root.getDisplay].
 * `GtkRoot` also maintains the location of keyboard focus inside its widget
 * hierarchy, with [gtk.root.Root.setFocus] and [gtk.root.Root.getFocus].
 */
interface Root
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_root_get_type != &gidSymbolNotFound ? gtk_root_get_type() : cast(GType)0;
  }

  /**
   * Returns the display that this `GtkRoot` is on.
   * Returns: the display of root
   */
  Display getDisplay();

  /**
   * Retrieves the current focused widget within the root.
   * Note that this is the widget that would have the focus
   * if the root is active; if the root is not focused then
   * `gtk_widget_has_focus $(LPAREN)widget$(RPAREN)` will be %FALSE for the
   * widget.
   * Returns: the currently focused widget
   */
  Widget getFocus();

  /**
   * If focus is not the current focus widget, and is focusable, sets
   * it as the focus widget for the root.
   * If focus is %NULL, unsets the focus widget for the root.
   * To set the focus to a particular widget in the root, it is usually
   * more convenient to use [gtk.widget.Widget.grabFocus] instead of
   * this function.
   * Params:
   *   focus = widget to be the new focus widget, or %NULL
   *     to unset the focus widget
   */
  void setFocus(Widget focus);
}
