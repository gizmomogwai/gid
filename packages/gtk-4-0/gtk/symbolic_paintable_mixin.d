module gtk.symbolic_paintable_mixin;

public import gtk.symbolic_paintable_iface_proxy;
public import gdk.rgba;
public import gdk.snapshot;
public import gid.gid;
public import gtk.c.functions;
public import gtk.c.types;
public import gtk.types;

/**
 * `GtkSymbolicPaintable` is an interface that support symbolic colors in
 * paintables.
 * `GdkPaintable`s implementing the interface will have the
 * vfunc@Gtk.SymbolicPaintable.snapshot_symbolic function called and
 * have the colors for drawing symbolic icons passed. At least 4 colors are guaranteed
 * to be passed every time.
 * These 4 colors are the foreground color, and the colors to use for errors, warnings
 * and success information in that order.
 * More colors may be added in the future.
 */
template SymbolicPaintableT()
{

  /**
   * Snapshots the paintable with the given colors.
   * If less than 4 colors are provided, GTK will pad the array with default
   * colors.
   * Params:
   *   snapshot = a `GdkSnapshot` to snapshot to
   *   width = width to snapshot in
   *   height = height to snapshot in
   *   colors = a pointer to an array of colors
   */
  override void snapshotSymbolic(Snapshot snapshot, double width, double height, RGBA[] colors)
  {
    size_t _nColors;
    if (colors)
      _nColors = cast(size_t)colors.length;

    GdkRGBA[] _tmpcolors;
    foreach (obj; colors)
      _tmpcolors ~= *cast(GdkRGBA*)obj.cPtr;
    const(GdkRGBA)* _colors = _tmpcolors.ptr;
    gtk_symbolic_paintable_snapshot_symbolic(cast(GtkSymbolicPaintable*)cPtr, snapshot ? cast(GdkSnapshot*)snapshot.cPtr(No.Dup) : null, width, height, _colors, _nColors);
  }
}
