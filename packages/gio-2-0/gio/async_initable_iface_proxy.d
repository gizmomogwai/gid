module gio.async_initable_iface_proxy;

import gobject.object;
import gio.async_initable;
import gio.async_initable_mixin;

/// Proxy object for Gio.AsyncInitable interface when a GObject has no applicable D binding
class AsyncInitableIfaceProxy : IfaceProxy, AsyncInitable
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(AsyncInitable);
  }

  mixin AsyncInitableT!();
}
