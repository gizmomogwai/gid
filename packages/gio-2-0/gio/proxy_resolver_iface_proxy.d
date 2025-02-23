module gio.proxy_resolver_iface_proxy;

import gobject.object;
import gio.proxy_resolver;
import gio.proxy_resolver_mixin;

/// Proxy object for Gio.ProxyResolver interface when a GObject has no applicable D binding
class ProxyResolverIfaceProxy : IfaceProxy, ProxyResolver
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(ProxyResolver);
  }

  mixin ProxyResolverT!();
}
