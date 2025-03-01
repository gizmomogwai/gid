module gtk.page_setup;

import gid.global;
import glib.error;
import glib.key_file;
import glib.variant;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.paper_size;
import gtk.types;

/**
 * A `GtkPageSetup` object stores the page size, orientation and margins.
 * The idea is that you can get one of these from the page setup dialog
 * and then pass it to the `GtkPrintOperation` when printing.
 * The benefit of splitting this out of the `GtkPrintSettings` is that
 * these affect the actual layout of the page, and thus need to be set
 * long before user prints.
 * ## Margins
 * The margins specified in this object are the “print margins”, i.e. the
 * parts of the page that the printer cannot print on. These are different
 * from the layout margins that a word processor uses; they are typically
 * used to determine the minimal size for the layout margins.
 * To obtain a `GtkPageSetup` use [gtk.page_setup.PageSetup.new_] to get the defaults,
 * or use func@Gtk.print_run_page_setup_dialog to show the page setup dialog
 * and receive the resulting page setup.
 * ## A page setup dialog
 * ```c
 * static GtkPrintSettings *settings \= NULL;
 * static GtkPageSetup *page_setup \= NULL;
 * static void
 * do_page_setup $(LPAREN)void$(RPAREN)
 * {
 * GtkPageSetup *new_page_setup;
 * if $(LPAREN)settings \=\= NULL$(RPAREN)
 * settings \= gtk_print_settings_new $(LPAREN)$(RPAREN);
 * new_page_setup \= gtk_print_run_page_setup_dialog $(LPAREN)GTK_WINDOW $(LPAREN)main_window$(RPAREN),
 * page_setup, settings$(RPAREN);
 * if $(LPAREN)page_setup$(RPAREN)
 * g_object_unref $(LPAREN)page_setup$(RPAREN);
 * page_setup \= new_page_setup;
 * }
 * ```
 */
class PageSetup : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_page_setup_get_type != &gidSymbolNotFound ? gtk_page_setup_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkPageSetup`.
   * Returns: a new `GtkPageSetup`.
   */
  this()
  {
    GtkPageSetup* _cretval;
    _cretval = gtk_page_setup_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Reads the page setup from the file file_name.
   * Returns a new `GtkPageSetup` object with the restored
   * page setup, or %NULL if an error occurred.
   * See [gtk.page_setup.PageSetup.toFile].
   * Params:
   *   fileName = the filename to read the page setup from
   * Returns: the restored `GtkPageSetup`
   */
  static PageSetup newFromFile(string fileName)
  {
    GtkPageSetup* _cretval;
    const(char)* _fileName = fileName.toCString(No.Alloc);
    GError *_err;
    _cretval = gtk_page_setup_new_from_file(_fileName, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Desrialize a page setup from an a{sv} variant.
   * The variant must be in the format produced by
   * [gtk.page_setup.PageSetup.toGvariant].
   * Params:
   *   variant = an a{sv} `GVariant`
   * Returns: a new `GtkPageSetup` object
   */
  static PageSetup newFromGvariant(VariantG variant)
  {
    GtkPageSetup* _cretval;
    _cretval = gtk_page_setup_new_from_gvariant(variant ? cast(VariantC*)variant.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Reads the page setup from the group group_name in the key file
   * key_file.
   * Returns a new `GtkPageSetup` object with the restored
   * page setup, or %NULL if an error occurred.
   * Params:
   *   keyFile = the `GKeyFile` to retrieve the page_setup from
   *   groupName = the name of the group in the key_file to read
   *     to use the default name “Page Setup”
   * Returns: the restored `GtkPageSetup`
   */
  static PageSetup newFromKeyFile(KeyFile keyFile, string groupName)
  {
    GtkPageSetup* _cretval;
    const(char)* _groupName = groupName.toCString(No.Alloc);
    GError *_err;
    _cretval = gtk_page_setup_new_from_key_file(keyFile ? cast(GKeyFile*)keyFile.cPtr(No.Dup) : null, _groupName, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Copies a `GtkPageSetup`.
   * Returns: a copy of other
   */
  PageSetup copy()
  {
    GtkPageSetup* _cretval;
    _cretval = gtk_page_setup_copy(cast(GtkPageSetup*)cPtr);
    auto _retval = ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the bottom margin in units of unit.
   * Params:
   *   unit = the unit for the return value
   * Returns: the bottom margin
   */
  double getBottomMargin(Unit unit)
  {
    double _retval;
    _retval = gtk_page_setup_get_bottom_margin(cast(GtkPageSetup*)cPtr, unit);
    return _retval;
  }

  /**
   * Gets the left margin in units of unit.
   * Params:
   *   unit = the unit for the return value
   * Returns: the left margin
   */
  double getLeftMargin(Unit unit)
  {
    double _retval;
    _retval = gtk_page_setup_get_left_margin(cast(GtkPageSetup*)cPtr, unit);
    return _retval;
  }

  /**
   * Gets the page orientation of the `GtkPageSetup`.
   * Returns: the page orientation
   */
  PageOrientation getOrientation()
  {
    GtkPageOrientation _cretval;
    _cretval = gtk_page_setup_get_orientation(cast(GtkPageSetup*)cPtr);
    PageOrientation _retval = cast(PageOrientation)_cretval;
    return _retval;
  }

  /**
   * Returns the page height in units of unit.
   * Note that this function takes orientation
   * and margins into consideration.
   * See [gtk.page_setup.PageSetup.getPaperHeight].
   * Params:
   *   unit = the unit for the return value
   * Returns: the page height.
   */
  double getPageHeight(Unit unit)
  {
    double _retval;
    _retval = gtk_page_setup_get_page_height(cast(GtkPageSetup*)cPtr, unit);
    return _retval;
  }

  /**
   * Returns the page width in units of unit.
   * Note that this function takes orientation
   * and margins into consideration.
   * See [gtk.page_setup.PageSetup.getPaperWidth].
   * Params:
   *   unit = the unit for the return value
   * Returns: the page width.
   */
  double getPageWidth(Unit unit)
  {
    double _retval;
    _retval = gtk_page_setup_get_page_width(cast(GtkPageSetup*)cPtr, unit);
    return _retval;
  }

  /**
   * Returns the paper height in units of unit.
   * Note that this function takes orientation,
   * but not margins into consideration.
   * See [gtk.page_setup.PageSetup.getPageHeight].
   * Params:
   *   unit = the unit for the return value
   * Returns: the paper height.
   */
  double getPaperHeight(Unit unit)
  {
    double _retval;
    _retval = gtk_page_setup_get_paper_height(cast(GtkPageSetup*)cPtr, unit);
    return _retval;
  }

  /**
   * Gets the paper size of the `GtkPageSetup`.
   * Returns: the paper size
   */
  PaperSize getPaperSize()
  {
    GtkPaperSize* _cretval;
    _cretval = gtk_page_setup_get_paper_size(cast(GtkPageSetup*)cPtr);
    auto _retval = _cretval ? new PaperSize(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Returns the paper width in units of unit.
   * Note that this function takes orientation,
   * but not margins into consideration.
   * See [gtk.page_setup.PageSetup.getPageWidth].
   * Params:
   *   unit = the unit for the return value
   * Returns: the paper width.
   */
  double getPaperWidth(Unit unit)
  {
    double _retval;
    _retval = gtk_page_setup_get_paper_width(cast(GtkPageSetup*)cPtr, unit);
    return _retval;
  }

  /**
   * Gets the right margin in units of unit.
   * Params:
   *   unit = the unit for the return value
   * Returns: the right margin
   */
  double getRightMargin(Unit unit)
  {
    double _retval;
    _retval = gtk_page_setup_get_right_margin(cast(GtkPageSetup*)cPtr, unit);
    return _retval;
  }

  /**
   * Gets the top margin in units of unit.
   * Params:
   *   unit = the unit for the return value
   * Returns: the top margin
   */
  double getTopMargin(Unit unit)
  {
    double _retval;
    _retval = gtk_page_setup_get_top_margin(cast(GtkPageSetup*)cPtr, unit);
    return _retval;
  }

  /**
   * Reads the page setup from the file file_name.
   * See [gtk.page_setup.PageSetup.toFile].
   * Params:
   *   fileName = the filename to read the page setup from
   * Returns: %TRUE on success
   */
  bool loadFile(string fileName)
  {
    bool _retval;
    const(char)* _fileName = fileName.toCString(No.Alloc);
    GError *_err;
    _retval = gtk_page_setup_load_file(cast(GtkPageSetup*)cPtr, _fileName, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads the page setup from the group group_name in the key file
   * key_file.
   * Params:
   *   keyFile = the `GKeyFile` to retrieve the page_setup from
   *   groupName = the name of the group in the key_file to read
   *     to use the default name “Page Setup”
   * Returns: %TRUE on success
   */
  bool loadKeyFile(KeyFile keyFile, string groupName)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(No.Alloc);
    GError *_err;
    _retval = gtk_page_setup_load_key_file(cast(GtkPageSetup*)cPtr, keyFile ? cast(GKeyFile*)keyFile.cPtr(No.Dup) : null, _groupName, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the bottom margin of the `GtkPageSetup`.
   * Params:
   *   margin = the new bottom margin in units of unit
   *   unit = the units for margin
   */
  void setBottomMargin(double margin, Unit unit)
  {
    gtk_page_setup_set_bottom_margin(cast(GtkPageSetup*)cPtr, margin, unit);
  }

  /**
   * Sets the left margin of the `GtkPageSetup`.
   * Params:
   *   margin = the new left margin in units of unit
   *   unit = the units for margin
   */
  void setLeftMargin(double margin, Unit unit)
  {
    gtk_page_setup_set_left_margin(cast(GtkPageSetup*)cPtr, margin, unit);
  }

  /**
   * Sets the page orientation of the `GtkPageSetup`.
   * Params:
   *   orientation = a `GtkPageOrientation` value
   */
  void setOrientation(PageOrientation orientation)
  {
    gtk_page_setup_set_orientation(cast(GtkPageSetup*)cPtr, orientation);
  }

  /**
   * Sets the paper size of the `GtkPageSetup` without
   * changing the margins.
   * See [gtk.page_setup.PageSetup.setPaperSizeAndDefaultMargins].
   * Params:
   *   size = a `GtkPaperSize`
   */
  void setPaperSize(PaperSize size)
  {
    gtk_page_setup_set_paper_size(cast(GtkPageSetup*)cPtr, size ? cast(GtkPaperSize*)size.cPtr(No.Dup) : null);
  }

  /**
   * Sets the paper size of the `GtkPageSetup` and modifies
   * the margins according to the new paper size.
   * Params:
   *   size = a `GtkPaperSize`
   */
  void setPaperSizeAndDefaultMargins(PaperSize size)
  {
    gtk_page_setup_set_paper_size_and_default_margins(cast(GtkPageSetup*)cPtr, size ? cast(GtkPaperSize*)size.cPtr(No.Dup) : null);
  }

  /**
   * Sets the right margin of the `GtkPageSetup`.
   * Params:
   *   margin = the new right margin in units of unit
   *   unit = the units for margin
   */
  void setRightMargin(double margin, Unit unit)
  {
    gtk_page_setup_set_right_margin(cast(GtkPageSetup*)cPtr, margin, unit);
  }

  /**
   * Sets the top margin of the `GtkPageSetup`.
   * Params:
   *   margin = the new top margin in units of unit
   *   unit = the units for margin
   */
  void setTopMargin(double margin, Unit unit)
  {
    gtk_page_setup_set_top_margin(cast(GtkPageSetup*)cPtr, margin, unit);
  }

  /**
   * This function saves the information from setup to file_name.
   * Params:
   *   fileName = the file to save to
   * Returns: %TRUE on success
   */
  bool toFile(string fileName)
  {
    bool _retval;
    const(char)* _fileName = fileName.toCString(No.Alloc);
    GError *_err;
    _retval = gtk_page_setup_to_file(cast(GtkPageSetup*)cPtr, _fileName, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Serialize page setup to an a{sv} variant.
   * Returns: a new, floating, `GVariant`
   */
  VariantG toGvariant()
  {
    VariantC* _cretval;
    _cretval = gtk_page_setup_to_gvariant(cast(GtkPageSetup*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * This function adds the page setup from setup to key_file.
   * Params:
   *   keyFile = the `GKeyFile` to save the page setup to
   *   groupName = the group to add the settings to in key_file,
   *     or %NULL to use the default name “Page Setup”
   */
  void toKeyFile(KeyFile keyFile, string groupName)
  {
    const(char)* _groupName = groupName.toCString(No.Alloc);
    gtk_page_setup_to_key_file(cast(GtkPageSetup*)cPtr, keyFile ? cast(GKeyFile*)keyFile.cPtr(No.Dup) : null, _groupName);
  }
}
