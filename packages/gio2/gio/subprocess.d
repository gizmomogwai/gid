module gio.subprocess;

import gid.global;
import gio.async_result;
import gio.async_result_mixin;
import gio.c.functions;
import gio.c.types;
import gio.cancellable;
import gio.initable;
import gio.initable_mixin;
import gio.input_stream;
import gio.output_stream;
import gio.types;
import glib.bytes;
import glib.error;
import gobject.object;

/**
 * `GSubprocess` allows the creation of and interaction with child
 * processes.
 * Processes can be communicated with using standard GIO-style APIs $(LPAREN)ie:
 * [gio.input_stream.InputStream], [gio.output_stream.OutputStream]$(RPAREN). There are GIO-style APIs
 * to wait for process termination $(LPAREN)ie: cancellable and with an asynchronous
 * variant$(RPAREN).
 * There is an API to force a process to terminate, as well as a
 * race-free API for sending UNIX signals to a subprocess.
 * One major advantage that GIO brings over the core GLib library is
 * comprehensive API for asynchronous I/O, such
 * [gio.output_stream.OutputStream.spliceAsync].  This makes `GSubprocess`
 * significantly more powerful and flexible than equivalent APIs in
 * some other languages such as the `subprocess.py`
 * included with Python.  For example, using `GSubprocess` one could
 * create two child processes, reading standard output from the first,
 * processing it, and writing to the input stream of the second, all
 * without blocking the main loop.
 * A powerful [gio.subprocess.Subprocess.communicate] API is provided similar to the
 * `communicate$(LPAREN)$(RPAREN)` method of `subprocess.py`. This enables very easy
 * interaction with a subprocess that has been opened with pipes.
 * `GSubprocess` defaults to tight control over the file descriptors open
 * in the child process, avoiding dangling-FD issues that are caused by
 * a simple `fork$(LPAREN)$(RPAREN)`/`exec$(LPAREN)$(RPAREN)`.  The only open file descriptors in the
 * spawned process are ones that were explicitly specified by the
 * `GSubprocess` API $(LPAREN)unless `G_SUBPROCESS_FLAGS_INHERIT_FDS` was
 * specified$(RPAREN).
 * `GSubprocess` will quickly reap all child processes as they exit,
 * avoiding ‘zombie processes’ remaining around for long periods of
 * time.  [gio.subprocess.Subprocess.wait] can be used to wait for this to happen,
 * but it will happen even without the call being explicitly made.
 * As a matter of principle, `GSubprocess` has no API that accepts
 * shell-style space-separated strings.  It will, however, match the
 * typical shell behaviour of searching the `PATH` for executables that do
 * not contain a directory separator in their name. By default, the `PATH`
 * of the current process is used.  You can specify
 * `G_SUBPROCESS_FLAGS_SEARCH_PATH_FROM_ENVP` to use the `PATH` of the
 * launcher environment instead.
 * `GSubprocess` attempts to have a very simple API for most uses $(LPAREN)ie:
 * spawning a subprocess with arguments and support for most typical
 * kinds of input and output redirection$(RPAREN).  See [gio.subprocess.Subprocess.new_]. The
 * [gio.subprocess_launcher.SubprocessLauncher] API is provided for more complicated cases
 * $(LPAREN)advanced types of redirection, environment variable manipulation,
 * change of working directory, child setup functions, etc$(RPAREN).
 * A typical use of `GSubprocess` will involve calling
 * [gio.subprocess.Subprocess.new_], followed by [gio.subprocess.Subprocess.waitAsync] or
 * [gio.subprocess.Subprocess.wait].  After the process exits, the status can be
 * checked using functions such as [gio.subprocess.Subprocess.getIfExited] $(LPAREN)which
 * are similar to the familiar `WIFEXITED`-style POSIX macros$(RPAREN).
 */
class Subprocess : ObjectG, Initable
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_subprocess_get_type != &gidSymbolNotFound ? g_subprocess_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin InitableT!();

  /**
   * Create a new process with the given flags and argument list.
   * The argument list is expected to be %NULL-terminated.
   * Params:
   *   argv = commandline arguments for the subprocess
   *   flags = flags that define the behaviour of the subprocess
   * Returns: A newly created #GSubprocess, or %NULL on error $(LPAREN)and error
   *   will be set$(RPAREN)
   */
  static Subprocess new_(string[] argv, SubprocessFlags flags)
  {
    GSubprocess* _cretval;
    const(char)*[] _tmpargv;
    foreach (s; argv)
      _tmpargv ~= s.toCString(No.Alloc);
    _tmpargv ~= null;
    const(char*)* _argv = _tmpargv.ptr;

    GError *_err;
    _cretval = g_subprocess_newv(_argv, flags, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!Subprocess(cast(GSubprocess*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Communicate with the subprocess until it terminates, and all input
   * and output has been completed.
   * If stdin_buf is given, the subprocess must have been created with
   * %G_SUBPROCESS_FLAGS_STDIN_PIPE.  The given data is fed to the
   * stdin of the subprocess and the pipe is closed $(LPAREN)ie: EOF$(RPAREN).
   * At the same time $(LPAREN)as not to cause blocking when dealing with large
   * amounts of data$(RPAREN), if %G_SUBPROCESS_FLAGS_STDOUT_PIPE or
   * %G_SUBPROCESS_FLAGS_STDERR_PIPE were used, reads from those
   * streams.  The data that was read is returned in stdout and/or
   * the stderr.
   * If the subprocess was created with %G_SUBPROCESS_FLAGS_STDOUT_PIPE,
   * stdout_buf will contain the data read from stdout.  Otherwise, for
   * subprocesses not created with %G_SUBPROCESS_FLAGS_STDOUT_PIPE,
   * stdout_buf will be set to %NULL.  Similar provisions apply to
   * stderr_buf and %G_SUBPROCESS_FLAGS_STDERR_PIPE.
   * As usual, any output variable may be given as %NULL to ignore it.
   * If you desire the stdout and stderr data to be interleaved, create
   * the subprocess with %G_SUBPROCESS_FLAGS_STDOUT_PIPE and
   * %G_SUBPROCESS_FLAGS_STDERR_MERGE.  The merged result will be returned
   * in stdout_buf and stderr_buf will be set to %NULL.
   * In case of any error $(LPAREN)including cancellation$(RPAREN), %FALSE will be
   * returned with error set.  Some or all of the stdin data may have
   * been written.  Any stdout or stderr data that has been read will be
   * discarded. None of the out variables $(LPAREN)aside from error$(RPAREN) will have
   * been set to anything in particular and should not be inspected.
   * In the case that %TRUE is returned, the subprocess has exited and the
   * exit status inspection APIs $(LPAREN)eg: [gio.subprocess.Subprocess.getIfExited],
   * [gio.subprocess.Subprocess.getExitStatus]$(RPAREN) may be used.
   * You should not attempt to use any of the subprocess pipes after
   * starting this function, since they may be left in strange states,
   * even if the operation was cancelled.  You should especially not
   * attempt to interact with the pipes while the operation is in progress
   * $(LPAREN)either from another thread or if using the asynchronous version$(RPAREN).
   * Params:
   *   stdinBuf = data to send to the stdin of the subprocess, or %NULL
   *   cancellable = a #GCancellable
   *   stdoutBuf = data read from the subprocess stdout
   *   stderrBuf = data read from the subprocess stderr
   * Returns: %TRUE if successful
   */
  bool communicate(Bytes stdinBuf, Cancellable cancellable, out Bytes stdoutBuf, out Bytes stderrBuf)
  {
    bool _retval;
    GBytes* _stdoutBuf;
    GBytes* _stderrBuf;
    GError *_err;
    _retval = g_subprocess_communicate(cast(GSubprocess*)cPtr, stdinBuf ? cast(GBytes*)stdinBuf.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_stdoutBuf, &_stderrBuf, &_err);
    if (_err)
      throw new ErrorG(_err);
    stdoutBuf = new Bytes(cast(void*)_stdoutBuf, Yes.Take);
    stderrBuf = new Bytes(cast(void*)_stderrBuf, Yes.Take);
    return _retval;
  }

  /**
   * Asynchronous version of [gio.subprocess.Subprocess.communicate].  Complete
   * invocation with [gio.subprocess.Subprocess.communicateFinish].
   * Params:
   *   stdinBuf = Input data, or %NULL
   *   cancellable = Cancellable
   *   callback = Callback
   */
  void communicateAsync(Bytes stdinBuf, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_subprocess_communicate_async(cast(GSubprocess*)cPtr, stdinBuf ? cast(GBytes*)stdinBuf.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Complete an invocation of [gio.subprocess.Subprocess.communicateAsync].
   * Params:
   *   result = Result
   *   stdoutBuf = Return location for stdout data
   *   stderrBuf = Return location for stderr data
   * Returns:
   */
  bool communicateFinish(AsyncResult result, out Bytes stdoutBuf, out Bytes stderrBuf)
  {
    bool _retval;
    GBytes* _stdoutBuf;
    GBytes* _stderrBuf;
    GError *_err;
    _retval = g_subprocess_communicate_finish(cast(GSubprocess*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_stdoutBuf, &_stderrBuf, &_err);
    if (_err)
      throw new ErrorG(_err);
    stdoutBuf = new Bytes(cast(void*)_stdoutBuf, Yes.Take);
    stderrBuf = new Bytes(cast(void*)_stderrBuf, Yes.Take);
    return _retval;
  }

  /**
   * Like [gio.subprocess.Subprocess.communicate], but validates the output of the
   * process as UTF-8, and returns it as a regular NUL terminated string.
   * On error, stdout_buf and stderr_buf will be set to undefined values and
   * should not be used.
   * Params:
   *   stdinBuf = data to send to the stdin of the subprocess, or %NULL
   *   cancellable = a #GCancellable
   *   stdoutBuf = data read from the subprocess stdout
   *   stderrBuf = data read from the subprocess stderr
   * Returns:
   */
  bool communicateUtf8(string stdinBuf, Cancellable cancellable, out string stdoutBuf, out string stderrBuf)
  {
    bool _retval;
    const(char)* _stdinBuf = stdinBuf.toCString(No.Alloc);
    char* _stdoutBuf;
    char* _stderrBuf;
    GError *_err;
    _retval = g_subprocess_communicate_utf8(cast(GSubprocess*)cPtr, _stdinBuf, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_stdoutBuf, &_stderrBuf, &_err);
    if (_err)
      throw new ErrorG(_err);
    stdoutBuf = _stdoutBuf.fromCString(Yes.Free);
    stderrBuf = _stderrBuf.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Asynchronous version of [gio.subprocess.Subprocess.communicateUtf8].  Complete
   * invocation with [gio.subprocess.Subprocess.communicateUtf8Finish].
   * Params:
   *   stdinBuf = Input data, or %NULL
   *   cancellable = Cancellable
   *   callback = Callback
   */
  void communicateUtf8Async(string stdinBuf, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    const(char)* _stdinBuf = stdinBuf.toCString(No.Alloc);
    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_subprocess_communicate_utf8_async(cast(GSubprocess*)cPtr, _stdinBuf, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Complete an invocation of [gio.subprocess.Subprocess.communicateUtf8Async].
   * Params:
   *   result = Result
   *   stdoutBuf = Return location for stdout data
   *   stderrBuf = Return location for stderr data
   * Returns:
   */
  bool communicateUtf8Finish(AsyncResult result, out string stdoutBuf, out string stderrBuf)
  {
    bool _retval;
    char* _stdoutBuf;
    char* _stderrBuf;
    GError *_err;
    _retval = g_subprocess_communicate_utf8_finish(cast(GSubprocess*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_stdoutBuf, &_stderrBuf, &_err);
    if (_err)
      throw new ErrorG(_err);
    stdoutBuf = _stdoutBuf.fromCString(Yes.Free);
    stderrBuf = _stderrBuf.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Use an operating-system specific method to attempt an immediate,
   * forceful termination of the process.  There is no mechanism to
   * determine whether or not the request itself was successful;
   * however, you can use [gio.subprocess.Subprocess.wait] to monitor the status of
   * the process after calling this function.
   * On Unix, this function sends %SIGKILL.
   */
  void forceExit()
  {
    g_subprocess_force_exit(cast(GSubprocess*)cPtr);
  }

  /**
   * Check the exit status of the subprocess, given that it exited
   * normally.  This is the value passed to the exit$(LPAREN)$(RPAREN) system call or the
   * return value from main.
   * This is equivalent to the system WEXITSTATUS macro.
   * It is an error to call this function before [gio.subprocess.Subprocess.wait] and
   * unless [gio.subprocess.Subprocess.getIfExited] returned %TRUE.
   * Returns: the exit status
   */
  int getExitStatus()
  {
    int _retval;
    _retval = g_subprocess_get_exit_status(cast(GSubprocess*)cPtr);
    return _retval;
  }

  /**
   * On UNIX, returns the process ID as a decimal string.
   * On Windows, returns the result of GetProcessId$(LPAREN)$(RPAREN) also as a string.
   * If the subprocess has terminated, this will return %NULL.
   * Returns: the subprocess identifier, or %NULL if the subprocess
   *   has terminated
   */
  string getIdentifier()
  {
    const(char)* _cretval;
    _cretval = g_subprocess_get_identifier(cast(GSubprocess*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Check if the given subprocess exited normally $(LPAREN)ie: by way of exit$(LPAREN)$(RPAREN)
   * or return from main$(LPAREN)$(RPAREN)$(RPAREN).
   * This is equivalent to the system WIFEXITED macro.
   * It is an error to call this function before [gio.subprocess.Subprocess.wait] has
   * returned.
   * Returns: %TRUE if the case of a normal exit
   */
  bool getIfExited()
  {
    bool _retval;
    _retval = g_subprocess_get_if_exited(cast(GSubprocess*)cPtr);
    return _retval;
  }

  /**
   * Check if the given subprocess terminated in response to a signal.
   * This is equivalent to the system WIFSIGNALED macro.
   * It is an error to call this function before [gio.subprocess.Subprocess.wait] has
   * returned.
   * Returns: %TRUE if the case of termination due to a signal
   */
  bool getIfSignaled()
  {
    bool _retval;
    _retval = g_subprocess_get_if_signaled(cast(GSubprocess*)cPtr);
    return _retval;
  }

  /**
   * Gets the raw status code of the process, as from waitpid$(LPAREN)$(RPAREN).
   * This value has no particular meaning, but it can be used with the
   * macros defined by the system headers such as WIFEXITED.  It can also
   * be used with [glib.global.spawnCheckWaitStatus].
   * It is more likely that you want to use [gio.subprocess.Subprocess.getIfExited]
   * followed by [gio.subprocess.Subprocess.getExitStatus].
   * It is an error to call this function before [gio.subprocess.Subprocess.wait] has
   * returned.
   * Returns: the $(LPAREN)meaningless$(RPAREN) waitpid$(LPAREN)$(RPAREN) exit status from the kernel
   */
  int getStatus()
  {
    int _retval;
    _retval = g_subprocess_get_status(cast(GSubprocess*)cPtr);
    return _retval;
  }

  /**
   * Gets the #GInputStream from which to read the stderr output of
   * subprocess.
   * The process must have been created with %G_SUBPROCESS_FLAGS_STDERR_PIPE,
   * otherwise %NULL will be returned.
   * Returns: the stderr pipe
   */
  InputStream getStderrPipe()
  {
    GInputStream* _cretval;
    _cretval = g_subprocess_get_stderr_pipe(cast(GSubprocess*)cPtr);
    auto _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the #GOutputStream that you can write to in order to give data
   * to the stdin of subprocess.
   * The process must have been created with %G_SUBPROCESS_FLAGS_STDIN_PIPE and
   * not %G_SUBPROCESS_FLAGS_STDIN_INHERIT, otherwise %NULL will be returned.
   * Returns: the stdout pipe
   */
  OutputStream getStdinPipe()
  {
    GOutputStream* _cretval;
    _cretval = g_subprocess_get_stdin_pipe(cast(GSubprocess*)cPtr);
    auto _retval = ObjectG.getDObject!OutputStream(cast(GOutputStream*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the #GInputStream from which to read the stdout output of
   * subprocess.
   * The process must have been created with %G_SUBPROCESS_FLAGS_STDOUT_PIPE,
   * otherwise %NULL will be returned.
   * Returns: the stdout pipe
   */
  InputStream getStdoutPipe()
  {
    GInputStream* _cretval;
    _cretval = g_subprocess_get_stdout_pipe(cast(GSubprocess*)cPtr);
    auto _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Checks if the process was "successful".  A process is considered
   * successful if it exited cleanly with an exit status of 0, either by
   * way of the exit$(LPAREN)$(RPAREN) system call or return from main$(LPAREN)$(RPAREN).
   * It is an error to call this function before [gio.subprocess.Subprocess.wait] has
   * returned.
   * Returns: %TRUE if the process exited cleanly with a exit status of 0
   */
  bool getSuccessful()
  {
    bool _retval;
    _retval = g_subprocess_get_successful(cast(GSubprocess*)cPtr);
    return _retval;
  }

  /**
   * Get the signal number that caused the subprocess to terminate, given
   * that it terminated due to a signal.
   * This is equivalent to the system WTERMSIG macro.
   * It is an error to call this function before [gio.subprocess.Subprocess.wait] and
   * unless [gio.subprocess.Subprocess.getIfSignaled] returned %TRUE.
   * Returns: the signal causing termination
   */
  int getTermSig()
  {
    int _retval;
    _retval = g_subprocess_get_term_sig(cast(GSubprocess*)cPtr);
    return _retval;
  }

  /**
   * Sends the UNIX signal signal_num to the subprocess, if it is still
   * running.
   * This API is race-free.  If the subprocess has terminated, it will not
   * be signalled.
   * This API is not available on Windows.
   * Params:
   *   signalNum = the signal number to send
   */
  void sendSignal(int signalNum)
  {
    g_subprocess_send_signal(cast(GSubprocess*)cPtr, signalNum);
  }

  /**
   * Synchronously wait for the subprocess to terminate.
   * After the process terminates you can query its exit status with
   * functions such as [gio.subprocess.Subprocess.getIfExited] and
   * [gio.subprocess.Subprocess.getExitStatus].
   * This function does not fail in the case of the subprocess having
   * abnormal termination.  See [gio.subprocess.Subprocess.waitCheck] for that.
   * Cancelling cancellable doesn't kill the subprocess.  Call
   * [gio.subprocess.Subprocess.forceExit] if it is desirable.
   * Params:
   *   cancellable = a #GCancellable
   * Returns: %TRUE on success, %FALSE if cancellable was cancelled
   */
  bool wait(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_subprocess_wait(cast(GSubprocess*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Wait for the subprocess to terminate.
   * This is the asynchronous version of [gio.subprocess.Subprocess.wait].
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback to call when the operation is complete
   */
  void waitAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_subprocess_wait_async(cast(GSubprocess*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Combines [gio.subprocess.Subprocess.wait] with [glib.global.spawnCheckWaitStatus].
   * Params:
   *   cancellable = a #GCancellable
   * Returns: %TRUE on success, %FALSE if process exited abnormally, or
   *   cancellable was cancelled
   */
  bool waitCheck(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_subprocess_wait_check(cast(GSubprocess*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Combines [gio.subprocess.Subprocess.waitAsync] with [glib.global.spawnCheckWaitStatus].
   * This is the asynchronous version of [gio.subprocess.Subprocess.waitCheck].
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback to call when the operation is complete
   */
  void waitCheckAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_subprocess_wait_check_async(cast(GSubprocess*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Collects the result of a previous call to
   * [gio.subprocess.Subprocess.waitCheckAsync].
   * Params:
   *   result = the #GAsyncResult passed to your #GAsyncReadyCallback
   * Returns: %TRUE if successful, or %FALSE with error set
   */
  bool waitCheckFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_subprocess_wait_check_finish(cast(GSubprocess*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Collects the result of a previous call to
   * [gio.subprocess.Subprocess.waitAsync].
   * Params:
   *   result = the #GAsyncResult passed to your #GAsyncReadyCallback
   * Returns: %TRUE if successful, or %FALSE with error set
   */
  bool waitFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_subprocess_wait_finish(cast(GSubprocess*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
