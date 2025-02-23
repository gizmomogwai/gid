module gtk.root_iface_proxy;

import gobject.object;
import gtk.root;
import gtk.root_mixin;

/// Proxy object for Gtk.Root interface when a GObject has no applicable D binding
class RootIfaceProxy : IfaceProxy, Root
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Root);
  }

  mixin RootT!();
}
