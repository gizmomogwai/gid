module atk.selection_iface_proxy;

import gobject.object;
import atk.selection;
import atk.selection_mixin;

/// Proxy object for Atk.Selection interface when a GObject has no applicable D binding
class SelectionIfaceProxy : IfaceProxy, Selection
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Selection);
  }

  mixin SelectionT!();
}
