module Gio.ProxyT;

public import Gio.ProxyIfaceProxy;
public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.AsyncResult;
public import Gio.AsyncResultT;
public import Gio.Cancellable;
public import Gio.IOStream;
public import Gio.ProxyAddress;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * A `GProxy` handles connecting to a remote host via a given type of
 * proxy server. It is implemented by the `gio-proxy` extension point.
 * The extensions are named after their proxy protocol name. As an
 * example, a SOCKS5 proxy implementation can be retrieved with the
 * name `socks5` using the function
 * [Gio.IOExtensionPoint.getExtensionByName].
 */
template ProxyT()
{


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
  override IOStream connect(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable)
  {
    GIOStream* _cretval;
    GError *_err;
    _cretval = g_proxy_connect(cast(GProxy*)cPtr, connection ? cast(GIOStream*)connection.cPtr(No.Dup) : null, proxyAddress ? cast(GProxyAddress*)proxyAddress.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Asynchronous version of [Gio.Proxy.connect].
   * Params:
   *   connection = a #GIOStream
   *   proxyAddress = a #GProxyAddress
   *   cancellable = a #GCancellable
   *   callback = a #GAsyncReadyCallback
   */
  override void connectAsync(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_proxy_connect_async(cast(GProxy*)cPtr, connection ? cast(GIOStream*)connection.cPtr(No.Dup) : null, proxyAddress ? cast(GProxyAddress*)proxyAddress.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * See [Gio.Proxy.connect].
   * Params:
   *   result = a #GAsyncResult
   * Returns: a #GIOStream.
   */
  override IOStream connectFinish(AsyncResult result)
  {
    GIOStream* _cretval;
    GError *_err;
    _cretval = g_proxy_connect_finish(cast(GProxy*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Some proxy protocols expect to be passed a hostname, which they
   * will resolve to an IP address themselves. Others, like SOCKS4, do
   * not allow this. This function will return %FALSE if proxy is
   * implementing such a protocol. When %FALSE is returned, the caller
   * should resolve the destination hostname first, and then pass a
   * #GProxyAddress containing the stringified IP address to
   * [Gio.Proxy.connect] or [Gio.Proxy.connectAsync].
   * Returns: %TRUE if hostname resolution is supported.
   */
  override bool supportsHostname()
  {
    bool _retval;
    _retval = g_proxy_supports_hostname(cast(GProxy*)cPtr);
    return _retval;
  }
}
