module cairo.font_face;

import cairo.c.functions;
import cairo.c.types;
import cairo.types;
import gid.global;
import gobject.boxed;

/**
 * A #cairo_font_face_t specifies all aspects of a font other
 * than the size or font matrix $(LPAREN)a font matrix is used to distort
 * a font by shearing it or scaling it unequally in the two
 * directions$(RPAREN) . A font face can be set on a #cairo_t by using
 * [cairo.context.Context.setFontFace]; the size and font matrix are set with
 * [cairo.context.Context.setFontSize] and [cairo.context.Context.setFontMatrix].
 * There are various types of font faces, depending on the
 * <firstterm>font backend</firstterm> they use. The type of a
 * font face can be queried using [cairo.font_face.FontFace.getFontType].
 * Memory management of #cairo_font_face_t is done with
 * [cairo.font_face.FontFace.reference] and [cairo.font_face.FontFace.destroy].
 */
class FontFace : Boxed
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
    return cast(void function())cairo_gobject_font_face_get_type != &gidSymbolNotFound ? cairo_gobject_font_face_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * This function returns the type of the backend used to create
   * a font face. See #cairo_font_type_t for available types.
   * Returns: The type of font_face.
   */
  FontType getFontType()
  {
    cairo_font_type_t _cretval;
    _cretval = cairo_font_face_get_type(cast(cairo_font_face_t*)cPtr);
    FontType _retval = cast(FontType)_cretval;
    return _retval;
  }

  /**
   * Return user data previously attached to font_face using the specified
   * key.  If no user data has been attached with the given key this
   * function returns %NULL.
   * Params:
   *   key = the address of the #cairo_user_data_key_t the user data was
   *     attached to
   * Returns: the user data previously attached or %NULL.
   */
  void* getUserData(UserDataKey key)
  {
    auto _retval = cairo_font_face_get_user_data(cast(cairo_font_face_t*)cPtr, &key);
    return _retval;
  }

  /**
   * Checks whether an error has previously occurred for this
   * font face
   * Returns: %CAIRO_STATUS_SUCCESS or another error such as
   *   %CAIRO_STATUS_NO_MEMORY.
   */
  Status status()
  {
    cairo_status_t _cretval;
    _cretval = cairo_font_face_status(cast(cairo_font_face_t*)cPtr);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }
}
