module gio.dtls_server_connection_iface_proxy;

import gobject.object;
import gio.dtls_server_connection;
import gio.dtls_server_connection_mixin;

/// Proxy object for Gio.DtlsServerConnection interface when a GObject has no applicable D binding
class DtlsServerConnectionIfaceProxy : IfaceProxy, DtlsServerConnection
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(DtlsServerConnection);
  }

  mixin DtlsServerConnectionT!();
}
