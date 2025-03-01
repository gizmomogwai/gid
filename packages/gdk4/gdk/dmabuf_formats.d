module gdk.dmabuf_formats;

import gdk.c.functions;
import gdk.c.types;
import gdk.types;
import gid.global;
import gobject.boxed;

/**
 * The `GdkDmabufFormats` struct provides information about
 * supported DMA buffer formats.
 * You can query whether a given format is supported with
 * [gdk.dmabuf_formats.DmabufFormats.contains] and you can iterate
 * over the list of all supported formats with
 * [gdk.dmabuf_formats.DmabufFormats.getNFormats] and
 * [gdk.dmabuf_formats.DmabufFormats.getFormat].
 * The list of supported formats is sorted by preference,
 * with the best formats coming first.
 * The list may contains $(LPAREN)format, modifier$(RPAREN) pairs where the modifier
 * is `DMA_FORMAT_MOD_INVALID`, indicating that **_implicit modifiers_**
 * may be used with this format.
 * See [gdk.dmabuf_texture_builder.DmabufTextureBuilder] for more information
 * about DMA buffers.
 * Note that DMA buffers only exist on Linux.
 */
class DmabufFormats : Boxed
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
    return cast(void function())gdk_dmabuf_formats_get_type != &gidSymbolNotFound ? gdk_dmabuf_formats_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns whether a given format is contained in formats.
   * Params:
   *   fourcc = a format code
   *   modifier = a format modifier
   * Returns: `TRUE` if the format specified by the arguments
   *   is part of formats
   */
  bool contains(uint fourcc, ulong modifier)
  {
    bool _retval;
    _retval = gdk_dmabuf_formats_contains(cast(GdkDmabufFormats*)cPtr, fourcc, modifier);
    return _retval;
  }

  /**
   * Returns whether formats1 and formats2 contain the
   * same dmabuf formats, in the same order.
   * Params:
   *   formats2 = another `GdkDmabufFormats`
   * Returns: `TRUE` if formats1 and formats2 are equal
   */
  bool equal(DmabufFormats formats2)
  {
    bool _retval;
    _retval = gdk_dmabuf_formats_equal(cast(GdkDmabufFormats*)cPtr, formats2 ? cast(GdkDmabufFormats*)formats2.cPtr(No.Dup) : null);
    return _retval;
  }

  /**
   * Gets the fourcc code and modifier for a format
   * that is contained in formats.
   * Params:
   *   idx = the index of the format to return
   *   fourcc = return location for the format code
   *   modifier = return location for the format modifier
   */
  void getFormat(size_t idx, out uint fourcc, out ulong modifier)
  {
    gdk_dmabuf_formats_get_format(cast(GdkDmabufFormats*)cPtr, idx, cast(uint*)&fourcc, cast(ulong*)&modifier);
  }

  /**
   * Returns the number of formats that the formats object
   * contains.
   * Note that DMA buffers are a Linux concept, so on other
   * platforms, [gdk.dmabuf_formats.DmabufFormats.getNFormats] will
   * always return zero.
   * Returns: the number of formats
   */
  size_t getNFormats()
  {
    size_t _retval;
    _retval = gdk_dmabuf_formats_get_n_formats(cast(GdkDmabufFormats*)cPtr);
    return _retval;
  }
}
