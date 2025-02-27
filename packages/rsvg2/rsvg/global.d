module Rsvg.global;

import gdkpixbuf.pixbuf;
import gid.gid;
import glib.error;
import gobject.object;
import rsvg.c.functions;
import rsvg.c.types;
import rsvg.types;


/**
 * This function does nothing.

 * Deprecated: No-op. This function should not be called from normal programs.
 */
void cleanup()
{
  rsvg_cleanup();
}

/**
 * This function does nothing.

 * Deprecated: There is no need to initialize librsvg.
 */
void init_()
{
  rsvg_init();
}

/**
 * Loads a new `GdkPixbuf` from filename and returns it.  The caller must
 * assume the reference to the reurned pixbuf. If an error occurred, error is
 * set and `NULL` is returned.
 * Params:
 *   filename = A file name
 * Returns: A pixbuf, or %NULL on error.

 * Deprecated: Use [Rsvg.Handle.newFromFile] and [Rsvg.Handle.renderDocument] instead.
 */
Pixbuf pixbufFromFile(string filename)
{
  PixbufC* _cretval;
  const(char)* _filename = filename.toCString(No.Alloc);
  GError *_err;
  _cretval = rsvg_pixbuf_from_file(_filename, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, Yes.Take);
  return _retval;
}

/**
 * Loads a new `GdkPixbuf` from filename and returns it.  This pixbuf is uniformly
 * scaled so that the it fits into a rectangle of size `max_width * max_height`. The
 * caller must assume the reference to the returned pixbuf. If an error occurred,
 * error is set and `NULL` is returned.
 * Params:
 *   filename = A file name
 *   maxWidth = The requested max width
 *   maxHeight = The requested max height
 * Returns: A pixbuf, or %NULL on error.

 * Deprecated: Use [Rsvg.Handle.newFromFile] and [Rsvg.Handle.renderDocument] instead.
 */
Pixbuf pixbufFromFileAtMaxSize(string filename, int maxWidth, int maxHeight)
{
  PixbufC* _cretval;
  const(char)* _filename = filename.toCString(No.Alloc);
  GError *_err;
  _cretval = rsvg_pixbuf_from_file_at_max_size(_filename, maxWidth, maxHeight, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, Yes.Take);
  return _retval;
}

/**
 * Loads a new `GdkPixbuf` from filename and returns it.  This pixbuf is scaled
 * from the size indicated to the new size indicated by width and height.  If
 * both of these are -1, then the default size of the image being loaded is
 * used.  The caller must assume the reference to the returned pixbuf. If an
 * error occurred, error is set and `NULL` is returned.
 * Params:
 *   filename = A file name
 *   width = The new width, or -1
 *   height = The new height, or -1
 * Returns: A pixbuf, or %NULL on error.

 * Deprecated: Use [Rsvg.Handle.newFromFile] and [Rsvg.Handle.renderDocument] instead.
 */
Pixbuf pixbufFromFileAtSize(string filename, int width, int height)
{
  PixbufC* _cretval;
  const(char)* _filename = filename.toCString(No.Alloc);
  GError *_err;
  _cretval = rsvg_pixbuf_from_file_at_size(_filename, width, height, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, Yes.Take);
  return _retval;
}

/**
 * Loads a new `GdkPixbuf` from filename and returns it.  This pixbuf is scaled
 * from the size indicated by the file by a factor of x_zoom and y_zoom.  The
 * caller must assume the reference to the returned pixbuf. If an error
 * occurred, error is set and `NULL` is returned.
 * Params:
 *   filename = A file name
 *   xZoom = The horizontal zoom factor
 *   yZoom = The vertical zoom factor
 * Returns: A pixbuf, or %NULL on error.

 * Deprecated: Use [Rsvg.Handle.newFromFile] and [Rsvg.Handle.renderDocument] instead.
 */
Pixbuf pixbufFromFileAtZoom(string filename, double xZoom, double yZoom)
{
  PixbufC* _cretval;
  const(char)* _filename = filename.toCString(No.Alloc);
  GError *_err;
  _cretval = rsvg_pixbuf_from_file_at_zoom(_filename, xZoom, yZoom, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, Yes.Take);
  return _retval;
}

/**
 * Loads a new `GdkPixbuf` from filename and returns it.  This pixbuf is scaled
 * from the size indicated by the file by a factor of x_zoom and y_zoom. If the
 * resulting pixbuf would be larger than max_width/max_heigh it is uniformly scaled
 * down to fit in that rectangle. The caller must assume the reference to the
 * returned pixbuf. If an error occurred, error is set and `NULL` is returned.
 * Params:
 *   filename = A file name
 *   xZoom = The horizontal zoom factor
 *   yZoom = The vertical zoom factor
 *   maxWidth = The requested max width
 *   maxHeight = The requested max height
 * Returns: A pixbuf, or %NULL on error.

 * Deprecated: Use [Rsvg.Handle.newFromFile] and [Rsvg.Handle.renderDocument] instead.
 */
Pixbuf pixbufFromFileAtZoomWithMax(string filename, double xZoom, double yZoom, int maxWidth, int maxHeight)
{
  PixbufC* _cretval;
  const(char)* _filename = filename.toCString(No.Alloc);
  GError *_err;
  _cretval = rsvg_pixbuf_from_file_at_zoom_with_max(_filename, xZoom, yZoom, maxWidth, maxHeight, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, Yes.Take);
  return _retval;
}

/**
 * Do not use this function.  Create an [Rsvg.Handle] and call
 * [Rsvg.Handle.setDpi] on it instead.
 * Params:
 *   dpi = Dots Per Inch $(LPAREN)aka Pixels Per Inch$(RPAREN)

 * Deprecated: This function used to set a global default DPI.  However,
 *   it only worked if it was called before any [Rsvg.Handle] objects had been
 *   created; it would not work after that.  To avoid global mutable state, please
 *   use [Rsvg.Handle.setDpi] instead.
 */
void setDefaultDpi(double dpi)
{
  rsvg_set_default_dpi(dpi);
}

/**
 * Do not use this function.  Create an [Rsvg.Handle] and call
 * [Rsvg.Handle.setDpiXY] on it instead.
 * Params:
 *   dpiX = Dots Per Inch $(LPAREN)aka Pixels Per Inch$(RPAREN)
 *   dpiY = Dots Per Inch $(LPAREN)aka Pixels Per Inch$(RPAREN)

 * Deprecated: This function used to set a global default DPI.  However,
 *   it only worked if it was called before any [Rsvg.Handle] objects had been
 *   created; it would not work after that.  To avoid global mutable state, please
 *   use [Rsvg.Handle.setDpi] instead.
 */
void setDefaultDpiXY(double dpiX, double dpiY)
{
  rsvg_set_default_dpi_x_y(dpiX, dpiY);
}

/**
 * This function does nothing.

 * Deprecated: There is no need to de-initialize librsvg.
 */
void term()
{
  rsvg_term();
}
