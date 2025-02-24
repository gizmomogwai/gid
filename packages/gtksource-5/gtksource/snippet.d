module gtksource.snippet;

import gid.gid;
import glib.error;
import gobject.object;
import gtksource.c.functions;
import gtksource.c.types;
import gtksource.snippet_chunk;
import gtksource.snippet_context;
import gtksource.types;

/**
 * Quick insertion code snippets.
 * The `GtkSourceSnippet` represents a series of chunks that can quickly be
 * inserted into the class@View.
 * Snippets are defined in XML files which are loaded by the
 * class@SnippetManager. Alternatively, applications can create snippets
 * on demand and insert them into the class@View using
 * [GtkSource.View.pushSnippet].
 * Snippet chunks can reference other snippet chunks as well as post-process
 * the values from other chunks such as capitalization.
 */
class Snippet : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_source_snippet_get_type != &gidSymbolNotFound ? gtk_source_snippet_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GtkSourceSnippet
   * Params:
   *   trigger = the trigger word
   *   languageId = the source language
   * Returns: A new #GtkSourceSnippet
   */
  this(string trigger, string languageId)
  {
    GtkSourceSnippet* _cretval;
    const(char)* _trigger = trigger.toCString(No.Alloc);
    const(char)* _languageId = languageId.toCString(No.Alloc);
    _cretval = gtk_source_snippet_new(_trigger, _languageId);
    this(_cretval, Yes.Take);
  }

  /**
   * Parses the snippet formatted text into a series of chunks and adds them
   * to a new #GtkSourceSnippet.
   * Params:
   *   text = the formatted snippet text to parse
   * Returns: the newly parsed #GtkSourceSnippet, or %NULL upon
   *   failure and error is set.
   */
  static Snippet newParsed(string text)
  {
    GtkSourceSnippet* _cretval;
    const(char)* _text = text.toCString(No.Alloc);
    GError *_err;
    _cretval = gtk_source_snippet_new_parsed(_text, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!Snippet(cast(GtkSourceSnippet*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Appends chunk to the snippet.
   * This may only be called before the snippet has been expanded.
   * Params:
   *   chunk = a #GtkSourceSnippetChunk
   */
  void addChunk(SnippetChunk chunk)
  {
    gtk_source_snippet_add_chunk(cast(GtkSourceSnippet*)cPtr, chunk ? cast(GtkSourceSnippetChunk*)chunk.cPtr(No.Dup) : null);
  }

  /**
   * Does a deep copy of the snippet.
   * Returns: A new #GtkSourceSnippet
   */
  Snippet copy()
  {
    GtkSourceSnippet* _cretval;
    _cretval = gtk_source_snippet_copy(cast(GtkSourceSnippet*)cPtr);
    auto _retval = ObjectG.getDObject!Snippet(cast(GtkSourceSnippet*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the context used for expanding the snippet.
   * Returns: an #GtkSourceSnippetContext
   */
  SnippetContext getContext()
  {
    GtkSourceSnippetContext* _cretval;
    _cretval = gtk_source_snippet_get_context(cast(GtkSourceSnippet*)cPtr);
    auto _retval = ObjectG.getDObject!SnippetContext(cast(GtkSourceSnippetContext*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the description for the snippet.
   * Returns:
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = gtk_source_snippet_get_description(cast(GtkSourceSnippet*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets the current focus for the snippet.
   * This is changed as the user tabs through focus locations.
   * Returns: The focus position, or -1 if unset.
   */
  int getFocusPosition()
  {
    int _retval;
    _retval = gtk_source_snippet_get_focus_position(cast(GtkSourceSnippet*)cPtr);
    return _retval;
  }

  /**
   * Gets the language-id used for the source snippet.
   * The language identifier should be one that matches a
   * source language propertyLanguage:id property.
   * Returns: the language identifier
   */
  string getLanguageId()
  {
    const(char)* _cretval;
    _cretval = gtk_source_snippet_get_language_id(cast(GtkSourceSnippet*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets the number of chunks in the snippet.
   * Note that not all chunks are editable.
   * Returns: The number of chunks.
   */
  uint getNChunks()
  {
    uint _retval;
    _retval = gtk_source_snippet_get_n_chunks(cast(GtkSourceSnippet*)cPtr);
    return _retval;
  }

  /**
   * Gets the name for the snippet.
   * Returns:
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gtk_source_snippet_get_name(cast(GtkSourceSnippet*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets the chunk at nth.
   * Params:
   *   nth = the nth chunk to get
   * Returns: an #GtkSourceSnippetChunk
   */
  SnippetChunk getNthChunk(uint nth)
  {
    GtkSourceSnippetChunk* _cretval;
    _cretval = gtk_source_snippet_get_nth_chunk(cast(GtkSourceSnippet*)cPtr, nth);
    auto _retval = ObjectG.getDObject!SnippetChunk(cast(GtkSourceSnippetChunk*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the trigger for the source snippet.
   * A trigger is a word that can be expanded into the full snippet when
   * the user presses Tab.
   * Returns: A string or %NULL
   */
  string getTrigger()
  {
    const(char)* _cretval;
    _cretval = gtk_source_snippet_get_trigger(cast(GtkSourceSnippet*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Sets the description for the snippet.
   * Params:
   *   description = the snippet description
   */
  void setDescription(string description)
  {
    const(char)* _description = description.toCString(No.Alloc);
    gtk_source_snippet_set_description(cast(GtkSourceSnippet*)cPtr, _description);
  }

  /**
   * Sets the language identifier for the snippet.
   * This should match the propertyLanguage:id identifier.
   * Params:
   *   languageId = the language identifier for the snippet
   */
  void setLanguageId(string languageId)
  {
    const(char)* _languageId = languageId.toCString(No.Alloc);
    gtk_source_snippet_set_language_id(cast(GtkSourceSnippet*)cPtr, _languageId);
  }

  /**
   * Sets the name for the snippet.
   * Params:
   *   name = the snippet name
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(No.Alloc);
    gtk_source_snippet_set_name(cast(GtkSourceSnippet*)cPtr, _name);
  }

  /**
   * Sets the trigger for the snippet.
   * Params:
   *   trigger = the trigger word
   */
  void setTrigger(string trigger)
  {
    const(char)* _trigger = trigger.toCString(No.Alloc);
    gtk_source_snippet_set_trigger(cast(GtkSourceSnippet*)cPtr, _trigger);
  }
}
