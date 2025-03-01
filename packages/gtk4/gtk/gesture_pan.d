module gtk.gesture_pan;

import gid.global;
import gobject.dclosure;
import gtk.c.functions;
import gtk.c.types;
import gtk.gesture_drag;
import gtk.types;

/**
 * `GtkGesturePan` is a `GtkGesture` for pan gestures.
 * These are drags that are locked to happen along one axis. The axis
 * that a `GtkGesturePan` handles is defined at construct time, and
 * can be changed through [gtk.gesture_pan.GesturePan.setOrientation].
 * When the gesture starts to be recognized, `GtkGesturePan` will
 * attempt to determine as early as possible whether the sequence
 * is moving in the expected direction, and denying the sequence if
 * this does not happen.
 * Once a panning gesture along the expected axis is recognized,
 * the [gtk.gesture_pan.GesturePan.pan] signal will be emitted as input
 * events are received, containing the offset in the given axis.
 */
class GesturePan : GestureDrag
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_gesture_pan_get_type != &gidSymbolNotFound ? gtk_gesture_pan_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns a newly created `GtkGesture` that recognizes pan gestures.
   * Params:
   *   orientation = expected orientation
   * Returns: a newly created `GtkGesturePan`
   */
  this(Orientation orientation)
  {
    GtkGesture* _cretval;
    _cretval = gtk_gesture_pan_new(orientation);
    this(_cretval, Yes.Take);
  }

  /**
   * Returns the orientation of the pan gestures that this gesture expects.
   * Returns: the expected orientation for pan gestures
   */
  Orientation getOrientation()
  {
    GtkOrientation _cretval;
    _cretval = gtk_gesture_pan_get_orientation(cast(GtkGesturePan*)cPtr);
    Orientation _retval = cast(Orientation)_cretval;
    return _retval;
  }

  /**
   * Sets the orientation to be expected on pan gestures.
   * Params:
   *   orientation = expected orientation
   */
  void setOrientation(Orientation orientation)
  {
    gtk_gesture_pan_set_orientation(cast(GtkGesturePan*)cPtr, orientation);
  }

  /**
   * Emitted once a panning gesture along the expected axis is detected.
   * Params
   *   direction = current direction of the pan gesture
   *   offset = Offset along the gesture orientation
   *   gesturePan = the instance the signal is connected to
   */
  alias PanCallbackDlg = void delegate(PanDirection direction, double offset, GesturePan gesturePan);
  alias PanCallbackFunc = void function(PanDirection direction, double offset, GesturePan gesturePan);

  /**
   * Connect to Pan signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPan(T)(T callback, Flag!"After" after = No.After)
  if (is(T : PanCallbackDlg) || is(T : PanCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto gesturePan = getVal!GesturePan(_paramVals);
      auto direction = getVal!PanDirection(&_paramVals[1]);
      auto offset = getVal!double(&_paramVals[2]);
      _dClosure.dlg(direction, offset, gesturePan);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("pan", closure, after);
  }
}
