module gtk.tree_drag_source_iface_proxy;

import gobject.object;
import gtk.tree_drag_source;
import gtk.tree_drag_source_mixin;

/// Proxy object for Gtk.TreeDragSource interface when a GObject has no applicable D binding
class TreeDragSourceIfaceProxy : IfaceProxy, TreeDragSource
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(TreeDragSource);
  }

  mixin TreeDragSourceT!();
}
