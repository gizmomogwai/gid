module gtksource.style_scheme_manager;

import gid.global;
import gobject.object;
import gtksource.c.functions;
import gtksource.c.types;
import gtksource.style_scheme;
import gtksource.types;

/**
 * Provides access to class@StyleSchemes.
 */
class StyleSchemeManager : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_source_style_scheme_manager_get_type != &gidSymbolNotFound ? gtk_source_style_scheme_manager_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new style manager.
   * If you do not need more than one style manager
   * then use [gtksource.style_scheme_manager.StyleSchemeManager.getDefault] instead.
   * Returns: a new #GtkSourceStyleSchemeManager.
   */
  this()
  {
    GtkSourceStyleSchemeManager* _cretval;
    _cretval = gtk_source_style_scheme_manager_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Returns the default #GtkSourceStyleSchemeManager instance.
   * Returns: a #GtkSourceStyleSchemeManager. Return value
   *   is owned by GtkSourceView library and must not be unref'ed.
   */
  static StyleSchemeManager getDefault()
  {
    GtkSourceStyleSchemeManager* _cretval;
    _cretval = gtk_source_style_scheme_manager_get_default();
    auto _retval = ObjectG.getDObject!StyleSchemeManager(cast(GtkSourceStyleSchemeManager*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Appends path to the list of directories where the manager looks for
   * style scheme files.
   * See [gtksource.style_scheme_manager.StyleSchemeManager.setSearchPath] for details.
   * Params:
   *   path = a directory or a filename.
   */
  void appendSearchPath(string path)
  {
    const(char)* _path = path.toCString(No.Alloc);
    gtk_source_style_scheme_manager_append_search_path(cast(GtkSourceStyleSchemeManager*)cPtr, _path);
  }

  /**
   * Mark any currently cached information about the available style schems
   * as invalid.
   * All the available style schemes will be reloaded next time the manager is accessed.
   */
  void forceRescan()
  {
    gtk_source_style_scheme_manager_force_rescan(cast(GtkSourceStyleSchemeManager*)cPtr);
  }

  /**
   * Looks up style scheme by id.
   * Params:
   *   schemeId = style scheme id to find.
   * Returns: a #GtkSourceStyleScheme object.
   *   The returned value is owned by manager and must not be unref'ed.
   */
  StyleScheme getScheme(string schemeId)
  {
    GtkSourceStyleScheme* _cretval;
    const(char)* _schemeId = schemeId.toCString(No.Alloc);
    _cretval = gtk_source_style_scheme_manager_get_scheme(cast(GtkSourceStyleSchemeManager*)cPtr, _schemeId);
    auto _retval = ObjectG.getDObject!StyleScheme(cast(GtkSourceStyleScheme*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns the ids of the available style schemes.
   * Returns: a %NULL-terminated array of strings containing the ids of the available
   *   style schemes or %NULL if no style scheme is available.
   *   The array is sorted alphabetically according to the scheme name.
   *   The array is owned by the manager and must not be modified.
   */
  string[] getSchemeIds()
  {
    const(char*)* _cretval;
    _cretval = gtk_source_style_scheme_manager_get_scheme_ids(cast(GtkSourceStyleSchemeManager*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(No.Free);
    }
    return _retval;
  }

  /**
   * Returns the current search path for the manager.
   * See [gtksource.style_scheme_manager.StyleSchemeManager.setSearchPath] for details.
   * Returns: a %NULL-terminated array
   *   of string containing the search path.
   *   The array is owned by the manager and must not be modified.
   */
  string[] getSearchPath()
  {
    const(char*)* _cretval;
    _cretval = gtk_source_style_scheme_manager_get_search_path(cast(GtkSourceStyleSchemeManager*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(No.Free);
    }
    return _retval;
  }

  /**
   * Prepends path to the list of directories where the manager looks
   * for style scheme files.
   * See [gtksource.style_scheme_manager.StyleSchemeManager.setSearchPath] for details.
   * Params:
   *   path = a directory or a filename.
   */
  void prependSearchPath(string path)
  {
    const(char)* _path = path.toCString(No.Alloc);
    gtk_source_style_scheme_manager_prepend_search_path(cast(GtkSourceStyleSchemeManager*)cPtr, _path);
  }

  /**
   * Sets the list of directories where the manager looks for
   * style scheme files.
   * If path is %NULL, the search path is reset to default.
   * Params:
   *   path = a %NULL-terminated array of
   *     strings or %NULL.
   */
  void setSearchPath(string[] path)
  {
    char*[] _tmppath;
    foreach (s; path)
      _tmppath ~= s.toCString(No.Alloc);
    _tmppath ~= null;
    const(char*)* _path = _tmppath.ptr;
    gtk_source_style_scheme_manager_set_search_path(cast(GtkSourceStyleSchemeManager*)cPtr, _path);
  }
}
