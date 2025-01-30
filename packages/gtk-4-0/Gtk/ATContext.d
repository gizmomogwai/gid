module Gtk.ATContext;

import GObject.DClosure;
import GObject.ObjectG;
import Gdk.Display;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkATContext` is an abstract class provided by GTK to communicate to
 * platform-specific assistive technologies API.
 * Each platform supported by GTK implements a `GtkATContext` subclass, and
 * is responsible for updating the accessible state in response to state
 * changes in `GtkAccessible`.
 */
class ATContext : ObjectG
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
    return gtk_at_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkATContext` instance for the given accessible role,
   * accessible instance, and display connection.
   * The `GtkATContext` implementation being instantiated will depend on the
   * platform.
   * Params:
   *   accessibleRole = the accessible role used by the `GtkATContext`
   *   accessible = the `GtkAccessible` implementation using the `GtkATContext`
   *   display = the `GdkDisplay` used by the `GtkATContext`
   * Returns: the `GtkATContext`
   */
  static ATContext create(AccessibleRole accessibleRole, Accessible accessible, Display display)
  {
    GtkATContext* _cretval;
    _cretval = gtk_at_context_create(accessibleRole, accessible ? cast(GtkAccessible*)(cast(ObjectG)accessible).cPtr(No.Dup) : null, display ? cast(GdkDisplay*)display.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!ATContext(cast(GtkATContext*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Retrieves the `GtkAccessible` using this context.
   * Returns: a `GtkAccessible`
   */
  Accessible getAccessible()
  {
    GtkAccessible* _cretval;
    _cretval = gtk_at_context_get_accessible(cast(GtkATContext*)cPtr);
    auto _retval = ObjectG.getDObject!Accessible(cast(GtkAccessible*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Retrieves the accessible role of this context.
   * Returns: a `GtkAccessibleRole`
   */
  AccessibleRole getAccessibleRole()
  {
    GtkAccessibleRole _cretval;
    _cretval = gtk_at_context_get_accessible_role(cast(GtkATContext*)cPtr);
    AccessibleRole _retval = cast(AccessibleRole)_cretval;
    return _retval;
  }

  /**
   * Emitted when the attributes of the accessible for the
   * `GtkATContext` instance change.
   *   aTContext = the instance the signal is connected to
   */
  alias StateChangeCallback = void delegate(ATContext aTContext);

  /**
   * Connect to StateChange signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectStateChange(StateChangeCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto aTContext = getVal!ATContext(_paramVals);
      _dgClosure.dlg(aTContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("state-change", closure, after);
  }
}
