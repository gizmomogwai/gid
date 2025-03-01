module gio.proxy_address;

import gid.global;
import gio.c.functions;
import gio.c.types;
import gio.inet_address;
import gio.inet_socket_address;
import gio.socket_connectable;
import gio.socket_connectable_mixin;
import gio.types;

/**
 * A [gio.inet_socket_address.InetSocketAddress] representing a connection via a proxy server.
 */
class ProxyAddress : InetSocketAddress
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_proxy_address_get_type != &gidSymbolNotFound ? g_proxy_address_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GProxyAddress for inetaddr with protocol that should
   * tunnel through dest_hostname and dest_port.
   * $(LPAREN)Note that this method doesn't set the #GProxyAddress:uri or
   * #GProxyAddress:destination-protocol fields; use [gobject.object.ObjectG.new_]
   * directly if you want to set those.$(RPAREN)
   * Params:
   *   inetaddr = The proxy server #GInetAddress.
   *   port = The proxy server port.
   *   protocol = The proxy protocol to support, in lower case $(LPAREN)e.g. socks, http$(RPAREN).
   *   destHostname = The destination hostname the proxy should tunnel to.
   *   destPort = The destination port to tunnel to.
   *   username = The username to authenticate to the proxy server
   *     $(LPAREN)or %NULL$(RPAREN).
   *   password = The password to authenticate to the proxy server
   *     $(LPAREN)or %NULL$(RPAREN).
   * Returns: a new #GProxyAddress
   */
  this(InetAddress inetaddr, ushort port, string protocol, string destHostname, ushort destPort, string username, string password)
  {
    GSocketAddress* _cretval;
    const(char)* _protocol = protocol.toCString(No.Alloc);
    const(char)* _destHostname = destHostname.toCString(No.Alloc);
    const(char)* _username = username.toCString(No.Alloc);
    const(char)* _password = password.toCString(No.Alloc);
    _cretval = g_proxy_address_new(inetaddr ? cast(GInetAddress*)inetaddr.cPtr(No.Dup) : null, port, _protocol, _destHostname, destPort, _username, _password);
    this(_cretval, Yes.Take);
  }

  /**
   * Gets proxy's destination hostname; that is, the name of the host
   * that will be connected to via the proxy, not the name of the proxy
   * itself.
   * Returns: the proxy's destination hostname
   */
  string getDestinationHostname()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_destination_hostname(cast(GProxyAddress*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets proxy's destination port; that is, the port on the
   * destination host that will be connected to via the proxy, not the
   * port number of the proxy itself.
   * Returns: the proxy's destination port
   */
  ushort getDestinationPort()
  {
    ushort _retval;
    _retval = g_proxy_address_get_destination_port(cast(GProxyAddress*)cPtr);
    return _retval;
  }

  /**
   * Gets the protocol that is being spoken to the destination
   * server; eg, "http" or "ftp".
   * Returns: the proxy's destination protocol
   */
  string getDestinationProtocol()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_destination_protocol(cast(GProxyAddress*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets proxy's password.
   * Returns: the proxy's password
   */
  string getPassword()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_password(cast(GProxyAddress*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets proxy's protocol. eg, "socks" or "http"
   * Returns: the proxy's protocol
   */
  string getProtocol()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_protocol(cast(GProxyAddress*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets the proxy URI that proxy was constructed from.
   * Returns: the proxy's URI, or %NULL if unknown
   */
  string getUri()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_uri(cast(GProxyAddress*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets proxy's username.
   * Returns: the proxy's username
   */
  string getUsername()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_username(cast(GProxyAddress*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }
}
