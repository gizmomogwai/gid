module gio.network_monitor_mixin;

public import gio.network_monitor_iface_proxy;
public import gid.global;
public import gio.async_result;
public import gio.async_result_mixin;
public import gio.c.functions;
public import gio.c.types;
public import gio.cancellable;
public import gio.socket_connectable;
public import gio.socket_connectable_mixin;
public import gio.types;
public import glib.error;
public import gobject.dclosure;
public import gobject.object;

/**
 * `GNetworkMonitor` provides an easy-to-use cross-platform API
 * for monitoring network connectivity. On Linux, the available
 * implementations are based on the kernel's netlink interface and
 * on NetworkManager.
 * There is also an implementation for use inside Flatpak sandboxes.
 */
template NetworkMonitorT()
{


  /**
   * Attempts to determine whether or not the host pointed to by
   * connectable can be reached, without actually trying to connect to
   * it.
   * This may return %TRUE even when #GNetworkMonitor:network-available
   * is %FALSE, if, for example, monitor can determine that
   * connectable refers to a host on a local network.
   * If monitor believes that an attempt to connect to connectable
   * will succeed, it will return %TRUE. Otherwise, it will return
   * %FALSE and set error to an appropriate error $(LPAREN)such as
   * %G_IO_ERROR_HOST_UNREACHABLE$(RPAREN).
   * Note that although this does not attempt to connect to
   * connectable, it may still block for a brief period of time $(LPAREN)eg,
   * trying to do multicast DNS on the local network$(RPAREN), so if you do not
   * want to block, you should use [gio.network_monitor.NetworkMonitor.canReachAsync].
   * Params:
   *   connectable = a #GSocketConnectable
   *   cancellable = a #GCancellable, or %NULL
   * Returns: %TRUE if connectable is reachable, %FALSE if not.
   */
  override bool canReach(SocketConnectable connectable, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_network_monitor_can_reach(cast(GNetworkMonitor*)cPtr, connectable ? cast(GSocketConnectable*)(cast(ObjectG)connectable).cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously attempts to determine whether or not the host
   * pointed to by connectable can be reached, without actually
   * trying to connect to it.
   * For more details, see [gio.network_monitor.NetworkMonitor.canReach].
   * When the operation is finished, callback will be called.
   * You can then call [gio.network_monitor.NetworkMonitor.canReachFinish]
   * to get the result of the operation.
   * Params:
   *   connectable = a #GSocketConnectable
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  override void canReachAsync(SocketConnectable connectable, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_network_monitor_can_reach_async(cast(GNetworkMonitor*)cPtr, connectable ? cast(GSocketConnectable*)(cast(ObjectG)connectable).cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Finishes an async network connectivity test.
   * See [gio.network_monitor.NetworkMonitor.canReachAsync].
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE if network is reachable, %FALSE if not.
   */
  override bool canReachFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_network_monitor_can_reach_finish(cast(GNetworkMonitor*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets a more detailed networking state than
   * [gio.network_monitor.NetworkMonitor.getNetworkAvailable].
   * If #GNetworkMonitor:network-available is %FALSE, then the
   * connectivity state will be %G_NETWORK_CONNECTIVITY_LOCAL.
   * If #GNetworkMonitor:network-available is %TRUE, then the
   * connectivity state will be %G_NETWORK_CONNECTIVITY_FULL $(LPAREN)if there
   * is full Internet connectivity$(RPAREN), %G_NETWORK_CONNECTIVITY_LIMITED $(LPAREN)if
   * the host has a default route, but appears to be unable to actually
   * reach the full Internet$(RPAREN), or %G_NETWORK_CONNECTIVITY_PORTAL $(LPAREN)if the
   * host is trapped behind a "captive portal" that requires some sort
   * of login or acknowledgement before allowing full Internet access$(RPAREN).
   * Note that in the case of %G_NETWORK_CONNECTIVITY_LIMITED and
   * %G_NETWORK_CONNECTIVITY_PORTAL, it is possible that some sites are
   * reachable but others are not. In this case, applications can
   * attempt to connect to remote servers, but should gracefully fall
   * back to their "offline" behavior if the connection attempt fails.
   * Returns: the network connectivity state
   */
  override NetworkConnectivity getConnectivity()
  {
    GNetworkConnectivity _cretval;
    _cretval = g_network_monitor_get_connectivity(cast(GNetworkMonitor*)cPtr);
    NetworkConnectivity _retval = cast(NetworkConnectivity)_cretval;
    return _retval;
  }

  /**
   * Checks if the network is available. "Available" here means that the
   * system has a default route available for at least one of IPv4 or
   * IPv6. It does not necessarily imply that the public Internet is
   * reachable. See #GNetworkMonitor:network-available for more details.
   * Returns: whether the network is available
   */
  override bool getNetworkAvailable()
  {
    bool _retval;
    _retval = g_network_monitor_get_network_available(cast(GNetworkMonitor*)cPtr);
    return _retval;
  }

  /**
   * Checks if the network is metered.
   * See #GNetworkMonitor:network-metered for more details.
   * Returns: whether the connection is metered
   */
  override bool getNetworkMetered()
  {
    bool _retval;
    _retval = g_network_monitor_get_network_metered(cast(GNetworkMonitor*)cPtr);
    return _retval;
  }

  /**
   * Emitted when the network configuration changes.
   * Params
   *   networkAvailable = the current value of #GNetworkMonitor:network-available
   *   networkMonitor = the instance the signal is connected to
   */
  alias NetworkChangedCallbackDlg = void delegate(bool networkAvailable, NetworkMonitor networkMonitor);
  alias NetworkChangedCallbackFunc = void function(bool networkAvailable, NetworkMonitor networkMonitor);

  /**
   * Connect to NetworkChanged signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectNetworkChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : NetworkChangedCallbackDlg) || is(T : NetworkChangedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto networkMonitor = getVal!NetworkMonitor(_paramVals);
      auto networkAvailable = getVal!bool(&_paramVals[1]);
      _dClosure.dlg(networkAvailable, networkMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("network-changed", closure, after);
  }
}
