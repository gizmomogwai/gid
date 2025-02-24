module gtksource.hover_provider;

public import gtksource.hover_provider_iface_proxy;
import gid.gid;
import gio.async_result;
import gio.async_result_mixin;
import gio.cancellable;
import gio.types;
import glib.error;
import gobject.object;
import gtksource.c.functions;
import gtksource.c.types;
import gtksource.hover_context;
import gtksource.hover_display;
import gtksource.types;

/**
 * Interface to populate interactive tooltips.
 * `GtkSourceHoverProvider` is an interface that should be implemented to extend
 * the contents of a class@HoverDisplay. This is typical in editors that
 * interact external tooling such as those utilizing Language Server Protocol.
 * If you can populate the class@HoverDisplay synchronously, use
 * vfunc@HoverProvider.populate. Otherwise, interface implementations that
 * may take additional time should use vfunc@HoverProvider.populate_async
 * to avoid blocking the main loop.
 */
interface HoverProvider
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_source_hover_provider_get_type != &gidSymbolNotFound ? gtk_source_hover_provider_get_type() : cast(GType)0;
  }

  void populateAsync(HoverContext context, HoverDisplay display, Cancellable cancellable, AsyncReadyCallback callback);

  bool populateFinish(AsyncResult result);
}
