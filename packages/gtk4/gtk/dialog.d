module gtk.dialog;

import gid.global;
import gobject.dclosure;
import gobject.object;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.box;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.header_bar;
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
 * Dialogs are a convenient way to prompt the user for a small amount
 * of input.
 * ![An example GtkDialog](dialog.png)
 * Typical uses are to display a message, ask a question, or anything else
 * that does not require extensive effort on the user’s part.
 * The main area of a `GtkDialog` is called the "content area", and is yours
 * to populate with widgets such a `GtkLabel` or `GtkEntry`, to present
 * your information, questions, or tasks to the user.
 * In addition, dialogs allow you to add "action widgets". Most commonly,
 * action widgets are buttons. Depending on the platform, action widgets may
 * be presented in the header bar at the top of the window, or at the bottom
 * of the window. To add action widgets, create your `GtkDialog` using
 * [gtk.dialog.Dialog.newWithButtons], or use
 * [gtk.dialog.Dialog.addButton], [gtk.dialog.Dialog.addButtons],
 * or [gtk.dialog.Dialog.addActionWidget].
 * `GtkDialogs` uses some heuristics to decide whether to add a close
 * button to the window decorations. If any of the action buttons use
 * the response ID %GTK_RESPONSE_CLOSE or %GTK_RESPONSE_CANCEL, the
 * close button is omitted.
 * Clicking a button that was added as an action widget will emit the
 * [gtk.dialog.Dialog.response] signal with a response ID that you specified.
 * GTK will never assign a meaning to positive response IDs; these are
 * entirely user-defined. But for convenience, you can use the response
 * IDs in the [gtk.ResponseType] enumeration $(LPAREN)these all have values
 * less than zero$(RPAREN). If a dialog receives a delete event, the
 * [gtk.dialog.Dialog.response] signal will be emitted with the
 * %GTK_RESPONSE_DELETE_EVENT response ID.
 * Dialogs are created with a call to [gtk.dialog.Dialog.new_] or
 * [gtk.dialog.Dialog.newWithButtons]. The latter is recommended; it allows
 * you to set the dialog title, some convenient flags, and add buttons.
 * A “modal” dialog $(LPAREN)that is, one which freezes the rest of the application
 * from user input$(RPAREN), can be created by calling [gtk.window.Window.setModal]
 * on the dialog. When using [gtk.dialog.Dialog.newWithButtons], you can also
 * pass the %GTK_DIALOG_MODAL flag to make a dialog modal.
 * For the simple dialog in the following example, a [gtk.message_dialog.MessageDialog]
 * would save some effort. But you’d need to create the dialog contents manually
 * if you had more than a simple message in the dialog.
 * An example for simple `GtkDialog` usage:
 * ```c
 * // Function to open a dialog box with a message
 * void
 * quick_message $(LPAREN)GtkWindow *parent, char *message$(RPAREN)
 * {
 * GtkWidget *dialog, *label, *content_area;
 * GtkDialogFlags flags;
 * // Create the widgets
 * flags \= GTK_DIALOG_DESTROY_WITH_PARENT;
 * dialog \= gtk_dialog_new_with_buttons $(LPAREN)"Message",
 * parent,
 * flags,
 * _$(LPAREN)"_OK"$(RPAREN),
 * GTK_RESPONSE_NONE,
 * NULL$(RPAREN);
 * content_area \= gtk_dialog_get_content_area $(LPAREN)GTK_DIALOG $(LPAREN)dialog$(RPAREN)$(RPAREN);
 * label \= gtk_label_new $(LPAREN)message$(RPAREN);
 * // Ensure that the dialog box is destroyed when the user responds
 * g_signal_connect_swapped $(LPAREN)dialog,
 * "response",
 * G_CALLBACK $(LPAREN)gtk_window_destroy$(RPAREN),
 * dialog$(RPAREN);
 * // Add the label, and show everything we’ve added
 * gtk_box_append $(LPAREN)GTK_BOX $(LPAREN)content_area$(RPAREN), label$(RPAREN);
 * gtk_widget_show $(LPAREN)dialog$(RPAREN);
 * }
 * ```
 * # GtkDialog as GtkBuildable
 * The `GtkDialog` implementation of the `GtkBuildable` interface exposes the
 * @content_area as an internal child with the name “content_area”.
 * `GtkDialog` supports a custom `<action-widgets>` element, which can contain
 * multiple `<action-widget>` elements. The “response” attribute specifies a
 * numeric response, and the content of the element is the id of widget
 * $(LPAREN)which should be a child of the dialogs @action_area$(RPAREN). To mark a response
 * as default, set the “default” attribute of the `<action-widget>` element
 * to true.
 * `GtkDialog` supports adding action widgets by specifying “action” as
 * the “type” attribute of a `<child>` element. The widget will be added
 * either to the action area or the headerbar of the dialog, depending
 * on the “use-header-bar” property. The response id has to be associated
 * with the action widget using the `<action-widgets>` element.
 * An example of a `GtkDialog` UI definition fragment:
 * ```xml
 * <object class\="GtkDialog" id\="dialog1">
 * <child type\="action">
 * <object class\="GtkButton" id\="button_cancel"/>
 * </child>
 * <child type\="action">
 * <object class\="GtkButton" id\="button_ok">
 * </object>
 * </child>
 * <action-widgets>
 * <action-widget response\="cancel">button_cancel</action-widget>
 * <action-widget response\="ok" default\="true">button_ok</action-widget>
 * </action-widgets>
 * </object>
 * ```
 * # Accessibility
 * `GtkDialog` uses the %GTK_ACCESSIBLE_ROLE_DIALOG role.

 * Deprecated: Use [gtk.window.Window] instead
 */
class Dialog : Window
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_dialog_get_type != &gidSymbolNotFound ? gtk_dialog_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new dialog box.
   * Widgets should not be packed into the `GtkWindow`
   * directly, but into the content_area and action_area,
   * as described above.
   * Returns: the new dialog as a `GtkWidget`

   * Deprecated: Use [gtk.window.Window] instead
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_dialog_new();
    this(_cretval, No.Take);
  }

  /**
   * Adds an activatable widget to the action area of a `GtkDialog`.
   * GTK connects a signal handler that will emit the
   * [gtk.dialog.Dialog.response] signal on the dialog when the widget
   * is activated. The widget is appended to the end of the dialog’s action
   * area.
   * If you want to add a non-activatable widget, simply pack it into
   * the action_area field of the `GtkDialog` struct.
   * Params:
   *   child = an activatable widget
   *   responseId = response ID for child

   * Deprecated: Use [gtk.window.Window] instead
   */
  void addActionWidget(Widget child, int responseId)
  {
    gtk_dialog_add_action_widget(cast(GtkDialog*)cPtr, child ? cast(GtkWidget*)child.cPtr(No.Dup) : null, responseId);
  }

  /**
   * Adds a button with the given text.
   * GTK arranges things so that clicking the button will emit the
   * [gtk.dialog.Dialog.response] signal with the given response_id.
   * The button is appended to the end of the dialog’s action area.
   * The button widget is returned, but usually you don’t need it.
   * Params:
   *   buttonText = text of button
   *   responseId = response ID for the button
   * Returns: the `GtkButton` widget that was added

   * Deprecated: Use [gtk.window.Window] instead
   */
  Widget addButton(string buttonText, int responseId)
  {
    GtkWidget* _cretval;
    const(char)* _buttonText = buttonText.toCString(No.Alloc);
    _cretval = gtk_dialog_add_button(cast(GtkDialog*)cPtr, _buttonText, responseId);
    auto _retval = ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns the content area of dialog.
   * Returns: the content area `GtkBox`.

   * Deprecated: Use [gtk.window.Window] instead
   */
  Box getContentArea()
  {
    GtkWidget* _cretval;
    _cretval = gtk_dialog_get_content_area(cast(GtkDialog*)cPtr);
    auto _retval = ObjectG.getDObject!Box(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns the header bar of dialog.
   * Note that the headerbar is only used by the dialog if the
   * propertyGtk.Dialog:use-header-bar property is %TRUE.
   * Returns: the header bar

   * Deprecated: Use [gtk.window.Window] instead
   */
  HeaderBar getHeaderBar()
  {
    GtkWidget* _cretval;
    _cretval = gtk_dialog_get_header_bar(cast(GtkDialog*)cPtr);
    auto _retval = ObjectG.getDObject!HeaderBar(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the response id of a widget in the action area
   * of a dialog.
   * Params:
   *   widget = a widget in the action area of dialog
   * Returns: the response id of widget, or %GTK_RESPONSE_NONE
   *   if widget doesn’t have a response id set.

   * Deprecated: Use [gtk.window.Window] instead
   */
  int getResponseForWidget(Widget widget)
  {
    int _retval;
    _retval = gtk_dialog_get_response_for_widget(cast(GtkDialog*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(No.Dup) : null);
    return _retval;
  }

  /**
   * Gets the widget button that uses the given response ID in the action area
   * of a dialog.
   * Params:
   *   responseId = the response ID used by the dialog widget
   * Returns: the widget button that uses the given
   *   response_id

   * Deprecated: Use [gtk.window.Window] instead
   */
  Widget getWidgetForResponse(int responseId)
  {
    GtkWidget* _cretval;
    _cretval = gtk_dialog_get_widget_for_response(cast(GtkDialog*)cPtr, responseId);
    auto _retval = ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Emits the ::response signal with the given response ID.
   * Used to indicate that the user has responded to the dialog in some way.
   * Params:
   *   responseId = response ID

   * Deprecated: Use [gtk.window.Window] instead
   */
  void response(int responseId)
  {
    gtk_dialog_response(cast(GtkDialog*)cPtr, responseId);
  }

  /**
   * Sets the default widget for the dialog based on the response ID.
   * Pressing “Enter” normally activates the default widget.
   * Params:
   *   responseId = a response ID

   * Deprecated: Use [gtk.window.Window] instead
   */
  void setDefaultResponse(int responseId)
  {
    gtk_dialog_set_default_response(cast(GtkDialog*)cPtr, responseId);
  }

  /**
   * A convenient way to sensitize/desensitize dialog buttons.
   * Calls `gtk_widget_set_sensitive $(LPAREN)widget, setting$(RPAREN)`
   * for each widget in the dialog’s action area with the given response_id.
   * Params:
   *   responseId = a response ID
   *   setting = %TRUE for sensitive

   * Deprecated: Use [gtk.window.Window] instead
   */
  void setResponseSensitive(int responseId, bool setting)
  {
    gtk_dialog_set_response_sensitive(cast(GtkDialog*)cPtr, responseId, setting);
  }

  /**
   * Emitted when the user uses a keybinding to close the dialog.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is the Escape key.
   *   dialog = the instance the signal is connected to

   * Deprecated: Use [gtk.window.Window] instead
   */
  alias CloseCallbackDlg = void delegate(Dialog dialog);
  alias CloseCallbackFunc = void function(Dialog dialog);

  /**
   * Connect to Close signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectClose(T)(T callback, Flag!"After" after = No.After)
  if (is(T : CloseCallbackDlg) || is(T : CloseCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto dialog = getVal!Dialog(_paramVals);
      _dClosure.dlg(dialog);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("close", closure, after);
  }

  /**
   * Emitted when an action widget is clicked.
   * The signal is also emitted when the dialog receives a
   * delete event, and when [gtk.dialog.Dialog.response] is called.
   * On a delete event, the response ID is %GTK_RESPONSE_DELETE_EVENT.
   * Otherwise, it depends on which action widget was clicked.
   * Params
   *   responseId = the response ID
   *   dialog = the instance the signal is connected to

   * Deprecated: Use [gtk.window.Window] instead
   */
  alias ResponseCallbackDlg = void delegate(int responseId, Dialog dialog);
  alias ResponseCallbackFunc = void function(int responseId, Dialog dialog);

  /**
   * Connect to Response signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectResponse(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ResponseCallbackDlg) || is(T : ResponseCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto dialog = getVal!Dialog(_paramVals);
      auto responseId = getVal!int(&_paramVals[1]);
      _dClosure.dlg(responseId, dialog);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("response", closure, after);
  }
}
