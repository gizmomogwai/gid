module gtk.app_chooser_dialog;

import gid.gid;
import gio.file;
import gio.file_mixin;
import gobject.object;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.app_chooser;
import gtk.app_chooser_mixin;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.dialog;
import gtk.native;
import gtk.native_mixin;
import gtk.root;
import gtk.root_mixin;
import gtk.shortcut_manager;
import gtk.shortcut_manager_mixin;
import gtk.types;
import gtk.widget;
import gtk.window;

/**
 * `GtkAppChooserDialog` shows a `GtkAppChooserWidget` inside a `GtkDialog`.
 * ![An example GtkAppChooserDialog](appchooserdialog.png)
 * Note that `GtkAppChooserDialog` does not have any interesting methods
 * of its own. Instead, you should get the embedded `GtkAppChooserWidget`
 * using [Gtk.AppChooserDialog.getWidget] and call its methods if
 * the generic [Gtk.AppChooser] interface is not sufficient for
 * your needs.
 * To set the heading that is shown above the `GtkAppChooserWidget`,
 * use [Gtk.AppChooserDialog.setHeading].
 * ## CSS nodes
 * `GtkAppChooserDialog` has a single CSS node with the name `window` and style
 * class `.appchooser`.

 * Deprecated: The application selection widgets should be
 *   implemented according to the design of each platform and/or
 *   application requiring them.
 */
class AppChooserDialog : Dialog, AppChooser
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_app_chooser_dialog_get_type != &gidSymbolNotFound ? gtk_app_chooser_dialog_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AppChooserT!();

  /**
   * Creates a new `GtkAppChooserDialog` for the provided `GFile`.
   * The dialog will show applications that can open the file.
   * Params:
   *   parent = a `GtkWindow`
   *   flags = flags for this dialog
   *   file = a `GFile`
   * Returns: a newly created `GtkAppChooserDialog`

   * Deprecated: This widget will be removed in GTK 5
   */
  this(Window parent, DialogFlags flags, File file)
  {
    GtkWidget* _cretval;
    _cretval = gtk_app_chooser_dialog_new(parent ? cast(GtkWindow*)parent.cPtr(No.Dup) : null, flags, file ? cast(GFile*)(cast(ObjectG)file).cPtr(No.Dup) : null);
    this(_cretval, No.Take);
  }

  /**
   * Creates a new `GtkAppChooserDialog` for the provided content type.
   * The dialog will show applications that can open the content type.
   * Params:
   *   parent = a `GtkWindow`
   *   flags = flags for this dialog
   *   contentType = a content type string
   * Returns: a newly created `GtkAppChooserDialog`

   * Deprecated: This widget will be removed in GTK 5
   */
  static AppChooserDialog newForContentType(Window parent, DialogFlags flags, string contentType)
  {
    GtkWidget* _cretval;
    const(char)* _contentType = contentType.toCString(No.Alloc);
    _cretval = gtk_app_chooser_dialog_new_for_content_type(parent ? cast(GtkWindow*)parent.cPtr(No.Dup) : null, flags, _contentType);
    auto _retval = ObjectG.getDObject!AppChooserDialog(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns the text to display at the top of the dialog.
   * Returns: the text to display at the top of the dialog,
   *   or %NULL, in which case a default text is displayed

   * Deprecated: This widget will be removed in GTK 5
   */
  string getHeading()
  {
    const(char)* _cretval;
    _cretval = gtk_app_chooser_dialog_get_heading(cast(GtkAppChooserDialog*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Returns the `GtkAppChooserWidget` of this dialog.
   * Returns: the `GtkAppChooserWidget` of self

   * Deprecated: This widget will be removed in GTK 5
   */
  Widget getWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_app_chooser_dialog_get_widget(cast(GtkAppChooserDialog*)cPtr);
    auto _retval = ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Sets the text to display at the top of the dialog.
   * If the heading is not set, the dialog displays a default text.
   * Params:
   *   heading = a string containing Pango markup

   * Deprecated: This widget will be removed in GTK 5
   */
  void setHeading(string heading)
  {
    const(char)* _heading = heading.toCString(No.Alloc);
    gtk_app_chooser_dialog_set_heading(cast(GtkAppChooserDialog*)cPtr, _heading);
  }
}
