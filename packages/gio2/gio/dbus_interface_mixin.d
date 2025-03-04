module gio.dbus_interface_mixin;

public import gio.dbus_interface_iface_proxy;
public import gid.global;
public import gio.c.functions;
public import gio.c.types;
public import gio.dbus_interface_info;
public import gio.dbus_object;
public import gio.dbus_object_mixin;
public import gio.types;
public import gobject.object;

/**
 * Base type for D-Bus interfaces.
 * The `GDBusInterface` type is the base type for D-Bus interfaces both
 * on the service side $(LPAREN)see [gio.dbus_interface_skeleton.DBusInterfaceSkeleton]$(RPAREN) and client side
 * $(LPAREN)see [gio.dbus_proxy.DBusProxy]$(RPAREN).
 */
template DBusInterfaceT()
{

  /**
   * Gets the #GDBusObject that interface_ belongs to, if any.
   * Returns: A #GDBusObject or %NULL. The returned
   *   reference should be freed with [gobject.object.ObjectG.unref].
   */
  override DBusObject getObject()
  {
    GDBusObject* _cretval;
    _cretval = g_dbus_interface_dup_object(cast(GDBusInterface*)cPtr);
    auto _retval = ObjectG.getDObject!DBusObject(cast(GDBusObject*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets D-Bus introspection information for the D-Bus interface
   * implemented by interface_.
   * Returns: A #GDBusInterfaceInfo. Do not free.
   */
  override DBusInterfaceInfo getInfo()
  {
    GDBusInterfaceInfo* _cretval;
    _cretval = g_dbus_interface_get_info(cast(GDBusInterface*)cPtr);
    auto _retval = _cretval ? new DBusInterfaceInfo(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Sets the #GDBusObject for interface_ to object.
   * Note that interface_ will hold a weak reference to object.
   * Params:
   *   object = A #GDBusObject or %NULL.
   */
  override void setObject(DBusObject object)
  {
    g_dbus_interface_set_object(cast(GDBusInterface*)cPtr, object ? cast(GDBusObject*)(cast(ObjectG)object).cPtr(No.Dup) : null);
  }
}
