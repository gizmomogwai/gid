module gtk.print_context;

import cairo.context : DcairoContext = Context;
import gid.global;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.page_setup;
import gtk.types;
import pango.context;
import pango.font_map;
import pango.layout;

/**
 * A `GtkPrintContext` encapsulates context information that is required when
 * drawing pages for printing.
 * This includes the cairo context and important parameters like page size
 * and resolution. It also lets you easily create [pango.layout.Layout] and
 * [pango.context.Context] objects that match the font metrics of the cairo surface.
 * `GtkPrintContext` objects get passed to the
 * signal@Gtk.PrintOperation::begin-print,
 * signal@Gtk.PrintOperation::end-print,
 * signal@Gtk.PrintOperation::request-page-setup and
 * signal@Gtk.PrintOperation::draw-page signals on the
 * [gtk.print_operation.PrintOperation] object.
 * ## Using GtkPrintContext in a ::draw-page callback
 * ```c
 * static void
 * draw_page $(LPAREN)GtkPrintOperation *operation,
 * GtkPrintContext   *context,
 * int                page_nr$(RPAREN)
 * {
 * cairo_t *cr;
 * PangoLayout *layout;
 * PangoFontDescription *desc;
 * cr \= gtk_print_context_get_cairo_context $(LPAREN)context$(RPAREN);
 * // Draw a red rectangle, as wide as the paper $(LPAREN)inside the margins$(RPAREN)
 * cairo_set_source_rgb $(LPAREN)cr, 1.0, 0, 0$(RPAREN);
 * cairo_rectangle $(LPAREN)cr, 0, 0, gtk_print_context_get_width $(LPAREN)context$(RPAREN), 50$(RPAREN);
 * cairo_fill $(LPAREN)cr$(RPAREN);
 * // Draw some lines
 * cairo_move_to $(LPAREN)cr, 20, 10$(RPAREN);
 * cairo_line_to $(LPAREN)cr, 40, 20$(RPAREN);
 * cairo_arc $(LPAREN)cr, 60, 60, 20, 0, M_PI$(RPAREN);
 * cairo_line_to $(LPAREN)cr, 80, 20$(RPAREN);
 * cairo_set_source_rgb $(LPAREN)cr, 0, 0, 0$(RPAREN);
 * cairo_set_line_width $(LPAREN)cr, 5$(RPAREN);
 * cairo_set_line_cap $(LPAREN)cr, CAIRO_LINE_CAP_ROUND$(RPAREN);
 * cairo_set_line_join $(LPAREN)cr, CAIRO_LINE_JOIN_ROUND$(RPAREN);
 * cairo_stroke $(LPAREN)cr$(RPAREN);
 * // Draw some text
 * layout \= gtk_print_context_create_pango_layout $(LPAREN)context$(RPAREN);
 * pango_layout_set_text $(LPAREN)layout, "Hello World! Printing is easy", -1$(RPAREN);
 * desc \= pango_font_description_from_string $(LPAREN)"sans 28"$(RPAREN);
 * pango_layout_set_font_description $(LPAREN)layout, desc$(RPAREN);
 * pango_font_description_free $(LPAREN)desc$(RPAREN);
 * cairo_move_to $(LPAREN)cr, 30, 20$(RPAREN);
 * pango_cairo_layout_path $(LPAREN)cr, layout$(RPAREN);
 * // Font Outline
 * cairo_set_source_rgb $(LPAREN)cr, 0.93, 1.0, 0.47$(RPAREN);
 * cairo_set_line_width $(LPAREN)cr, 0.5$(RPAREN);
 * cairo_stroke_preserve $(LPAREN)cr$(RPAREN);
 * // Font Fill
 * cairo_set_source_rgb $(LPAREN)cr, 0, 0.0, 1.0$(RPAREN);
 * cairo_fill $(LPAREN)cr$(RPAREN);
 * g_object_unref $(LPAREN)layout$(RPAREN);
 * }
 * ```
 */
class PrintContext : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_print_context_get_type != &gidSymbolNotFound ? gtk_print_context_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `PangoContext` that can be used with the
   * `GtkPrintContext`.
   * Returns: a new Pango context for context
   */
  Context createPangoContext()
  {
    PangoContext* _cretval;
    _cretval = gtk_print_context_create_pango_context(cast(GtkPrintContext*)cPtr);
    auto _retval = ObjectG.getDObject!Context(cast(PangoContext*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Creates a new `PangoLayout` that is suitable for use
   * with the `GtkPrintContext`.
   * Returns: a new Pango layout for context
   */
  Layout createPangoLayout()
  {
    PangoLayout* _cretval;
    _cretval = gtk_print_context_create_pango_layout(cast(GtkPrintContext*)cPtr);
    auto _retval = ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Obtains the cairo context that is associated with the
   * `GtkPrintContext`.
   * Returns: the cairo context of context
   */
  DcairoContext getCairoContext()
  {
    cairo_t* _cretval;
    _cretval = gtk_print_context_get_cairo_context(cast(GtkPrintContext*)cPtr);
    auto _retval = _cretval ? new DcairoContext(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Obtains the horizontal resolution of the `GtkPrintContext`,
   * in dots per inch.
   * Returns: the horizontal resolution of context
   */
  double getDpiX()
  {
    double _retval;
    _retval = gtk_print_context_get_dpi_x(cast(GtkPrintContext*)cPtr);
    return _retval;
  }

  /**
   * Obtains the vertical resolution of the `GtkPrintContext`,
   * in dots per inch.
   * Returns: the vertical resolution of context
   */
  double getDpiY()
  {
    double _retval;
    _retval = gtk_print_context_get_dpi_y(cast(GtkPrintContext*)cPtr);
    return _retval;
  }

  /**
   * Obtains the hardware printer margins of the `GtkPrintContext`,
   * in units.
   * Params:
   *   top = top hardware printer margin
   *   bottom = bottom hardware printer margin
   *   left = left hardware printer margin
   *   right = right hardware printer margin
   * Returns: %TRUE if the hard margins were retrieved
   */
  bool getHardMargins(out double top, out double bottom, out double left, out double right)
  {
    bool _retval;
    _retval = gtk_print_context_get_hard_margins(cast(GtkPrintContext*)cPtr, cast(double*)&top, cast(double*)&bottom, cast(double*)&left, cast(double*)&right);
    return _retval;
  }

  /**
   * Obtains the height of the `GtkPrintContext`, in pixels.
   * Returns: the height of context
   */
  double getHeight()
  {
    double _retval;
    _retval = gtk_print_context_get_height(cast(GtkPrintContext*)cPtr);
    return _retval;
  }

  /**
   * Obtains the `GtkPageSetup` that determines the page
   * dimensions of the `GtkPrintContext`.
   * Returns: the page setup of context
   */
  PageSetup getPageSetup()
  {
    GtkPageSetup* _cretval;
    _cretval = gtk_print_context_get_page_setup(cast(GtkPrintContext*)cPtr);
    auto _retval = ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns a `PangoFontMap` that is suitable for use
   * with the `GtkPrintContext`.
   * Returns: the font map of context
   */
  FontMap getPangoFontmap()
  {
    PangoFontMap* _cretval;
    _cretval = gtk_print_context_get_pango_fontmap(cast(GtkPrintContext*)cPtr);
    auto _retval = ObjectG.getDObject!FontMap(cast(PangoFontMap*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Obtains the width of the `GtkPrintContext`, in pixels.
   * Returns: the width of context
   */
  double getWidth()
  {
    double _retval;
    _retval = gtk_print_context_get_width(cast(GtkPrintContext*)cPtr);
    return _retval;
  }

  /**
   * Sets a new cairo context on a print context.
   * This function is intended to be used when implementing
   * an internal print preview, it is not needed for printing,
   * since GTK itself creates a suitable cairo context in that
   * case.
   * Params:
   *   cr = the cairo context
   *   dpiX = the horizontal resolution to use with cr
   *   dpiY = the vertical resolution to use with cr
   */
  void setCairoContext(DcairoContext cr, double dpiX, double dpiY)
  {
    gtk_print_context_set_cairo_context(cast(GtkPrintContext*)cPtr, cr ? cast(cairo_t*)cr.cPtr(No.Dup) : null, dpiX, dpiY);
  }
}
