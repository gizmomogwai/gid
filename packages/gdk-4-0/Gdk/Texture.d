module Gdk.Texture;

import GLib.ErrorG;
import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import GdkPixbuf.Pixbuf;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gio.Icon;
import Gio.IconT;
import Gio.LoadableIcon;
import Gio.LoadableIconT;

/**
 * `GdkTexture` is the basic element used to refer to pixel data.
 * It is primarily meant for pixel data that will not change over
 * multiple frames, and will be used for a long time.
 * There are various ways to create `GdkTexture` objects from a
 * [GdkPixbuf.Pixbuf], or from bytes stored in memory, a file, or a
 * [Gio.Resource].
 * The ownership of the pixel data is transferred to the `GdkTexture`
 * instance; you can only make a copy of it, via [Gdk.Texture.download].
 * `GdkTexture` is an immutable object: That means you cannot change
 * anything about it other than increasing the reference count via
 * [GObject.ObjectG.ref_], and consequently, it is a thread-safe object.
 */
class Texture : ObjectG, Paintable, Icon, LoadableIcon
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return gdk_texture_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin PaintableT!();
  mixin IconT!();
  mixin LoadableIconT!();

  /**
   * Creates a new texture object representing the `GdkPixbuf`.
   * This function is threadsafe, so that you can e.g. use GTask
   * and [Gio.Task.runInThread] to avoid blocking the main thread
   * while loading a big image.
   * Params:
   *   pixbuf = a `GdkPixbuf`
   * Returns: a new `GdkTexture`
   */
  static Texture newForPixbuf(Pixbuf pixbuf)
  {
    GdkTexture* _cretval;
    _cretval = gdk_texture_new_for_pixbuf(pixbuf ? cast(PixbufC*)pixbuf.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Creates a new texture by loading an image from a file.
   * The file format is detected automatically. The supported formats
   * are PNG, JPEG and TIFF, though more formats might be available.
   * If %NULL is returned, then error will be set.
   * This function is threadsafe, so that you can e.g. use GTask
   * and [Gio.Task.runInThread] to avoid blocking the main thread
   * while loading a big image.
   * Params:
   *   file = `GFile` to load
   * Returns: A newly-created `GdkTexture`
   */
  static Texture newFromFile(File file)
  {
    GdkTexture* _cretval;
    GError *_err;
    _cretval = gdk_texture_new_from_file(file ? cast(GFile*)(cast(ObjectG)file).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Creates a new texture by loading an image from a file.
   * The file format is detected automatically. The supported formats
   * are PNG, JPEG and TIFF, though more formats might be available.
   * If %NULL is returned, then error will be set.
   * This function is threadsafe, so that you can e.g. use GTask
   * and [Gio.Task.runInThread] to avoid blocking the main thread
   * while loading a big image.
   * Params:
   *   path = the filename to load
   * Returns: A newly-created `GdkTexture`
   */
  static Texture newFromFilename(string path)
  {
    GdkTexture* _cretval;
    const(char)* _path = path.toCString(No.Alloc);
    GError *_err;
    _cretval = gdk_texture_new_from_filename(_path, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Creates a new texture by loading an image from a resource.
   * The file format is detected automatically. The supported formats
   * are PNG and JPEG, though more formats might be available.
   * It is a fatal error if resource_path does not specify a valid
   * image resource and the program will abort if that happens.
   * If you are unsure about the validity of a resource, use
   * [Gdk.Texture.newFromFile] to load it.
   * This function is threadsafe, so that you can e.g. use GTask
   * and [Gio.Task.runInThread] to avoid blocking the main thread
   * while loading a big image.
   * Params:
   *   resourcePath = the path of the resource file
   * Returns: A newly-created `GdkTexture`
   */
  static Texture newFromResource(string resourcePath)
  {
    GdkTexture* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(No.Alloc);
    _cretval = gdk_texture_new_from_resource(_resourcePath);
    auto _retval = ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the memory format most closely associated with the data of
   * the texture.
   * Note that it may not be an exact match for texture data
   * stored on the GPU or with compression.
   * The format can give an indication about the bit depth and opacity
   * of the texture and is useful to determine the best format for
   * downloading the texture.
   * Returns: the preferred format for the texture's data
   */
  MemoryFormat getFormat()
  {
    GdkMemoryFormat _cretval;
    _cretval = gdk_texture_get_format(cast(GdkTexture*)cPtr);
    MemoryFormat _retval = cast(MemoryFormat)_cretval;
    return _retval;
  }

  /**
   * Returns the height of the texture, in pixels.
   * Returns: the height of the `GdkTexture`
   */
  int getHeight()
  {
    int _retval;
    _retval = gdk_texture_get_height(cast(GdkTexture*)cPtr);
    return _retval;
  }

  /**
   * Returns the width of texture, in pixels.
   * Returns: the width of the `GdkTexture`
   */
  int getWidth()
  {
    int _retval;
    _retval = gdk_texture_get_width(cast(GdkTexture*)cPtr);
    return _retval;
  }

  /**
   * Store the given texture to the filename as a PNG file.
   * This is a utility function intended for debugging and testing.
   * If you want more control over formats, proper error handling or
   * want to store to a [Gio.File] or other location, you might want to
   * use [Gdk.Texture.saveToPngBytes] or look into the
   * gdk-pixbuf library.
   * Params:
   *   filename = the filename to store to
   * Returns: %TRUE if saving succeeded, %FALSE on failure.
   */
  bool saveToPng(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(No.Alloc);
    _retval = gdk_texture_save_to_png(cast(GdkTexture*)cPtr, _filename);
    return _retval;
  }

  /**
   * Store the given texture to the filename as a TIFF file.
   * GTK will attempt to store data without loss.
   * Params:
   *   filename = the filename to store to
   * Returns: %TRUE if saving succeeded, %FALSE on failure.
   */
  bool saveToTiff(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(No.Alloc);
    _retval = gdk_texture_save_to_tiff(cast(GdkTexture*)cPtr, _filename);
    return _retval;
  }
}
