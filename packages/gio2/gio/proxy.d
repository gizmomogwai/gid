module gio.proxy;

public import gio.proxy_iface_proxy;
import gid.global;
import gio.async_result;
import gio.async_result_mixin;
import gio.c.functions;
import gio.c.types;
import gio.cancellable;
import gio.iostream;
import gio.proxy_address;
import gio.types;
import glib.error;
import gobject.object;

/**
 * A `GProxy` handles connecting to a remote host via a given type of
 * proxy server. It is implemented by the `gio-proxy` extension point.
 * The extensions are named after their proxy protocol name. As an
 * example, a SOCKS5 proxy implementation can be retrieved with the
 * name `socks5` using the function
 * [gio.ioextension_point.IOExtensionPoint.getExtensionByName].
 */
interface Proxy
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_proxy_get_type != &gidSymbolNotFound ? g_proxy_get_type() : cast(GType)0;
  }

  /**
   * Find the `gio-proxy` extension point for a proxy implementation that supports
   * the specified protocol.
   * Params:
   *   protocol = the proxy protocol name $(LPAREN)e.g. http, socks, etc$(RPAREN)
   * Returns: return a #GProxy or NULL if protocol
   *   is not supported.
   */
  static Proxy getDefaultForProtocol(string protocol)
  {
    GProxy* _cretval;
    const(char)* _protocol = protocol.toCString(No.Alloc);
    _cretval = g_proxy_get_default_for_protocol(_protocol);
    auto _retval = ObjectG.getDObject!Proxy(cast(GProxy*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Given connection to communicate with a proxy $(LPAREN)eg, a
   * #GSocketConnection that is connected to the proxy server$(RPAREN), this
   * does the necessary handshake to connect to proxy_address, and if
   * required, wraps the #GIOStream to handle proxy payload.
   * Params:
   *   connection = a #GIOStream
   *   proxyAddress = a #GProxyAddress
   *   cancellable = a #GCancellable
   * Returns: a #GIOStream that will replace connection. This might
   *   be the same as connection, in which case a reference
   *   will be added.
   */
  IOStream connect(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable);

  /**
   * Asynchronous version of [gio.proxy.Proxy.connect].
   * Params:
   *   connection = a #GIOStream
   *   proxyAddress = a #GProxyAddress
   *   cancellable = a #GCancellable
   *   callback = a #GAsyncReadyCallback
   */
  void connectAsync(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * See [gio.proxy.Proxy.connect].
   * Params:
   *   result = a #GAsyncResult
   * Returns: a #GIOStream.
   */
  IOStream connectFinish(AsyncResult result);

  /**
   * Some proxy protocols expect to be passed a hostname, which they
   * will resolve to an IP address themselves. Others, like SOCKS4, do
   * not allow this. This function will return %FALSE if proxy is
   * implementing such a protocol. When %FALSE is returned, the caller
   * should resolve the destination hostname first, and then pass a
   * #GProxyAddress containing the stringified IP address to
   * [gio.proxy.Proxy.connect] or [gio.proxy.Proxy.connectAsync].
   * Returns: %TRUE if hostname resolution is supported.
   */
  bool supportsHostname();
}
