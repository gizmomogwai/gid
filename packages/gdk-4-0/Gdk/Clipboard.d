module Gdk.Clipboard;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gdk.ContentFormats;
import Gdk.ContentProvider;
import Gdk.Display;
import Gdk.Texture;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.Types;

/**
 * The `GdkClipboard` object represents data shared between applications or
 * inside an application.
 * To get a `GdkClipboard` object, use [Gdk.Display.getClipboard] or
 * [Gdk.Display.getPrimaryClipboard]. You can find out about the data
 * that is currently available in a clipboard using
 * [Gdk.Clipboard.getFormats].
 * To make text or image data available in a clipboard, use
 * [Gdk.Clipboard.setText] or [Gdk.Clipboard.setTexture].
 * For other data, you can use [Gdk.Clipboard.setContent], which
 * takes a [Gdk.ContentProvider] object.
 * To read textual or image data from a clipboard, use
 * [Gdk.Clipboard.readTextAsync] or
 * [Gdk.Clipboard.readTextureAsync]. For other data, use
 * [Gdk.Clipboard.readAsync], which provides a `GInputStream` object.
 */
class Clipboard : ObjectG
{

  this()
  {
  }

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return gdk_clipboard_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the `GdkContentProvider` currently set on clipboard.
   * If the clipboard is empty or its contents are not owned by the
   * current process, %NULL will be returned.
   * Returns: The content of a clipboard
   *   if the clipboard does not maintain any content
   */
  ContentProvider getContent()
  {
    GdkContentProvider* _cretval;
    _cretval = gdk_clipboard_get_content(cast(GdkClipboard*)cPtr);
    auto _retval = ObjectG.getDObject!ContentProvider(cast(GdkContentProvider*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the `GdkDisplay` that the clipboard was created for.
   * Returns: a `GdkDisplay`
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_clipboard_get_display(cast(GdkClipboard*)cPtr);
    auto _retval = ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the formats that the clipboard can provide its current contents in.
   * Returns: The formats of the clipboard
   */
  ContentFormats getFormats()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_clipboard_get_formats(cast(GdkClipboard*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Returns if the clipboard is local.
   * A clipboard is considered local if it was last claimed
   * by the running application.
   * Note that [Gdk.Clipboard.getContent] may return %NULL
   * even on a local clipboard. In this case the clipboard is empty.
   * Returns: %TRUE if the clipboard is local
   */
  bool isLocal()
  {
    bool _retval;
    _retval = gdk_clipboard_is_local(cast(GdkClipboard*)cPtr);
    return _retval;
  }

  /**
   * Asynchronously requests an input stream to read the clipboard's
   * contents from.
   * When the operation is finished callback will be called. You must then
   * call [Gdk.Clipboard.readFinish] to get the result of the operation.
   * The clipboard will choose the most suitable mime type from the given list
   * to fulfill the request, preferring the ones listed first.
   * Params:
   *   mimeTypes = a %NULL-terminated array of mime types to choose from
   *   ioPriority = the I/O priority of the request
   *   cancellable = optional `GCancellable` object
   *   callback = callback to call when the request is satisfied
   */
  void readAsync(string[] mimeTypes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }

    char*[] _tmpmimeTypes;
    foreach (s; mimeTypes)
      _tmpmimeTypes ~= s.toCString(No.Alloc);
    _tmpmimeTypes ~= null;
    const(char*)* _mimeTypes = _tmpmimeTypes.ptr;

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_clipboard_read_async(cast(GdkClipboard*)cPtr, _mimeTypes, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous clipboard read.
   * See [Gdk.Clipboard.readAsync].
   * Params:
   *   result = a `GAsyncResult`
   *   outMimeType = location to store
   *     the chosen mime type
   * Returns: a `GInputStream`
   */
  InputStream readFinish(AsyncResult result, out string outMimeType)
  {
    GInputStream* _cretval;
    char* _outMimeType;
    GError *_err;
    _cretval = gdk_clipboard_read_finish(cast(GdkClipboard*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_outMimeType, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, Yes.Take);
    outMimeType = _outMimeType.fromCString(No.Free);
    return _retval;
  }

  /**
   * Asynchronously request the clipboard contents converted to a string.
   * When the operation is finished callback will be called. You must then
   * call [Gdk.Clipboard.readTextFinish] to get the result.
   * This is a simple wrapper around [Gdk.Clipboard.readValueAsync].
   * Use that function or [Gdk.Clipboard.readAsync] directly if you
   * need more control over the operation.
   * Params:
   *   cancellable = optional `GCancellable` object
   *   callback = callback to call when the request is satisfied
   */
  void readTextAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_clipboard_read_text_async(cast(GdkClipboard*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous clipboard read.
   * See [Gdk.Clipboard.readTextAsync].
   * Params:
   *   result = a `GAsyncResult`
   * Returns: a new string
   */
  string readTextFinish(AsyncResult result)
  {
    char* _cretval;
    GError *_err;
    _cretval = gdk_clipboard_read_text_finish(cast(GdkClipboard*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Asynchronously request the clipboard contents converted to a `GdkPixbuf`.
   * When the operation is finished callback will be called. You must then
   * call [Gdk.Clipboard.readTextureFinish] to get the result.
   * This is a simple wrapper around [Gdk.Clipboard.readValueAsync].
   * Use that function or [Gdk.Clipboard.readAsync] directly if you
   * need more control over the operation.
   * Params:
   *   cancellable = optional `GCancellable` object, %NULL to ignore.
   *   callback = callback to call when the request is satisfied
   */
  void readTextureAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_clipboard_read_texture_async(cast(GdkClipboard*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous clipboard read.
   * See [Gdk.Clipboard.readTextureAsync].
   * Params:
   *   result = a `GAsyncResult`
   * Returns: a new `GdkTexture`
   */
  Texture readTextureFinish(AsyncResult result)
  {
    GdkTexture* _cretval;
    GError *_err;
    _cretval = gdk_clipboard_read_texture_finish(cast(GdkClipboard*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Asynchronously request the clipboard contents converted to the given
   * type.
   * When the operation is finished callback will be called. You must then call
   * [Gdk.Clipboard.readValueFinish] to get the resulting `GValue`.
   * For local clipboard contents that are available in the given `GType`,
   * the value will be copied directly. Otherwise, GDK will try to use
   * funccontent_deserialize_async to convert the clipboard's data.
   * Params:
   *   type = a `GType` to read
   *   ioPriority = the I/O priority of the request
   *   cancellable = optional `GCancellable` object
   *   callback = callback to call when the request is satisfied
   */
  void readValueAsync(GType type, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_clipboard_read_value_async(cast(GdkClipboard*)cPtr, type, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous clipboard read.
   * See [Gdk.Clipboard.readValueAsync].
   * Params:
   *   result = a `GAsyncResult`
   * Returns: a `GValue` containing the result.
   */
  Value readValueFinish(AsyncResult result)
  {
    const(GValue)* _cretval;
    GError *_err;
    _cretval = gdk_clipboard_read_value_finish(cast(GdkClipboard*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Sets a new content provider on clipboard.
   * The clipboard will claim the `GdkDisplay`'s resources and advertise
   * these new contents to other applications.
   * In the rare case of a failure, this function will return %FALSE. The
   * clipboard will then continue reporting its old contents and ignore
   * provider.
   * If the contents are read by either an external application or the
   * clipboard's read functions, clipboard will select the best format to
   * transfer the contents and then request that format from provider.
   * Params:
   *   provider = the new contents of clipboard
   *     or %NULL to clear the clipboard
   * Returns: %TRUE if setting the clipboard succeeded
   */
  bool setContent(ContentProvider provider)
  {
    bool _retval;
    _retval = gdk_clipboard_set_content(cast(GdkClipboard*)cPtr, provider ? cast(GdkContentProvider*)provider.cPtr(No.Dup) : null);
    return _retval;
  }

  /**
   * Sets the clipboard to contain the given value.
   * Params:
   *   value = a `GValue` to set
   */
  void set(Value value)
  {
    gdk_clipboard_set_value(cast(GdkClipboard*)cPtr, value ? cast(GValue*)value.cPtr(No.Dup) : null);
  }

  /**
   * Asynchronously instructs the clipboard to store its contents remotely.
   * If the clipboard is not local, this function does nothing but report success.
   * The callback must call [Gdk.Clipboard.storeFinish].
   * The purpose of this call is to preserve clipboard contents beyond the
   * lifetime of an application, so this function is typically called on
   * exit. Depending on the platform, the functionality may not be available
   * unless a "clipboard manager" is running.
   * This function is called automatically when a
   * [GtkApplication](../gtk4/class.Application.html)
   * is shut down, so you likely don't need to call it.
   * Params:
   *   ioPriority = the I/O priority of the request
   *   cancellable = optional `GCancellable` object
   *   callback = callback to call when the request is satisfied
   */
  void storeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_clipboard_store_async(cast(GdkClipboard*)cPtr, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous clipboard store.
   * See [Gdk.Clipboard.storeAsync].
   * Params:
   *   result = a `GAsyncResult`
   * Returns: %TRUE if storing was successful.
   */
  bool storeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = gdk_clipboard_store_finish(cast(GdkClipboard*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Emitted when the clipboard changes ownership.
   *   clipboard = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(Clipboard clipboard);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto clipboard = getVal!Clipboard(_paramVals);
      _dgClosure.dlg(clipboard);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }
}
