module gio.tls_file_database_iface_proxy;

import gobject.object;
import gio.tls_file_database;
import gio.tls_file_database_mixin;

/// Proxy object for Gio.TlsFileDatabase interface when a GObject has no applicable D binding
class TlsFileDatabaseIfaceProxy : IfaceProxy, TlsFileDatabase
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(TlsFileDatabase);
  }

  mixin TlsFileDatabaseT!();
}
