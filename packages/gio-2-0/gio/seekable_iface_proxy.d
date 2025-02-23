module gio.seekable_iface_proxy;

import gobject.object;
import gio.seekable;
import gio.seekable_mixin;

/// Proxy object for Gio.Seekable interface when a GObject has no applicable D binding
class SeekableIfaceProxy : IfaceProxy, Seekable
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Seekable);
  }

  mixin SeekableT!();
}
