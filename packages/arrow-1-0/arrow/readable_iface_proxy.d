module arrow.readable_iface_proxy;

import gobject.object;
import arrow.readable;
import arrow.readable_mixin;

/// Proxy object for Arrow.Readable interface when a GObject has no applicable D binding
class ReadableIfaceProxy : IfaceProxy, Readable
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Readable);
  }

  mixin ReadableT!();
}
