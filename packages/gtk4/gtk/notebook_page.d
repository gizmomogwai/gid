module gtk.notebook_page;

import gid.global;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.types;
import gtk.widget;

/**
 * `GtkNotebookPage` is an auxiliary object used by `GtkNotebook`.
 */
class NotebookPage : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_notebook_page_get_type != &gidSymbolNotFound ? gtk_notebook_page_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the notebook child to which page belongs.
   * Returns: the child to which page belongs
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_notebook_page_get_child(cast(GtkNotebookPage*)cPtr);
    auto _retval = ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }
}
