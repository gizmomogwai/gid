module gtk.every_filter;

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
 * `GtkEveryFilter` matches an item when each of its filters matches.
 * To add filters to a `GtkEveryFilter`, use [gtk.multi_filter.MultiFilter.append].
 */
class EveryFilter : MultiFilter
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_every_filter_get_type != &gidSymbolNotFound ? gtk_every_filter_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty "every" filter.
   * Use [gtk.multi_filter.MultiFilter.append] to add filters to it.
   * This filter matches an item if each of the filters added to it
   * matches the item. In particular, this means that if no filter
   * has been added to it, the filter matches every item.
   * Returns: a new `GtkEveryFilter`
   */
  this()
  {
    GtkEveryFilter* _cretval;
    _cretval = gtk_every_filter_new();
    this(_cretval, Yes.Take);
  }
}
