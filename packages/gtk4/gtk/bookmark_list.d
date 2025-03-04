module gtk.bookmark_list;

import gid.global;
import gio.list_model;
import gio.list_model_mixin;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.types;

/**
 * `GtkBookmarkList` is a list model that wraps `GBookmarkFile`.
 * It presents a `GListModel` and fills it asynchronously with the
 * `GFileInfo`s returned from that function.
 * The `GFileInfo`s in the list have some attributes in the recent
 * namespace added: `recent::private` $(LPAREN)boolean$(RPAREN) and `recent:applications`
 * $(LPAREN)stringv$(RPAREN).
 */
class BookmarkList : ObjectG, ListModel
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_bookmark_list_get_type != &gidSymbolNotFound ? gtk_bookmark_list_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();

  /**
   * Creates a new `GtkBookmarkList` with the given attributes.
   * Params:
   *   filename = The bookmark file to load
   *   attributes = The attributes to query
   * Returns: a new `GtkBookmarkList`
   */
  this(string filename, string attributes)
  {
    GtkBookmarkList* _cretval;
    const(char)* _filename = filename.toCString(No.Alloc);
    const(char)* _attributes = attributes.toCString(No.Alloc);
    _cretval = gtk_bookmark_list_new(_filename, _attributes);
    this(_cretval, Yes.Take);
  }

  /**
   * Gets the attributes queried on the children.
   * Returns: The queried attributes
   */
  string getAttributes()
  {
    const(char)* _cretval;
    _cretval = gtk_bookmark_list_get_attributes(cast(GtkBookmarkList*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Returns the filename of the bookmark file that
   * this list is loading.
   * Returns: the filename of the .xbel file
   */
  string getFilename()
  {
    const(char)* _cretval;
    _cretval = gtk_bookmark_list_get_filename(cast(GtkBookmarkList*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets the IO priority to use while loading file.
   * Returns: The IO priority.
   */
  int getIoPriority()
  {
    int _retval;
    _retval = gtk_bookmark_list_get_io_priority(cast(GtkBookmarkList*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the files are currently being loaded.
   * Files will be added to self from time to time while loading is
   * going on. The order in which are added is undefined and may change
   * in between runs.
   * Returns: %TRUE if self is loading
   */
  bool isLoading()
  {
    bool _retval;
    _retval = gtk_bookmark_list_is_loading(cast(GtkBookmarkList*)cPtr);
    return _retval;
  }

  /**
   * Sets the attributes to be enumerated and starts the enumeration.
   * If attributes is %NULL, no attributes will be queried, but a list
   * of `GFileInfo`s will still be created.
   * Params:
   *   attributes = the attributes to enumerate
   */
  void setAttributes(string attributes)
  {
    const(char)* _attributes = attributes.toCString(No.Alloc);
    gtk_bookmark_list_set_attributes(cast(GtkBookmarkList*)cPtr, _attributes);
  }

  /**
   * Sets the IO priority to use while loading files.
   * The default IO priority is %G_PRIORITY_DEFAULT.
   * Params:
   *   ioPriority = IO priority to use
   */
  void setIoPriority(int ioPriority)
  {
    gtk_bookmark_list_set_io_priority(cast(GtkBookmarkList*)cPtr, ioPriority);
  }
}
