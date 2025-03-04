module gtk.pad_controller;

import gdk.device;
import gid.global;
import gio.action_group;
import gio.action_group_mixin;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.event_controller;
import gtk.types;

/**
 * `GtkPadController` is an event controller for the pads found in drawing
 * tablets.
 * Pads are the collection of buttons and tactile sensors often found around
 * the stylus-sensitive area.
 * These buttons and sensors have no implicit meaning, and by default they
 * perform no action. `GtkPadController` is provided to map those to
 * [gio.action.Action] objects, thus letting the application give them a more
 * semantic meaning.
 * Buttons and sensors are not constrained to triggering a single action,
 * some %GDK_SOURCE_TABLET_PAD devices feature multiple "modes". All these
 * input elements have one current mode, which may determine the final action
 * being triggered.
 * Pad devices often divide buttons and sensors into groups. All elements
 * in a group share the same current mode, but different groups may have
 * different modes. See [gdk.device_pad.DevicePad.getNGroups] and
 * [gdk.device_pad.DevicePad.getGroupNModes].
 * Each of the actions that a given button/strip/ring performs for a given mode
 * is defined by a [gtk.pad_action_entry.PadActionEntry]. It contains an action name that
 * will be looked up in the given [gio.action_group.ActionGroup] and activated whenever
 * the specified input element and mode are triggered.
 * A simple example of `GtkPadController` usage: Assigning button 1 in all
 * modes and pad devices to an "invert-selection" action:
 * ```c
 * GtkPadActionEntry *pad_actions[] \= {
 * { GTK_PAD_ACTION_BUTTON, 1, -1, "Invert selection", "pad-actions.invert-selection" },
 * …
 * };
 * …
 * action_group \= g_simple_action_group_new $(LPAREN)$(RPAREN);
 * action \= g_simple_action_new $(LPAREN)"pad-actions.invert-selection", NULL$(RPAREN);
 * g_signal_connect $(LPAREN)action, "activate", on_invert_selection_activated, NULL$(RPAREN);
 * g_action_map_add_action $(LPAREN)G_ACTION_MAP $(LPAREN)action_group$(RPAREN), action$(RPAREN);
 * …
 * pad_controller \= gtk_pad_controller_new $(LPAREN)action_group, NULL$(RPAREN);
 * ```
 * The actions belonging to rings/strips will be activated with a parameter
 * of type %G_VARIANT_TYPE_DOUBLE bearing the value of the given axis, it
 * is required that those are made stateful and accepting this `GVariantType`.
 */
class PadController : EventController
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_pad_controller_get_type != &gidSymbolNotFound ? gtk_pad_controller_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkPadController` that will associate events from pad to
   * actions.
   * A %NULL pad may be provided so the controller manages all pad devices
   * generically, it is discouraged to mix `GtkPadController` objects with
   * %NULL and non-%NULL pad argument on the same toplevel window, as execution
   * order is not guaranteed.
   * The `GtkPadController` is created with no mapped actions. In order to
   * map pad events to actions, use [gtk.pad_controller.PadController.setActionEntries]
   * or [gtk.pad_controller.PadController.setAction].
   * Be aware that pad events will only be delivered to `GtkWindow`s, so adding
   * a pad controller to any other type of widget will not have an effect.
   * Params:
   *   group = `GActionGroup` to trigger actions from
   *   pad = A %GDK_SOURCE_TABLET_PAD device, or %NULL to handle all pads
   * Returns: A newly created `GtkPadController`
   */
  this(ActionGroup group, Device pad)
  {
    GtkPadController* _cretval;
    _cretval = gtk_pad_controller_new(group ? cast(GActionGroup*)(cast(ObjectG)group).cPtr(No.Dup) : null, pad ? cast(GdkDevice*)pad.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * Adds an individual action to controller.
   * This action will only be activated if the given button/ring/strip number
   * in index is interacted while the current mode is mode. -1 may be used
   * for simple cases, so the action is triggered on all modes.
   * The given label should be considered user-visible, so internationalization
   * rules apply. Some windowing systems may be able to use those for user
   * feedback.
   * Params:
   *   type = the type of pad feature that will trigger this action
   *   index = the 0-indexed button/ring/strip number that will trigger this action
   *   mode = the mode that will trigger this action, or -1 for all modes.
   *   label = Human readable description of this action, this string should
   *     be deemed user-visible.
   *   actionName = action name that will be activated in the `GActionGroup`
   */
  void setAction(PadActionType type, int index, int mode, string label, string actionName)
  {
    const(char)* _label = label.toCString(No.Alloc);
    const(char)* _actionName = actionName.toCString(No.Alloc);
    gtk_pad_controller_set_action(cast(GtkPadController*)cPtr, type, index, mode, _label, _actionName);
  }
}
