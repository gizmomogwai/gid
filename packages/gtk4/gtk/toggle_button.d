module gtk.toggle_button;

import gid.global;
import gobject.dclosure;
import gobject.object;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.actionable;
import gtk.actionable_mixin;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.button;
import gtk.c.functions;
import gtk.c.types;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.types;

/**
 * A `GtkToggleButton` is a button which remains “pressed-in” when
 * clicked.
 * Clicking again will cause the toggle button to return to its normal state.
 * A toggle button is created by calling either [gtk.toggle_button.ToggleButton.new_] or
 * [gtk.toggle_button.ToggleButton.newWithLabel]. If using the former, it is advisable
 * to pack a widget, $(LPAREN)such as a `GtkLabel` and/or a `GtkImage`$(RPAREN), into the toggle
 * button’s container. $(LPAREN)See [gtk.button.Button] for more information$(RPAREN).
 * The state of a `GtkToggleButton` can be set specifically using
 * [gtk.toggle_button.ToggleButton.setActive], and retrieved using
 * [gtk.toggle_button.ToggleButton.getActive].
 * To simply switch the state of a toggle button, use
 * [gtk.toggle_button.ToggleButton.toggled].
 * ## Grouping
 * Toggle buttons can be grouped together, to form mutually exclusive
 * groups - only one of the buttons can be toggled at a time, and toggling
 * another one will switch the currently toggled one off.
 * To add a `GtkToggleButton` to a group, use [gtk.toggle_button.ToggleButton.setGroup].
 * ## CSS nodes
 * `GtkToggleButton` has a single CSS node with name button. To differentiate
 * it from a plain `GtkButton`, it gets the `.toggle` style class.
 * ## Accessibility
 * `GtkToggleButton` uses the %GTK_ACCESSIBLE_ROLE_TOGGLE_BUTTON role.
 * ## Creating two `GtkToggleButton` widgets.
 * ```c
 * static void
 * output_state $(LPAREN)GtkToggleButton *source,
 * gpointer         user_data$(RPAREN)
 * {
 * g_print $(LPAREN)"Toggle button "%s" is active: %s",
 * gtk_button_get_label $(LPAREN)GTK_BUTTON $(LPAREN)source$(RPAREN)$(RPAREN),
 * gtk_toggle_button_get_active $(LPAREN)source$(RPAREN) ? "Yes" : "No"$(RPAREN);
 * }
 * static void
 * make_toggles $(LPAREN)void$(RPAREN)
 * {
 * GtkWidget *window, *toggle1, *toggle2;
 * GtkWidget *box;
 * const char *text;
 * window \= gtk_window_new $(LPAREN)$(RPAREN);
 * box \= gtk_box_new $(LPAREN)GTK_ORIENTATION_VERTICAL, 12$(RPAREN);
 * text \= "Hi, I’m toggle button one";
 * toggle1 \= gtk_toggle_button_new_with_label $(LPAREN)text$(RPAREN);
 * g_signal_connect $(LPAREN)toggle1, "toggled",
 * G_CALLBACK $(LPAREN)output_state$(RPAREN),
 * NULL$(RPAREN);
 * gtk_box_append $(LPAREN)GTK_BOX $(LPAREN)box$(RPAREN), toggle1$(RPAREN);
 * text \= "Hi, I’m toggle button two";
 * toggle2 \= gtk_toggle_button_new_with_label $(LPAREN)text$(RPAREN);
 * g_signal_connect $(LPAREN)toggle2, "toggled",
 * G_CALLBACK $(LPAREN)output_state$(RPAREN),
 * NULL$(RPAREN);
 * gtk_box_append $(LPAREN)GTK_BOX $(LPAREN)box$(RPAREN), toggle2$(RPAREN);
 * gtk_window_set_child $(LPAREN)GTK_WINDOW $(LPAREN)window$(RPAREN), box$(RPAREN);
 * gtk_window_present $(LPAREN)GTK_WINDOW $(LPAREN)window$(RPAREN)$(RPAREN);
 * }
 * ```
 */
class ToggleButton : Button
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_toggle_button_get_type != &gidSymbolNotFound ? gtk_toggle_button_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new toggle button.
   * A widget should be packed into the button, as in [gtk.button.Button.new_].
   * Returns: a new toggle button.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_toggle_button_new();
    this(_cretval, No.Take);
  }

  /**
   * Creates a new toggle button with a text label.
   * Params:
   *   label = a string containing the message to be placed in the toggle button.
   * Returns: a new toggle button.
   */
  static ToggleButton newWithLabel(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(No.Alloc);
    _cretval = gtk_toggle_button_new_with_label(_label);
    auto _retval = ObjectG.getDObject!ToggleButton(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Creates a new `GtkToggleButton` containing a label.
   * The label will be created using [gtk.label.Label.newWithMnemonic],
   * so underscores in label indicate the mnemonic for the button.
   * Params:
   *   label = the text of the button, with an underscore in front of the
   *     mnemonic character
   * Returns: a new `GtkToggleButton`
   */
  static ToggleButton newWithMnemonic(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(No.Alloc);
    _cretval = gtk_toggle_button_new_with_mnemonic(_label);
    auto _retval = ObjectG.getDObject!ToggleButton(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Queries a `GtkToggleButton` and returns its current state.
   * Returns %TRUE if the toggle button is pressed in and %FALSE
   * if it is raised.
   * Returns: whether the button is pressed
   */
  bool getActive()
  {
    bool _retval;
    _retval = gtk_toggle_button_get_active(cast(GtkToggleButton*)cPtr);
    return _retval;
  }

  /**
   * Sets the status of the toggle button.
   * Set to %TRUE if you want the `GtkToggleButton` to be “pressed in”,
   * and %FALSE to raise it.
   * If the status of the button changes, this action causes the
   * [gtk.toggle_button.ToggleButton.toggled] signal to be emitted.
   * Params:
   *   isActive = %TRUE or %FALSE.
   */
  void setActive(bool isActive)
  {
    gtk_toggle_button_set_active(cast(GtkToggleButton*)cPtr, isActive);
  }

  /**
   * Adds self to the group of group.
   * In a group of multiple toggle buttons, only one button can be active
   * at a time.
   * Setting up groups in a cycle leads to undefined behavior.
   * Note that the same effect can be achieved via the [gtk.actionable.Actionable]
   * API, by using the same action with parameter type and state type 's'
   * for all buttons in the group, and giving each button its own target
   * value.
   * Params:
   *   group = another `GtkToggleButton` to
   *     form a group with
   */
  void setGroup(ToggleButton group)
  {
    gtk_toggle_button_set_group(cast(GtkToggleButton*)cPtr, group ? cast(GtkToggleButton*)group.cPtr(No.Dup) : null);
  }

  /**
   * Emits the ::toggled signal on the `GtkToggleButton`.

   * Deprecated: There is no good reason for an application ever to call this function.
   */
  void toggled()
  {
    gtk_toggle_button_toggled(cast(GtkToggleButton*)cPtr);
  }

  /**
   * Emitted whenever the `GtkToggleButton`'s state is changed.
   *   toggleButton = the instance the signal is connected to
   */
  alias ToggledCallbackDlg = void delegate(ToggleButton toggleButton);
  alias ToggledCallbackFunc = void function(ToggleButton toggleButton);

  /**
   * Connect to Toggled signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToggled(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ToggledCallbackDlg) || is(T : ToggledCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto toggleButton = getVal!ToggleButton(_paramVals);
      _dClosure.dlg(toggleButton);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("toggled", closure, after);
  }
}
