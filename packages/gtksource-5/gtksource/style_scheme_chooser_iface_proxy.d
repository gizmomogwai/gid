module gtksource.style_scheme_chooser_iface_proxy;

import gobject.object;
import gtksource.style_scheme_chooser;
import gtksource.style_scheme_chooser_mixin;

/// Proxy object for GtkSource.StyleSchemeChooser interface when a GObject has no applicable D binding
class StyleSchemeChooserIfaceProxy : IfaceProxy, StyleSchemeChooser
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(StyleSchemeChooser);
  }

  mixin StyleSchemeChooserT!();
}
