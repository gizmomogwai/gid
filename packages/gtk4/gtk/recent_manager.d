module gtk.recent_manager;

import gid.global;
import glib.error;
import gobject.dclosure;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.recent_data;
import gtk.recent_info;
import gtk.types;

/**
 * `GtkRecentManager` manages and looks up recently used files.
 * Each recently used file is identified by its URI, and has meta-data
 * associated to it, like the names and command lines of the applications
 * that have registered it, the number of time each application has
 * registered the same file, the mime type of the file and whether
 * the file should be displayed only by the applications that have
 * registered it.
 * The recently used files list is per user.
 * `GtkRecentManager` acts like a database of all the recently
 * used files. You can create new `GtkRecentManager` objects, but
 * it is more efficient to use the default manager created by GTK.
 * Adding a new recently used file is as simple as:
 * ```c
 * GtkRecentManager *manager;
 * manager \= gtk_recent_manager_get_default $(LPAREN)$(RPAREN);
 * gtk_recent_manager_add_item $(LPAREN)manager, file_uri$(RPAREN);
 * ```
 * The `GtkRecentManager` will try to gather all the needed information
 * from the file itself through GIO.
 * Looking up the meta-data associated with a recently used file
 * given its URI requires calling [gtk.recent_manager.RecentManager.lookupItem]:
 * ```c
 * GtkRecentManager *manager;
 * GtkRecentInfo *info;
 * GError *error \= NULL;
 * manager \= gtk_recent_manager_get_default $(LPAREN)$(RPAREN);
 * info \= gtk_recent_manager_lookup_item $(LPAREN)manager, file_uri, &error$(RPAREN);
 * if $(LPAREN)error$(RPAREN)
 * {
 * g_warning $(LPAREN)"Could not find the file: %s", error->message$(RPAREN);
 * g_error_free $(LPAREN)error$(RPAREN);
 * }
 * else
 * {
 * // Use the info object
 * gtk_recent_info_unref $(LPAREN)info$(RPAREN);
 * }
 * ```
 * In order to retrieve the list of recently used files, you can use
 * [gtk.recent_manager.RecentManager.getItems], which returns a list of
 * [gtk.recent_info.RecentInfo].
 * Note that the maximum age of the recently used files list is
 * controllable through the property@Gtk.Settings:gtk-recent-files-max-age
 * property.
 */
class RecentManager : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_recent_manager_get_type != &gidSymbolNotFound ? gtk_recent_manager_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new recent manager object.
   * Recent manager objects are used to handle the list of recently used
   * resources. A `GtkRecentManager` object monitors the recently used
   * resources list, and emits the [gtk.recent_manager.RecentManager.changed]
   * signal each time something inside the list changes.
   * `GtkRecentManager` objects are expensive: be sure to create them
   * only when needed. You should use [gtk.recent_manager.RecentManager.getDefault]
   * instead.
   * Returns: A newly created `GtkRecentManager` object
   */
  this()
  {
    GtkRecentManager* _cretval;
    _cretval = gtk_recent_manager_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Gets a unique instance of `GtkRecentManager` that you can share
   * in your application without caring about memory management.
   * Returns: A unique `GtkRecentManager`. Do not ref or
   *   unref it.
   */
  static RecentManager getDefault()
  {
    GtkRecentManager* _cretval;
    _cretval = gtk_recent_manager_get_default();
    auto _retval = ObjectG.getDObject!RecentManager(cast(GtkRecentManager*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Adds a new resource, pointed by uri, into the recently used
   * resources list, using the metadata specified inside the
   * `GtkRecentData` passed in recent_data.
   * The passed URI will be used to identify this resource inside the
   * list.
   * In order to register the new recently used resource, metadata about
   * the resource must be passed as well as the URI; the metadata is
   * stored in a `GtkRecentData`, which must contain the MIME
   * type of the resource pointed by the URI; the name of the application
   * that is registering the item, and a command line to be used when
   * launching the item.
   * Optionally, a `GtkRecentData` might contain a UTF-8 string
   * to be used when viewing the item instead of the last component of
   * the URI; a short description of the item; whether the item should
   * be considered private - that is, should be displayed only by the
   * applications that have registered it.
   * Params:
   *   uri = a valid URI
   *   recentData = metadata of the resource
   * Returns: %TRUE if the new item was successfully added to the
   *   recently used resources list, %FALSE otherwise
   */
  bool addFull(string uri, RecentData recentData)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(No.Alloc);
    _retval = gtk_recent_manager_add_full(cast(GtkRecentManager*)cPtr, _uri, recentData ? cast(GtkRecentData*)recentData.cPtr : null);
    return _retval;
  }

  /**
   * Adds a new resource, pointed by uri, into the recently used
   * resources list.
   * This function automatically retrieves some of the needed
   * metadata and setting other metadata to common default values;
   * it then feeds the data to [gtk.recent_manager.RecentManager.addFull].
   * See [gtk.recent_manager.RecentManager.addFull] if you want to explicitly
   * define the metadata for the resource pointed by uri.
   * Params:
   *   uri = a valid URI
   * Returns: %TRUE if the new item was successfully added
   *   to the recently used resources list
   */
  bool addItem(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(No.Alloc);
    _retval = gtk_recent_manager_add_item(cast(GtkRecentManager*)cPtr, _uri);
    return _retval;
  }

  /**
   * Gets the list of recently used resources.
   * Returns: a list of
   *   newly allocated `GtkRecentInfo objects`. Use
   *   [gtk.recent_info.RecentInfo.unref] on each item inside the list, and then
   *   free the list itself using [glib.list.List.free].
   */
  RecentInfo[] getItems()
  {
    GList* _cretval;
    _cretval = gtk_recent_manager_get_items(cast(GtkRecentManager*)cPtr);
    auto _retval = gListToD!(RecentInfo, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Checks whether there is a recently used resource registered
   * with uri inside the recent manager.
   * Params:
   *   uri = a URI
   * Returns: %TRUE if the resource was found, %FALSE otherwise
   */
  bool hasItem(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(No.Alloc);
    _retval = gtk_recent_manager_has_item(cast(GtkRecentManager*)cPtr, _uri);
    return _retval;
  }

  /**
   * Searches for a URI inside the recently used resources list, and
   * returns a `GtkRecentInfo` containing information about the resource
   * like its MIME type, or its display name.
   * Params:
   *   uri = a URI
   * Returns: a `GtkRecentInfo` containing information
   *   about the resource pointed by uri, or %NULL if the URI was
   *   not registered in the recently used resources list. Free with
   *   [gtk.recent_info.RecentInfo.unref].
   */
  RecentInfo lookupItem(string uri)
  {
    GtkRecentInfo* _cretval;
    const(char)* _uri = uri.toCString(No.Alloc);
    GError *_err;
    _cretval = gtk_recent_manager_lookup_item(cast(GtkRecentManager*)cPtr, _uri, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new RecentInfo(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Changes the location of a recently used resource from uri to new_uri.
   * Please note that this function will not affect the resource pointed
   * by the URIs, but only the URI used in the recently used resources list.
   * Params:
   *   uri = the URI of a recently used resource
   *   newUri = the new URI of the recently used resource, or
   *     %NULL to remove the item pointed by uri in the list
   * Returns: %TRUE on success
   */
  bool moveItem(string uri, string newUri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(No.Alloc);
    const(char)* _newUri = newUri.toCString(No.Alloc);
    GError *_err;
    _retval = gtk_recent_manager_move_item(cast(GtkRecentManager*)cPtr, _uri, _newUri, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Purges every item from the recently used resources list.
   * Returns: the number of items that have been removed from the
   *   recently used resources list
   */
  int purgeItems()
  {
    int _retval;
    GError *_err;
    _retval = gtk_recent_manager_purge_items(cast(GtkRecentManager*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Removes a resource pointed by uri from the recently used resources
   * list handled by a recent manager.
   * Params:
   *   uri = the URI of the item you wish to remove
   * Returns: %TRUE if the item pointed by uri has been successfully
   *   removed by the recently used resources list, and %FALSE otherwise
   */
  bool removeItem(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(No.Alloc);
    GError *_err;
    _retval = gtk_recent_manager_remove_item(cast(GtkRecentManager*)cPtr, _uri, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Emitted when the current recently used resources manager changes
   * its contents.
   * This can happen either by calling [gtk.recent_manager.RecentManager.addItem]
   * or by another application.
   *   recentManager = the instance the signal is connected to
   */
  alias ChangedCallbackDlg = void delegate(RecentManager recentManager);
  alias ChangedCallbackFunc = void function(RecentManager recentManager);

  /**
   * Connect to Changed signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ChangedCallbackDlg) || is(T : ChangedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto recentManager = getVal!RecentManager(_paramVals);
      _dClosure.dlg(recentManager);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }
}
