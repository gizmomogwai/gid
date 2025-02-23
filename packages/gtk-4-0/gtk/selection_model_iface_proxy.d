module gtk.selection_model_iface_proxy;

import gobject.object;
import gtk.selection_model;
import gtk.selection_model_mixin;

/// Proxy object for Gtk.SelectionModel interface when a GObject has no applicable D binding
class SelectionModelIfaceProxy : IfaceProxy, SelectionModel
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(SelectionModel);
  }

  mixin SelectionModelT!();
}
