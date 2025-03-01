module gtksource.language_manager;

import gid.global;
import gobject.object;
import gtksource.c.functions;
import gtksource.c.types;
import gtksource.language;
import gtksource.types;

/**
 * Provides access to class@Languages.
 * `GtkSourceLanguageManager` is an object which processes language description
 * files and creates and stores class@Language objects, and provides API to
 * access them.
 * Use [gtksource.language_manager.LanguageManager.getDefault] to retrieve the default
 * instance of `GtkSourceLanguageManager`, and
 * [gtksource.language_manager.LanguageManager.guessLanguage] to get a class@Language for
 * given file name and content type.
 */
class LanguageManager : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_source_language_manager_get_type != &gidSymbolNotFound ? gtk_source_language_manager_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new language manager.
   * If you do not need more than one language manager or a private language manager
   * instance then use [gtksource.language_manager.LanguageManager.getDefault] instead.
   * Returns: a new #GtkSourceLanguageManager.
   */
  this()
  {
    GtkSourceLanguageManager* _cretval;
    _cretval = gtk_source_language_manager_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Returns the default #GtkSourceLanguageManager instance.
   * Returns: a #GtkSourceLanguageManager.
   *   Return value is owned by GtkSourceView library and must not be unref'ed.
   */
  static LanguageManager getDefault()
  {
    GtkSourceLanguageManager* _cretval;
    _cretval = gtk_source_language_manager_get_default();
    auto _retval = ObjectG.getDObject!LanguageManager(cast(GtkSourceLanguageManager*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Appends path to the list of directories where the manager looks for
   * language files.
   * See [gtksource.language_manager.LanguageManager.setSearchPath] for details.
   * Params:
   *   path = a directory or a filename.
   */
  void appendSearchPath(string path)
  {
    const(char)* _path = path.toCString(No.Alloc);
    gtk_source_language_manager_append_search_path(cast(GtkSourceLanguageManager*)cPtr, _path);
  }

  /**
   * Gets the classLanguage identified by the given id in the language
   * manager.
   * Params:
   *   id = a language id.
   * Returns: a #GtkSourceLanguage, or %NULL
   *   if there is no language identified by the given id. Return value is
   *   owned by lm and should not be freed.
   */
  Language getLanguage(string id)
  {
    GtkSourceLanguage* _cretval;
    const(char)* _id = id.toCString(No.Alloc);
    _cretval = gtk_source_language_manager_get_language(cast(GtkSourceLanguageManager*)cPtr, _id);
    auto _retval = ObjectG.getDObject!Language(cast(GtkSourceLanguage*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns the ids of the available languages.
   * Returns: a %NULL-terminated array of strings containing the ids of the available
   *   languages or %NULL if no language is available.
   *   The array is sorted alphabetically according to the language name.
   *   The array is owned by lm and must not be modified.
   */
  string[] getLanguageIds()
  {
    const(char*)* _cretval;
    _cretval = gtk_source_language_manager_get_language_ids(cast(GtkSourceLanguageManager*)cPtr);
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
   * Gets the list directories where lm looks for language files.
   * Returns: %NULL-terminated array
   *   containing a list of language files directories.
   *   The array is owned by lm and must not be modified.
   */
  string[] getSearchPath()
  {
    const(char*)* _cretval;
    _cretval = gtk_source_language_manager_get_search_path(cast(GtkSourceLanguageManager*)cPtr);
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
   * Picks a classLanguage for given file name and content type,
   * according to the information in lang files.
   * Either filename or content_type may be %NULL. This function can be used as follows:
   * ```c
   * GtkSourceLanguage *lang;
   * GtkSourceLanguageManager *manager;
   * lm \= gtk_source_language_manager_get_default $(LPAREN)$(RPAREN);
   * lang \= gtk_source_language_manager_guess_language $(LPAREN)manager, filename, NULL$(RPAREN);
   * gtk_source_buffer_set_language $(LPAREN)buffer, lang$(RPAREN);
   * ```
   * or
   * ```c
   * GtkSourceLanguage *lang \= NULL;
   * GtkSourceLanguageManager *manager;
   * gboolean result_uncertain;
   * gchar *content_type;
   * content_type \= g_content_type_guess $(LPAREN)filename, NULL, 0, &result_uncertain$(RPAREN);
   * if $(LPAREN)result_uncertain$(RPAREN)
   * {
   * g_free $(LPAREN)content_type$(RPAREN);
   * content_type \= NULL;
   * }
   * manager \= gtk_source_language_manager_get_default $(LPAREN)$(RPAREN);
   * lang \= gtk_source_language_manager_guess_language $(LPAREN)manager, filename, content_type$(RPAREN);
   * gtk_source_buffer_set_language $(LPAREN)buffer, lang$(RPAREN);
   * g_free $(LPAREN)content_type$(RPAREN);
   * ```
   * etc. Use [gtksource.language.Language.getMimeTypes] and [gtksource.language.Language.getGlobs]
   * if you need full control over file -> language mapping.
   * Params:
   *   filename = a filename in Glib filename encoding, or %NULL.
   *   contentType = a content type $(LPAREN)as in GIO API$(RPAREN), or %NULL.
   * Returns: a #GtkSourceLanguage, or %NULL if there
   *   is no suitable language for given filename and/or content_type. Return
   *   value is owned by lm and should not be freed.
   */
  Language guessLanguage(string filename, string contentType)
  {
    GtkSourceLanguage* _cretval;
    const(char)* _filename = filename.toCString(No.Alloc);
    const(char)* _contentType = contentType.toCString(No.Alloc);
    _cretval = gtk_source_language_manager_guess_language(cast(GtkSourceLanguageManager*)cPtr, _filename, _contentType);
    auto _retval = ObjectG.getDObject!Language(cast(GtkSourceLanguage*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Prepends path to the list of directories where the manager looks
   * for language files.
   * See [gtksource.language_manager.LanguageManager.setSearchPath] for details.
   * Params:
   *   path = a directory or a filename.
   */
  void prependSearchPath(string path)
  {
    const(char)* _path = path.toCString(No.Alloc);
    gtk_source_language_manager_prepend_search_path(cast(GtkSourceLanguageManager*)cPtr, _path);
  }

  /**
   * Sets the list of directories where the lm looks for
   * language files.
   * If dirs is %NULL, the search path is reset to default.
   * At the moment this function can be called only before the
   * language files are loaded for the first time. In practice
   * to set a custom search path for a `GtkSourceLanguageManager`,
   * you have to call this function right after creating it.
   * Since GtkSourceView 5.4 this function will allow you to provide
   * paths in the form of "resource:///" URIs to embedded `GResource`s.
   * They must contain the path of a directory within the `GResource`.
   * Params:
   *   dirs = a %NULL-terminated array of
   *     strings or %NULL.
   */
  void setSearchPath(string[] dirs)
  {
    char*[] _tmpdirs;
    foreach (s; dirs)
      _tmpdirs ~= s.toCString(No.Alloc);
    _tmpdirs ~= null;
    const(char*)* _dirs = _tmpdirs.ptr;
    gtk_source_language_manager_set_search_path(cast(GtkSourceLanguageManager*)cPtr, _dirs);
  }
}
