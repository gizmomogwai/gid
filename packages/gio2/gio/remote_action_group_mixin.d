module gio.remote_action_group_mixin;

public import gio.remote_action_group_iface_proxy;
public import gid.global;
public import gio.c.functions;
public import gio.c.types;
public import gio.types;
public import glib.variant;

/**
 * The `GRemoteActionGroup` interface is implemented by [gio.action_group.ActionGroup]
 * instances that either transmit action invocations to other processes
 * or receive action invocations in the local process from other
 * processes.
 * The interface has `_full` variants of the two
 * methods on [gio.action_group.ActionGroup] used to activate actions:
 * [gio.action_group.ActionGroup.activateAction] and
 * [gio.action_group.ActionGroup.changeActionState]. These variants allow a
 * ‘platform data’ [glib.variant.VariantG] to be specified: a dictionary providing
 * context for the action invocation $(LPAREN)for example: timestamps, startup
 * notification IDs, etc$(RPAREN).
 * [gio.dbus_action_group.DBusActionGroup] implements `GRemoteActionGroup`.  This provides a
 * mechanism to send platform data for action invocations over D-Bus.
 * Additionally, [gio.dbus_connection.DBusConnection.exportActionGroup] will check if
 * the exported [gio.action_group.ActionGroup] implements `GRemoteActionGroup` and use
 * the `_full` variants of the calls if available.  This
 * provides a mechanism by which to receive platform data for action
 * invocations that arrive by way of D-Bus.
 */
template RemoteActionGroupT()
{

  /**
   * Activates the remote action.
   * This is the same as [gio.action_group.ActionGroup.activateAction] except that it
   * allows for provision of "platform data" to be sent along with the
   * activation request.  This typically contains details such as the user
   * interaction timestamp or startup notification information.
   * platform_data must be non-%NULL and must have the type
   * %G_VARIANT_TYPE_VARDICT.  If it is floating, it will be consumed.
   * Params:
   *   actionName = the name of the action to activate
   *   parameter = the optional parameter to the activation
   *   platformData = the platform data to send
   */
  override void activateActionFull(string actionName, VariantG parameter, VariantG platformData)
  {
    const(char)* _actionName = actionName.toCString(No.Alloc);
    g_remote_action_group_activate_action_full(cast(GRemoteActionGroup*)cPtr, _actionName, parameter ? cast(VariantC*)parameter.cPtr(No.Dup) : null, platformData ? cast(VariantC*)platformData.cPtr(No.Dup) : null);
  }

  /**
   * Changes the state of a remote action.
   * This is the same as [gio.action_group.ActionGroup.changeActionState] except that
   * it allows for provision of "platform data" to be sent along with the
   * state change request.  This typically contains details such as the
   * user interaction timestamp or startup notification information.
   * platform_data must be non-%NULL and must have the type
   * %G_VARIANT_TYPE_VARDICT.  If it is floating, it will be consumed.
   * Params:
   *   actionName = the name of the action to change the state of
   *   value = the new requested value for the state
   *   platformData = the platform data to send
   */
  override void changeActionStateFull(string actionName, VariantG value, VariantG platformData)
  {
    const(char)* _actionName = actionName.toCString(No.Alloc);
    g_remote_action_group_change_action_state_full(cast(GRemoteActionGroup*)cPtr, _actionName, value ? cast(VariantC*)value.cPtr(No.Dup) : null, platformData ? cast(VariantC*)platformData.cPtr(No.Dup) : null);
  }
}
