module gtk.constraint_target_iface_proxy;

import gobject.object;
import gtk.constraint_target;
import gtk.constraint_target_mixin;

/// Proxy object for Gtk.ConstraintTarget interface when a GObject has no applicable D binding
class ConstraintTargetIfaceProxy : IfaceProxy, ConstraintTarget
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(ConstraintTarget);
  }

  mixin ConstraintTargetT!();
}
