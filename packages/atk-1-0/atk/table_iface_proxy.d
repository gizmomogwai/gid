module atk.table_iface_proxy;

import gobject.object;
import atk.table;
import atk.table_mixin;

/// Proxy object for Atk.Table interface when a GObject has no applicable D binding
class TableIfaceProxy : IfaceProxy, Table
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Table);
  }

  mixin TableT!();
}
