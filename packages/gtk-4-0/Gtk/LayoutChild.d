module Gtk.LayoutChild;

import GObject.ObjectG;
import Gid.gid;
import Gtk.LayoutManager;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkLayoutChild` is the base class for objects that are meant to hold
 * layout properties.
 * If a `GtkLayoutManager` has per-child properties, like their packing type,
 * or the horizontal and vertical span, or the icon name, then the layout
 * manager should use a `GtkLayoutChild` implementation to store those properties.
 * A `GtkLayoutChild` instance is only ever valid while a widget is part
 * of a layout.
 */
class LayoutChild : ObjectG
{

  this()
  {
  }

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return gtk_layout_child_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Retrieves the `GtkWidget` associated to the given layout_child.
   * Returns: a `GtkWidget`
   */
  Widget getChildWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_layout_child_get_child_widget(cast(GtkLayoutChild*)cPtr);
    auto _retval = ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Retrieves the `GtkLayoutManager` instance that created the
   * given layout_child.
   * Returns: a `GtkLayoutManager`
   */
  LayoutManager getLayoutManager()
  {
    GtkLayoutManager* _cretval;
    _cretval = gtk_layout_child_get_layout_manager(cast(GtkLayoutChild*)cPtr);
    auto _retval = ObjectG.getDObject!LayoutManager(cast(GtkLayoutManager*)_cretval, No.Take);
    return _retval;
  }
}
