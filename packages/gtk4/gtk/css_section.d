module gtk.css_section;

import gid.global;
import gio.file;
import gio.file_mixin;
import glib.string_;
import gobject.boxed;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.types;

/**
 * Defines a part of a CSS document.
 * Because sections are nested into one another, you can use
 * [gtk.css_section.CssSection.getParent] to get the containing region.
 */
class CssSection : Boxed
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  void* cPtr(Flag!"Dup" dup = No.Dup)
  {
    return dup ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_css_section_get_type != &gidSymbolNotFound ? gtk_css_section_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkCssSection` referring to the section
   * in the given `file` from the `start` location to the
   * `end` location.
   * Params:
   *   file = The file this section refers to
   *   start = The start location
   *   end = The end location
   * Returns: a new `GtkCssSection`
   */
  this(File file, CssLocation start, CssLocation end)
  {
    GtkCssSection* _cretval;
    _cretval = gtk_css_section_new(file ? cast(GFile*)(cast(ObjectG)file).cPtr(No.Dup) : null, &start, &end);
    this(_cretval, Yes.Take);
  }

  /**
   * Returns the location in the CSS document where this section ends.
   * Returns: The end location of
   *   this section
   */
  CssLocation getEndLocation()
  {
    const(GtkCssLocation)* _cretval;
    _cretval = gtk_css_section_get_end_location(cast(GtkCssSection*)cPtr);
    CssLocation _retval;
    if (_cretval)
      _retval = *_cretval;
    return _retval;
  }

  /**
   * Gets the file that section was parsed from.
   * If no such file exists, for example because the CSS was loaded via
   * [gtk.css_provider.CssProvider.loadFromData], then `NULL` is returned.
   * Returns: the `GFile` from which the `section`
   *   was parsed
   */
  File getFile()
  {
    GFile* _cretval;
    _cretval = gtk_css_section_get_file(cast(GtkCssSection*)cPtr);
    auto _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the parent section for the given `section`.
   * The parent section is the section that contains this `section`. A special
   * case are sections of  type `GTK_CSS_SECTION_DOCUMEN`T. Their parent will
   * either be `NULL` if they are the original CSS document that was loaded by
   * [gtk.css_provider.CssProvider.loadFromFile] or a section of type
   * `GTK_CSS_SECTION_IMPORT` if it was loaded with an `import` rule from
   * a different file.
   * Returns: the parent section
   */
  CssSection getParent()
  {
    GtkCssSection* _cretval;
    _cretval = gtk_css_section_get_parent(cast(GtkCssSection*)cPtr);
    auto _retval = _cretval ? new CssSection(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Returns the location in the CSS document where this section starts.
   * Returns: The start location of
   *   this section
   */
  CssLocation getStartLocation()
  {
    const(GtkCssLocation)* _cretval;
    _cretval = gtk_css_section_get_start_location(cast(GtkCssSection*)cPtr);
    CssLocation _retval;
    if (_cretval)
      _retval = *_cretval;
    return _retval;
  }

  /**
   * Prints the `section` into `string` in a human-readable form.
   * This is a form like `gtk.css:32:1-23` to denote line 32, characters
   * 1 to 23 in the file `gtk.css`.
   * Params:
   *   string_ = a `GString` to print to
   */
  void print(String string_)
  {
    gtk_css_section_print(cast(GtkCssSection*)cPtr, string_ ? cast(GString*)string_.cPtr(No.Dup) : null);
  }

  /**
   * Prints the section into a human-readable text form using
   * [gtk.css_section.CssSection.print].
   * Returns: A new string.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = gtk_css_section_to_string(cast(GtkCssSection*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }
}
