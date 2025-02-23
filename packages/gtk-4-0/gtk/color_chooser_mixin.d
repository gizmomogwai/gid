module gtk.color_chooser_mixin;

public import gtk.color_chooser_iface_proxy;
public import gdk.rgba;
public import gid.gid;
public import gobject.dclosure;
public import gtk.c.functions;
public import gtk.c.types;
public import gtk.types;

/**
 * `GtkColorChooser` is an interface that is implemented by widgets
 * for choosing colors.
 * Depending on the situation, colors may be allowed to have alpha $(LPAREN)translucency$(RPAREN).
 * In GTK, the main widgets that implement this interface are
 * [Gtk.ColorChooserWidget], [Gtk.ColorChooserDialog] and
 * [Gtk.ColorButton].

 * Deprecated: Use [Gtk.ColorDialog] and [Gtk.ColorDialogButton]
 *   instead of widgets implementing `GtkColorChooser`
 */
template ColorChooserT()
{

  /**
   * Adds a palette to the color chooser.
   * If orientation is horizontal, the colors are grouped in rows,
   * with colors_per_line colors in each row. If horizontal is %FALSE,
   * the colors are grouped in columns instead.
   * The default color palette of [Gtk.ColorChooserWidget] has
   * 45 colors, organized in columns of 5 colors $(LPAREN)this includes some
   * grays$(RPAREN).
   * The layout of the color chooser widget works best when the
   * palettes have 9-10 columns.
   * Calling this function for the first time has the side effect
   * of removing the default color palette from the color chooser.
   * If colors is %NULL, removes all previously added palettes.
   * Params:
   *   orientation = %GTK_ORIENTATION_HORIZONTAL if the palette should
   *     be displayed in rows, %GTK_ORIENTATION_VERTICAL for columns
   *   colorsPerLine = the number of colors to show in each row/column
   *   colors = the colors of the palette

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  override void addPalette(Orientation orientation, int colorsPerLine, RGBA[] colors)
  {
    int _nColors;
    if (colors)
      _nColors = cast(int)colors.length;

    GdkRGBA[] _tmpcolors;
    foreach (obj; colors)
      _tmpcolors ~= *cast(GdkRGBA*)obj.cPtr;
    GdkRGBA* _colors = _tmpcolors.ptr;
    gtk_color_chooser_add_palette(cast(GtkColorChooser*)cPtr, orientation, colorsPerLine, _nColors, _colors);
  }

  /**
   * Gets the currently-selected color.
   * Params:
   *   color = a `GdkRGBA` to fill in with the current color

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  override void getRgba(out RGBA color)
  {
    GdkRGBA _color;
    gtk_color_chooser_get_rgba(cast(GtkColorChooser*)cPtr, &_color);
    color = new RGBA(cast(void*)&_color, No.Take);
  }

  /**
   * Returns whether the color chooser shows the alpha channel.
   * Returns: %TRUE if the color chooser uses the alpha channel,
   *   %FALSE if not

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  override bool getUseAlpha()
  {
    bool _retval;
    _retval = gtk_color_chooser_get_use_alpha(cast(GtkColorChooser*)cPtr);
    return _retval;
  }

  /**
   * Sets the color.
   * Params:
   *   color = the new color

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  override void setRgba(RGBA color)
  {
    gtk_color_chooser_set_rgba(cast(GtkColorChooser*)cPtr, color ? cast(GdkRGBA*)color.cPtr(No.Dup) : null);
  }

  /**
   * Sets whether or not the color chooser should use the alpha channel.
   * Params:
   *   useAlpha = %TRUE if color chooser should use alpha channel, %FALSE if not

   * Deprecated: Use [Gtk.ColorDialog] instead
   */
  override void setUseAlpha(bool useAlpha)
  {
    gtk_color_chooser_set_use_alpha(cast(GtkColorChooser*)cPtr, useAlpha);
  }

  /**
   * Emitted when a color is activated from the color chooser.
   * This usually happens when the user clicks a color swatch,
   * or a color is selected and the user presses one of the keys
   * Space, Shift+Space, Return or Enter.
   * Params
   *   color = the color
   *   colorChooser = the instance the signal is connected to

   * Deprecated: Use [Gtk.ColorDialog] and [Gtk.ColorDialogButton]
   *   instead of widgets implementing `GtkColorChooser`
   */
  alias ColorActivatedCallbackDlg = void delegate(RGBA color, ColorChooser colorChooser);
  alias ColorActivatedCallbackFunc = void function(RGBA color, ColorChooser colorChooser);

  /**
   * Connect to ColorActivated signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectColorActivated(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ColorActivatedCallbackDlg) || is(T : ColorActivatedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto colorChooser = getVal!ColorChooser(_paramVals);
      auto color = getVal!RGBA(&_paramVals[1]);
      _dClosure.dlg(color, colorChooser);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("color-activated", closure, after);
  }
}
