module gtk.fixed;

import gid.global;
import gsk.transform;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.types;
import gtk.widget;

/**
 * `GtkFixed` places its child widgets at fixed positions and with fixed sizes.
 * `GtkFixed` performs no automatic layout management.
 * For most applications, you should not use this container! It keeps
 * you from having to learn about the other GTK containers, but it
 * results in broken applications.  With `GtkFixed`, the following
 * things will result in truncated text, overlapping widgets, and
 * other display bugs:
 * - Themes, which may change widget sizes.
 * - Fonts other than the one you used to write the app will of course
 * change the size of widgets containing text; keep in mind that
 * users may use a larger font because of difficulty reading the
 * default, or they may be using a different OS that provides different fonts.
 * - Translation of text into other languages changes its size. Also,
 * display of non-English text will use a different font in many
 * cases.
 * In addition, `GtkFixed` does not pay attention to text direction and
 * thus may produce unwanted results if your app is run under right-to-left
 * languages such as Hebrew or Arabic. That is: normally GTK will order
 * containers appropriately for the text direction, e.g. to put labels to
 * the right of the thing they label when using an RTL language, but it can’t
 * do that with `GtkFixed`. So if you need to reorder widgets depending on
 * the text direction, you would need to manually detect it and adjust child
 * positions accordingly.
 * Finally, fixed positioning makes it kind of annoying to add/remove
 * UI elements, since you have to reposition all the other elements. This
 * is a long-term maintenance problem for your application.
 * If you know none of these things are an issue for your application,
 * and prefer the simplicity of `GtkFixed`, by all means use the
 * widget. But you should be aware of the tradeoffs.
 */
class Fixed : Widget
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_fixed_get_type != &gidSymbolNotFound ? gtk_fixed_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkFixed`.
   * Returns: a new `GtkFixed`.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_fixed_new();
    this(_cretval, No.Take);
  }

  /**
   * Retrieves the translation transformation of the
   * given child `GtkWidget` in the `GtkFixed`.
   * See also: [gtk.fixed.Fixed.getChildTransform].
   * Params:
   *   widget = a child of fixed
   *   x = the horizontal position of the widget
   *   y = the vertical position of the widget
   */
  void getChildPosition(Widget widget, out double x, out double y)
  {
    gtk_fixed_get_child_position(cast(GtkFixed*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(No.Dup) : null, cast(double*)&x, cast(double*)&y);
  }

  /**
   * Retrieves the transformation for widget set using
   * [gtk.fixed.Fixed.setChildTransform].
   * Params:
   *   widget = a `GtkWidget`, child of fixed
   * Returns: a `GskTransform`
   */
  Transform getChildTransform(Widget widget)
  {
    GskTransform* _cretval;
    _cretval = gtk_fixed_get_child_transform(cast(GtkFixed*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(No.Dup) : null);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Sets a translation transformation to the given x and y
   * coordinates to the child widget of the `GtkFixed`.
   * Params:
   *   widget = the child widget
   *   x = the horizontal position to move the widget to
   *   y = the vertical position to move the widget to
   */
  void move(Widget widget, double x, double y)
  {
    gtk_fixed_move(cast(GtkFixed*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(No.Dup) : null, x, y);
  }

  /**
   * Adds a widget to a `GtkFixed` at the given position.
   * Params:
   *   widget = the widget to add
   *   x = the horizontal position to place the widget at
   *   y = the vertical position to place the widget at
   */
  void put(Widget widget, double x, double y)
  {
    gtk_fixed_put(cast(GtkFixed*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(No.Dup) : null, x, y);
  }

  /**
   * Removes a child from fixed.
   * Params:
   *   widget = the child widget to remove
   */
  void remove(Widget widget)
  {
    gtk_fixed_remove(cast(GtkFixed*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(No.Dup) : null);
  }

  /**
   * Sets the transformation for widget.
   * This is a convenience function that retrieves the
   * [gtk.fixed_layout_child.FixedLayoutChild] instance associated to
   * widget and calls [gtk.fixed_layout_child.FixedLayoutChild.setTransform].
   * Params:
   *   widget = a `GtkWidget`, child of fixed
   *   transform = the transformation assigned to widget
   *     to reset widget's transform
   */
  void setChildTransform(Widget widget, Transform transform)
  {
    gtk_fixed_set_child_transform(cast(GtkFixed*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(No.Dup) : null, transform ? cast(GskTransform*)transform.cPtr(No.Dup) : null);
  }
}
