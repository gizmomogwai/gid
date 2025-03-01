module gio.file_output_stream;

import gid.global;
import gio.async_result;
import gio.async_result_mixin;
import gio.c.functions;
import gio.c.types;
import gio.cancellable;
import gio.file_info;
import gio.output_stream;
import gio.seekable;
import gio.seekable_mixin;
import gio.types;
import glib.error;
import gobject.object;

/**
 * `GFileOutputStream` provides output streams that write their
 * content to a file.
 * `GFileOutputStream` implements [gio.seekable.Seekable], which allows the output
 * stream to jump to arbitrary positions in the file and to truncate
 * the file, provided the filesystem of the file supports these
 * operations.
 * To find the position of a file output stream, use [gio.seekable.Seekable.tell].
 * To find out if a file output stream supports seeking, use
 * [gio.seekable.Seekable.canSeek].To position a file output stream, use
 * [gio.seekable.Seekable.seek]. To find out if a file output stream supports
 * truncating, use [gio.seekable.Seekable.canTruncate]. To truncate a file output
 * stream, use [gio.seekable.Seekable.truncate].
 */
class FileOutputStream : OutputStream, Seekable
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_file_output_stream_get_type != &gidSymbolNotFound ? g_file_output_stream_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SeekableT!();

  /**
   * Gets the entity tag for the file when it has been written.
   * This must be called after the stream has been written
   * and closed, as the etag can change while writing.
   * Returns: the entity tag for the stream.
   */
  string getEtag()
  {
    char* _cretval;
    _cretval = g_file_output_stream_get_etag(cast(GFileOutputStream*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Queries a file output stream for the given attributes.
   * This function blocks while querying the stream. For the asynchronous
   * version of this function, see [gio.file_output_stream.FileOutputStream.queryInfoAsync].
   * While the stream is blocked, the stream will set the pending flag
   * internally, and any other operations on the stream will fail with
   * %G_IO_ERROR_PENDING.
   * Can fail if the stream was already closed $(LPAREN)with error being set to
   * %G_IO_ERROR_CLOSED$(RPAREN), the stream has pending operations $(LPAREN)with error being
   * set to %G_IO_ERROR_PENDING$(RPAREN), or if querying info is not supported for
   * the stream's interface $(LPAREN)with error being set to %G_IO_ERROR_NOT_SUPPORTED$(RPAREN). In
   * all cases of failure, %NULL will be returned.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be set, and %NULL will
   * be returned.
   * Params:
   *   attributes = a file attribute query string.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a #GFileInfo for the stream, or %NULL on error.
   */
  FileInfo queryInfo(string attributes, Cancellable cancellable)
  {
    GFileInfo* _cretval;
    const(char)* _attributes = attributes.toCString(No.Alloc);
    GError *_err;
    _cretval = g_file_output_stream_query_info(cast(GFileOutputStream*)cPtr, _attributes, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Asynchronously queries the stream for a #GFileInfo. When completed,
   * callback will be called with a #GAsyncResult which can be used to
   * finish the operation with [gio.file_output_stream.FileOutputStream.queryInfoFinish].
   * For the synchronous version of this function, see
   * [gio.file_output_stream.FileOutputStream.queryInfo].
   * Params:
   *   attributes = a file attribute query string.
   *   ioPriority = the [I/O priority](iface.AsyncResult.html#io-priority) of the
   *     request
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = callback to call when the request is satisfied
   */
  void queryInfoAsync(string attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    const(char)* _attributes = attributes.toCString(No.Alloc);
    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_file_output_stream_query_info_async(cast(GFileOutputStream*)cPtr, _attributes, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Finalizes the asynchronous query started
   * by [gio.file_output_stream.FileOutputStream.queryInfoAsync].
   * Params:
   *   result = a #GAsyncResult.
   * Returns: A #GFileInfo for the finished query.
   */
  FileInfo queryInfoFinish(AsyncResult result)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_output_stream_query_info_finish(cast(GFileOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, Yes.Take);
    return _retval;
  }
}
