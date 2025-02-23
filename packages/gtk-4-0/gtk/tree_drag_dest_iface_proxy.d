module gtk.tree_drag_dest_iface_proxy;

import gobject.object;
import gtk.tree_drag_dest;
import gtk.tree_drag_dest_mixin;

/// Proxy object for Gtk.TreeDragDest interface when a GObject has no applicable D binding
class TreeDragDestIfaceProxy : IfaceProxy, TreeDragDest
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(TreeDragDest);
  }

  mixin TreeDragDestT!();
}
