module arrow.writable_iface_proxy;

import gobject.object;
import arrow.writable;
import arrow.writable_mixin;

/// Proxy object for Arrow.Writable interface when a GObject has no applicable D binding
class WritableIfaceProxy : IfaceProxy, Writable
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Writable);
  }

  mixin WritableT!();
}
