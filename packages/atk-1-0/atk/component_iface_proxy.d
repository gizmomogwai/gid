module atk.component_iface_proxy;

import gobject.object;
import atk.component;
import atk.component_mixin;

/// Proxy object for Atk.Component interface when a GObject has no applicable D binding
class ComponentIfaceProxy : IfaceProxy, Component
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Component);
  }

  mixin ComponentT!();
}
