module gtk.any_filter;

import gid.global;
import gio.list_model;
import gio.list_model_mixin;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.multi_filter;
import gtk.types;

/**
 * `GtkAnyFilter` matches an item when at least one of its filters matches.
 * To add filters to a `GtkAnyFilter`, use [gtk.multi_filter.MultiFilter.append].
 */
class AnyFilter : MultiFilter
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_any_filter_get_type != &gidSymbolNotFound ? gtk_any_filter_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty "any" filter.
   * Use [gtk.multi_filter.MultiFilter.append] to add filters to it.
   * This filter matches an item if any of the filters added to it
   * matches the item. In particular, this means that if no filter
   * has been added to it, the filter matches no item.
   * Returns: a new `GtkAnyFilter`
   */
  this()
  {
    GtkAnyFilter* _cretval;
    _cretval = gtk_any_filter_new();
    this(_cretval, Yes.Take);
  }
}
