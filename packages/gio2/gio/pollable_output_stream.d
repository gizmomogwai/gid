module gio.pollable_output_stream;

public import gio.pollable_output_stream_iface_proxy;
import gid.global;
import gio.c.functions;
import gio.c.types;
import gio.cancellable;
import gio.types;
import glib.error;
import glib.source;

/**
 * `GPollableOutputStream` is implemented by [gio.output_stream.OutputStream]s that
 * can be polled for readiness to write. This can be used when
 * interfacing with a non-GIO API that expects
 * UNIX-file-descriptor-style asynchronous I/O rather than GIO-style.
 * Some classes may implement `GPollableOutputStream` but have only certain
 * instances of that class be pollable. If [gio.pollable_output_stream.PollableOutputStream.canPoll]
 * returns false, then the behavior of other `GPollableOutputStream` methods is
 * undefined.
 */
interface PollableOutputStream
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_pollable_output_stream_get_type != &gidSymbolNotFound ? g_pollable_output_stream_get_type() : cast(GType)0;
  }

  /**
   * Checks if stream is actually pollable. Some classes may implement
   * #GPollableOutputStream but have only certain instances of that
   * class be pollable. If this method returns %FALSE, then the behavior
   * of other #GPollableOutputStream methods is undefined.
   * For any given stream, the value returned by this method is constant;
   * a stream cannot switch from pollable to non-pollable or vice versa.
   * Returns: %TRUE if stream is pollable, %FALSE if not.
   */
  bool canPoll();

  /**
   * Creates a #GSource that triggers when stream can be written, or
   * cancellable is triggered or an error occurs. The callback on the
   * source is of the #GPollableSourceFunc type.
   * As with [gio.pollable_output_stream.PollableOutputStream.isWritable], it is possible that
   * the stream may not actually be writable even after the source
   * triggers, so you should use [gio.pollable_output_stream.PollableOutputStream.writeNonblocking]
   * rather than [gio.output_stream.OutputStream.write] from the callback.
   * The behaviour of this method is undefined if
   * [gio.pollable_output_stream.PollableOutputStream.canPoll] returns %FALSE for stream.
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a new #GSource
   */
  Source createSource(Cancellable cancellable);

  /**
   * Checks if stream can be written.
   * Note that some stream types may not be able to implement this 100%
   * reliably, and it is possible that a call to [gio.output_stream.OutputStream.write]
   * after this returns %TRUE would still block. To guarantee
   * non-blocking behavior, you should always use
   * [gio.pollable_output_stream.PollableOutputStream.writeNonblocking], which will return a
   * %G_IO_ERROR_WOULD_BLOCK error rather than blocking.
   * The behaviour of this method is undefined if
   * [gio.pollable_output_stream.PollableOutputStream.canPoll] returns %FALSE for stream.
   * Returns: %TRUE if stream is writable, %FALSE if not. If an error
   *   has occurred on stream, this will result in
   *   [gio.pollable_output_stream.PollableOutputStream.isWritable] returning %TRUE, and the
   *   next attempt to write will return the error.
   */
  bool isWritable();

  /**
   * Attempts to write up to count bytes from buffer to stream, as
   * with [gio.output_stream.OutputStream.write]. If stream is not currently writable,
   * this will immediately return %G_IO_ERROR_WOULD_BLOCK, and you can
   * use [gio.pollable_output_stream.PollableOutputStream.createSource] to create a #GSource
   * that will be triggered when stream is writable.
   * Note that since this method never blocks, you cannot actually
   * use cancellable to cancel it. However, it will return an error
   * if cancellable has already been cancelled when you call, which
   * may happen if you call this method after a source triggers due
   * to having been cancelled.
   * Also note that if %G_IO_ERROR_WOULD_BLOCK is returned some underlying
   * transports like D/TLS require that you re-send the same buffer and
   * count in the next write call.
   * The behaviour of this method is undefined if
   * [gio.pollable_output_stream.PollableOutputStream.canPoll] returns %FALSE for stream.
   * Params:
   *   buffer = a buffer to write
   *     data from
   *   cancellable = a #GCancellable, or %NULL
   * Returns: the number of bytes written, or -1 on error $(LPAREN)including
   *   %G_IO_ERROR_WOULD_BLOCK$(RPAREN).
   */
  ptrdiff_t writeNonblocking(ubyte[] buffer, Cancellable cancellable);

  /**
   * Attempts to write the bytes contained in the n_vectors vectors to stream,
   * as with [gio.output_stream.OutputStream.writev]. If stream is not currently writable,
   * this will immediately return %G_POLLABLE_RETURN_WOULD_BLOCK, and you can
   * use [gio.pollable_output_stream.PollableOutputStream.createSource] to create a #GSource
   * that will be triggered when stream is writable. error will *not* be
   * set in that case.
   * Note that since this method never blocks, you cannot actually
   * use cancellable to cancel it. However, it will return an error
   * if cancellable has already been cancelled when you call, which
   * may happen if you call this method after a source triggers due
   * to having been cancelled.
   * Also note that if %G_POLLABLE_RETURN_WOULD_BLOCK is returned some underlying
   * transports like D/TLS require that you re-send the same vectors and
   * n_vectors in the next write call.
   * The behaviour of this method is undefined if
   * [gio.pollable_output_stream.PollableOutputStream.canPoll] returns %FALSE for stream.
   * Params:
   *   vectors = the buffer containing the #GOutputVectors to write.
   *   bytesWritten = location to store the number of bytes that were
   *     written to the stream
   *   cancellable = a #GCancellable, or %NULL
   * Returns: %G_POLLABLE_RETURN_OK on success, %G_POLLABLE_RETURN_WOULD_BLOCK
   *   if the stream is not currently writable $(LPAREN)and error is *not* set$(RPAREN), or
   *   %G_POLLABLE_RETURN_FAILED if there was an error in which case error will
   *   be set.
   */
  PollableReturn writevNonblocking(OutputVector[] vectors, out size_t bytesWritten, Cancellable cancellable);
}
