module gio.desktop_app_info_lookup_iface_proxy;

import gobject.object;
import gio.desktop_app_info_lookup;
import gio.desktop_app_info_lookup_mixin;

/// Proxy object for Gio.DesktopAppInfoLookup interface when a GObject has no applicable D binding
class DesktopAppInfoLookupIfaceProxy : IfaceProxy, DesktopAppInfoLookup
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(DesktopAppInfoLookup);
  }

  mixin DesktopAppInfoLookupT!();
}
