module gdk.frame_clock;

import gdk.c.functions;
import gdk.c.types;
import gdk.frame_timings;
import gdk.types;
import gid.global;
import gobject.dclosure;
import gobject.object;

/**
 * A `GdkFrameClock` tells the application when to update and repaint
 * a surface.
 * This may be synced to the vertical refresh rate of the monitor, for example.
 * Even when the frame clock uses a simple timer rather than a hardware-based
 * vertical sync, the frame clock helps because it ensures everything paints at
 * the same time $(LPAREN)reducing the total number of frames$(RPAREN).
 * The frame clock can also automatically stop painting when it knows the frames
 * will not be visible, or scale back animation framerates.
 * `GdkFrameClock` is designed to be compatible with an OpenGL-based implementation
 * or with mozRequestAnimationFrame in Firefox, for example.
 * A frame clock is idle until someone requests a frame with
 * [gdk.frame_clock.FrameClock.requestPhase]. At some later point that makes sense
 * for the synchronization being implemented, the clock will process a frame and
 * emit signals for each phase that has been requested. $(LPAREN)See the signals of the
 * `GdkFrameClock` class for documentation of the phases.
 * %GDK_FRAME_CLOCK_PHASE_UPDATE and the [gdk.frame_clock.FrameClock.update] signal
 * are most interesting for application writers, and are used to update the
 * animations, using the frame time given by [gdk.frame_clock.FrameClock.getFrameTime].
 * The frame time is reported in microseconds and generally in the same
 * timescale as [glib.global.getMonotonicTime], however, it is not the same
 * as [glib.global.getMonotonicTime]. The frame time does not advance during
 * the time a frame is being painted, and outside of a frame, an attempt
 * is made so that all calls to [gdk.frame_clock.FrameClock.getFrameTime] that
 * are called at a “similar” time get the same value. This means that
 * if different animations are timed by looking at the difference in
 * time between an initial value from [gdk.frame_clock.FrameClock.getFrameTime]
 * and the value inside the [gdk.frame_clock.FrameClock.update] signal of the clock,
 * they will stay exactly synchronized.
 */
class FrameClock : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gdk_frame_clock_get_type != &gidSymbolNotFound ? gdk_frame_clock_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Starts updates for an animation.
   * Until a matching call to [gdk.frame_clock.FrameClock.endUpdating] is made,
   * the frame clock will continually request a new frame with the
   * %GDK_FRAME_CLOCK_PHASE_UPDATE phase. This function may be called multiple
   * times and frames will be requested until [gdk.frame_clock.FrameClock.endUpdating]
   * is called the same number of times.
   */
  void beginUpdating()
  {
    gdk_frame_clock_begin_updating(cast(GdkFrameClock*)cPtr);
  }

  /**
   * Stops updates for an animation.
   * See the documentation for [gdk.frame_clock.FrameClock.beginUpdating].
   */
  void endUpdating()
  {
    gdk_frame_clock_end_updating(cast(GdkFrameClock*)cPtr);
  }

  /**
   * Gets the frame timings for the current frame.
   * Returns: the `GdkFrameTimings` for the
   *   frame currently being processed, or even no frame is being
   *   processed, for the previous frame. Before any frames have been
   *   processed, returns %NULL.
   */
  FrameTimings getCurrentTimings()
  {
    GdkFrameTimings* _cretval;
    _cretval = gdk_frame_clock_get_current_timings(cast(GdkFrameClock*)cPtr);
    auto _retval = _cretval ? new FrameTimings(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Calculates the current frames-per-second, based on the
   * frame timings of frame_clock.
   * Returns: the current fps, as a `double`
   */
  double getFps()
  {
    double _retval;
    _retval = gdk_frame_clock_get_fps(cast(GdkFrameClock*)cPtr);
    return _retval;
  }

  /**
   * `GdkFrameClock` maintains a 64-bit counter that increments for
   * each frame drawn.
   * Returns: inside frame processing, the value of the frame counter
   *   for the current frame. Outside of frame processing, the frame
   *   counter for the last frame.
   */
  long getFrameCounter()
  {
    long _retval;
    _retval = gdk_frame_clock_get_frame_counter(cast(GdkFrameClock*)cPtr);
    return _retval;
  }

  /**
   * Gets the time that should currently be used for animations.
   * Inside the processing of a frame, it’s the time used to compute the
   * animation position of everything in a frame. Outside of a frame, it's
   * the time of the conceptual “previous frame,” which may be either
   * the actual previous frame time, or if that’s too old, an updated
   * time.
   * Returns: a timestamp in microseconds, in the timescale of
   *   of [glib.global.getMonotonicTime].
   */
  long getFrameTime()
  {
    long _retval;
    _retval = gdk_frame_clock_get_frame_time(cast(GdkFrameClock*)cPtr);
    return _retval;
  }

  /**
   * Returns the frame counter for the oldest frame available in history.
   * `GdkFrameClock` internally keeps a history of `GdkFrameTimings`
   * objects for recent frames that can be retrieved with
   * [gdk.frame_clock.FrameClock.getTimings]. The set of stored frames
   * is the set from the counter values given by
   * [gdk.frame_clock.FrameClock.getHistoryStart] and
   * [gdk.frame_clock.FrameClock.getFrameCounter], inclusive.
   * Returns: the frame counter value for the oldest frame
   *   that is available in the internal frame history of the
   *   `GdkFrameClock`
   */
  long getHistoryStart()
  {
    long _retval;
    _retval = gdk_frame_clock_get_history_start(cast(GdkFrameClock*)cPtr);
    return _retval;
  }

  /**
   * Predicts a presentation time, based on history.
   * Using the frame history stored in the frame clock, finds the last
   * known presentation time and refresh interval, and assuming that
   * presentation times are separated by the refresh interval,
   * predicts a presentation time that is a multiple of the refresh
   * interval after the last presentation time, and later than base_time.
   * Params:
   *   baseTime = base time for determining a presentaton time
   *   refreshIntervalReturn = a location to store the
   *     determined refresh interval, or %NULL. A default refresh interval of
   *     1/60th of a second will be stored if no history is present.
   *   presentationTimeReturn = a location to store the next
   *     candidate presentation time after the given base time.
   *     0 will be will be stored if no history is present.
   */
  void getRefreshInfo(long baseTime, out long refreshIntervalReturn, out long presentationTimeReturn)
  {
    gdk_frame_clock_get_refresh_info(cast(GdkFrameClock*)cPtr, baseTime, cast(long*)&refreshIntervalReturn, cast(long*)&presentationTimeReturn);
  }

  /**
   * Retrieves a `GdkFrameTimings` object holding timing information
   * for the current frame or a recent frame.
   * The `GdkFrameTimings` object may not yet be complete: see
   * [gdk.frame_timings.FrameTimings.getComplete] and
   * [gdk.frame_clock.FrameClock.getHistoryStart].
   * Params:
   *   frameCounter = the frame counter value identifying the frame to
   *     be received
   * Returns: the `GdkFrameTimings` object
   *   for the specified frame, or %NULL if it is not available
   */
  FrameTimings getTimings(long frameCounter)
  {
    GdkFrameTimings* _cretval;
    _cretval = gdk_frame_clock_get_timings(cast(GdkFrameClock*)cPtr, frameCounter);
    auto _retval = _cretval ? new FrameTimings(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Asks the frame clock to run a particular phase.
   * The signal corresponding the requested phase will be emitted the next
   * time the frame clock processes. Multiple calls to
   * [gdk.frame_clock.FrameClock.requestPhase] will be combined together
   * and only one frame processed. If you are displaying animated
   * content and want to continually request the
   * %GDK_FRAME_CLOCK_PHASE_UPDATE phase for a period of time,
   * you should use [gdk.frame_clock.FrameClock.beginUpdating] instead,
   * since this allows GTK to adjust system parameters to get maximally
   * smooth animations.
   * Params:
   *   phase = the phase that is requested
   */
  void requestPhase(FrameClockPhase phase)
  {
    gdk_frame_clock_request_phase(cast(GdkFrameClock*)cPtr, phase);
  }

  /**
   * This signal ends processing of the frame.
   * Applications should generally not handle this signal.
   *   frameClock = the instance the signal is connected to
   */
  alias AfterPaintCallbackDlg = void delegate(FrameClock frameClock);
  alias AfterPaintCallbackFunc = void function(FrameClock frameClock);

  /**
   * Connect to AfterPaint signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectAfterPaint(T)(T callback, Flag!"After" after = No.After)
  if (is(T : AfterPaintCallbackDlg) || is(T : AfterPaintCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto frameClock = getVal!FrameClock(_paramVals);
      _dClosure.dlg(frameClock);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("after-paint", closure, after);
  }

  /**
   * Begins processing of the frame.
   * Applications should generally not handle this signal.
   *   frameClock = the instance the signal is connected to
   */
  alias BeforePaintCallbackDlg = void delegate(FrameClock frameClock);
  alias BeforePaintCallbackFunc = void function(FrameClock frameClock);

  /**
   * Connect to BeforePaint signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectBeforePaint(T)(T callback, Flag!"After" after = No.After)
  if (is(T : BeforePaintCallbackDlg) || is(T : BeforePaintCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto frameClock = getVal!FrameClock(_paramVals);
      _dClosure.dlg(frameClock);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("before-paint", closure, after);
  }

  /**
   * Used to flush pending motion events that are being batched up and
   * compressed together.
   * Applications should not handle this signal.
   *   frameClock = the instance the signal is connected to
   */
  alias FlushEventsCallbackDlg = void delegate(FrameClock frameClock);
  alias FlushEventsCallbackFunc = void function(FrameClock frameClock);

  /**
   * Connect to FlushEvents signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectFlushEvents(T)(T callback, Flag!"After" after = No.After)
  if (is(T : FlushEventsCallbackDlg) || is(T : FlushEventsCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto frameClock = getVal!FrameClock(_paramVals);
      _dClosure.dlg(frameClock);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("flush-events", closure, after);
  }

  /**
   * Emitted as the second step of toolkit and application processing
   * of the frame.
   * Any work to update sizes and positions of application elements
   * should be performed. GTK normally handles this internally.
   *   frameClock = the instance the signal is connected to
   */
  alias LayoutCallbackDlg = void delegate(FrameClock frameClock);
  alias LayoutCallbackFunc = void function(FrameClock frameClock);

  /**
   * Connect to Layout signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectLayout(T)(T callback, Flag!"After" after = No.After)
  if (is(T : LayoutCallbackDlg) || is(T : LayoutCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto frameClock = getVal!FrameClock(_paramVals);
      _dClosure.dlg(frameClock);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("layout", closure, after);
  }

  /**
   * Emitted as the third step of toolkit and application processing
   * of the frame.
   * The frame is repainted. GDK normally handles this internally and
   * emits [gdk.surface.Surface.render] signals which are turned into
   * [GtkWidget::snapshot](../gtk4/signal.Widget.snapshot.html) signals
   * by GTK.
   *   frameClock = the instance the signal is connected to
   */
  alias PaintCallbackDlg = void delegate(FrameClock frameClock);
  alias PaintCallbackFunc = void function(FrameClock frameClock);

  /**
   * Connect to Paint signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPaint(T)(T callback, Flag!"After" after = No.After)
  if (is(T : PaintCallbackDlg) || is(T : PaintCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto frameClock = getVal!FrameClock(_paramVals);
      _dClosure.dlg(frameClock);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("paint", closure, after);
  }

  /**
   * Emitted after processing of the frame is finished.
   * This signal is handled internally by GTK to resume normal
   * event processing. Applications should not handle this signal.
   *   frameClock = the instance the signal is connected to
   */
  alias ResumeEventsCallbackDlg = void delegate(FrameClock frameClock);
  alias ResumeEventsCallbackFunc = void function(FrameClock frameClock);

  /**
   * Connect to ResumeEvents signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectResumeEvents(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ResumeEventsCallbackDlg) || is(T : ResumeEventsCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto frameClock = getVal!FrameClock(_paramVals);
      _dClosure.dlg(frameClock);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("resume-events", closure, after);
  }

  /**
   * Emitted as the first step of toolkit and application processing
   * of the frame.
   * Animations should be updated using [gdk.frame_clock.FrameClock.getFrameTime].
   * Applications can connect directly to this signal, or use
   * [[gtk.widget.Widget.addTickCallback]](../gtk4/method.Widget.add_tick_callback.html)
   * as a more convenient interface.
   *   frameClock = the instance the signal is connected to
   */
  alias UpdateCallbackDlg = void delegate(FrameClock frameClock);
  alias UpdateCallbackFunc = void function(FrameClock frameClock);

  /**
   * Connect to Update signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUpdate(T)(T callback, Flag!"After" after = No.After)
  if (is(T : UpdateCallbackDlg) || is(T : UpdateCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto frameClock = getVal!FrameClock(_paramVals);
      _dClosure.dlg(frameClock);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("update", closure, after);
  }
}
