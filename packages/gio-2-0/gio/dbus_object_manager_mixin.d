module gio.dbus_object_manager_mixin;

public import gio.dbus_object_manager_iface_proxy;
public import gid.gid;
public import gio.c.functions;
public import gio.c.types;
public import gio.dbus_interface;
public import gio.dbus_interface_mixin;
public import gio.dbus_object;
public import gio.dbus_object_mixin;
public import gio.types;
public import gobject.dclosure;
public import gobject.object;

/**
 * The `GDBusObjectManager` type is the base type for service- and
 * client-side implementations of the standardized
 * [`org.freedesktop.DBus.ObjectManager`](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface.
 * See [Gio.DBusObjectManagerClient] for the client-side implementation
 * and [Gio.DBusObjectManagerServer] for the service-side implementation.
 */
template DBusObjectManagerT()
{

  /**
   * Gets the interface proxy for interface_name at object_path, if
   * any.
   * Params:
   *   objectPath = Object path to look up.
   *   interfaceName = D-Bus interface name to look up.
   * Returns: A #GDBusInterface instance or %NULL. Free
   *   with [GObject.ObjectG.unref].
   */
  override DBusInterface getInterface(string objectPath, string interfaceName)
  {
    GDBusInterface* _cretval;
    const(char)* _objectPath = objectPath.toCString(No.Alloc);
    const(char)* _interfaceName = interfaceName.toCString(No.Alloc);
    _cretval = g_dbus_object_manager_get_interface(cast(GDBusObjectManager*)cPtr, _objectPath, _interfaceName);
    auto _retval = ObjectG.getDObject!DBusInterface(cast(GDBusInterface*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the #GDBusObject at object_path, if any.
   * Params:
   *   objectPath = Object path to look up.
   * Returns: A #GDBusObject or %NULL. Free with
   *   [GObject.ObjectG.unref].
   */
  override DBusObject getObject(string objectPath)
  {
    GDBusObject* _cretval;
    const(char)* _objectPath = objectPath.toCString(No.Alloc);
    _cretval = g_dbus_object_manager_get_object(cast(GDBusObjectManager*)cPtr, _objectPath);
    auto _retval = ObjectG.getDObject!DBusObject(cast(GDBusObject*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the object path that manager is for.
   * Returns: A string owned by manager. Do not free.
   */
  override string getObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_object_manager_get_object_path(cast(GDBusObjectManager*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets all #GDBusObject objects known to manager.
   * Returns: A list of
   *   #GDBusObject objects. The returned list should be freed with
   *   [GLib.List.free] after each element has been freed with
   *   [GObject.ObjectG.unref].
   */
  override DBusObject[] getObjects()
  {
    GList* _cretval;
    _cretval = g_dbus_object_manager_get_objects(cast(GDBusObjectManager*)cPtr);
    auto _retval = gListToD!(DBusObject, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Emitted when interface is added to object.
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all objects managed by manager.
   * Params
   *   object = The #GDBusObject on which an interface was added.
   *   interface_ = The #GDBusInterface that was added.
   *   dBusObjectManager = the instance the signal is connected to
   */
  alias InterfaceAddedCallbackDlg = void delegate(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager);
  alias InterfaceAddedCallbackFunc = void function(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager);

  /**
   * Connect to InterfaceAdded signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectInterfaceAdded(T)(T callback, Flag!"After" after = No.After)
  if (is(T : InterfaceAddedCallbackDlg) || is(T : InterfaceAddedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto dBusObjectManager = getVal!DBusObjectManager(_paramVals);
      auto object = getVal!DBusObject(&_paramVals[1]);
      auto interface_ = getVal!DBusInterface(&_paramVals[2]);
      _dClosure.dlg(object, interface_, dBusObjectManager);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("interface-added", closure, after);
  }

  /**
   * Emitted when interface has been removed from object.
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all objects managed by manager.
   * Params
   *   object = The #GDBusObject on which an interface was removed.
   *   interface_ = The #GDBusInterface that was removed.
   *   dBusObjectManager = the instance the signal is connected to
   */
  alias InterfaceRemovedCallbackDlg = void delegate(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager);
  alias InterfaceRemovedCallbackFunc = void function(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager);

  /**
   * Connect to InterfaceRemoved signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectInterfaceRemoved(T)(T callback, Flag!"After" after = No.After)
  if (is(T : InterfaceRemovedCallbackDlg) || is(T : InterfaceRemovedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto dBusObjectManager = getVal!DBusObjectManager(_paramVals);
      auto object = getVal!DBusObject(&_paramVals[1]);
      auto interface_ = getVal!DBusInterface(&_paramVals[2]);
      _dClosure.dlg(object, interface_, dBusObjectManager);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("interface-removed", closure, after);
  }

  /**
   * Emitted when object is added to manager.
   * Params
   *   object = The #GDBusObject that was added.
   *   dBusObjectManager = the instance the signal is connected to
   */
  alias ObjectAddedCallbackDlg = void delegate(DBusObject object, DBusObjectManager dBusObjectManager);
  alias ObjectAddedCallbackFunc = void function(DBusObject object, DBusObjectManager dBusObjectManager);

  /**
   * Connect to ObjectAdded signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectObjectAdded(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ObjectAddedCallbackDlg) || is(T : ObjectAddedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto dBusObjectManager = getVal!DBusObjectManager(_paramVals);
      auto object = getVal!DBusObject(&_paramVals[1]);
      _dClosure.dlg(object, dBusObjectManager);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("object-added", closure, after);
  }

  /**
   * Emitted when object is removed from manager.
   * Params
   *   object = The #GDBusObject that was removed.
   *   dBusObjectManager = the instance the signal is connected to
   */
  alias ObjectRemovedCallbackDlg = void delegate(DBusObject object, DBusObjectManager dBusObjectManager);
  alias ObjectRemovedCallbackFunc = void function(DBusObject object, DBusObjectManager dBusObjectManager);

  /**
   * Connect to ObjectRemoved signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectObjectRemoved(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ObjectRemovedCallbackDlg) || is(T : ObjectRemovedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto dBusObjectManager = getVal!DBusObjectManager(_paramVals);
      auto object = getVal!DBusObject(&_paramVals[1]);
      _dClosure.dlg(object, dBusObjectManager);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("object-removed", closure, after);
  }
}
