module gtk.grid_view;

import gid.global;
import gobject.dclosure;
import gobject.object;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.list_base;
import gtk.list_item_factory;
import gtk.orientable;
import gtk.orientable_mixin;
import gtk.scroll_info;
import gtk.scrollable;
import gtk.scrollable_mixin;
import gtk.selection_model;
import gtk.selection_model_mixin;
import gtk.types;

/**
 * `GtkGridView` presents a large dynamic grid of items.
 * `GtkGridView` uses its factory to generate one child widget for each
 * visible item and shows them in a grid. The orientation of the grid view
 * determines if the grid reflows vertically or horizontally.
 * `GtkGridView` allows the user to select items according to the selection
 * characteristics of the model. For models that allow multiple selected items,
 * it is possible to turn on _rubberband selection_, using
 * property@Gtk.GridView:enable-rubberband.
 * To learn more about the list widget framework, see the
 * [overview](section-list-widget.html).
 * # CSS nodes
 * ```
 * gridview
 * ├── child[.activatable]
 * │
 * ├── child[.activatable]
 * │
 * ┊
 * ╰── [rubberband]
 * ```
 * `GtkGridView` uses a single CSS node with name `gridview`. Each child uses
 * a single CSS node with name `child`. If the [gtk.list_item.ListItem.gboolean]
 * property is set, the corresponding row will have the `.activatable` style
 * class. For rubberband selection, a subnode with name `rubberband` is used.
 * # Accessibility
 * `GtkGridView` uses the %GTK_ACCESSIBLE_ROLE_GRID role, and the items
 * use the %GTK_ACCESSIBLE_ROLE_GRID_CELL role.
 */
class GridView : ListBase
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_grid_view_get_type != &gidSymbolNotFound ? gtk_grid_view_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkGridView` that uses the given factory for
   * mapping items to widgets.
   * The function takes ownership of the
   * arguments, so you can write code like
   * ```c
   * grid_view \= gtk_grid_view_new $(LPAREN)create_model $(LPAREN)$(RPAREN),
   * gtk_builder_list_item_factory_new_from_resource $(LPAREN)"/resource.ui"$(RPAREN)$(RPAREN);
   * ```
   * Params:
   *   model = the model to use
   *   factory = The factory to populate items with
   * Returns: a new `GtkGridView` using the given model and factory
   */
  this(SelectionModel model, ListItemFactory factory)
  {
    GtkWidget* _cretval;
    _cretval = gtk_grid_view_new(model ? cast(GtkSelectionModel*)(cast(ObjectG)model).cPtr(Yes.Dup) : null, factory ? cast(GtkListItemFactory*)factory.cPtr(Yes.Dup) : null);
    this(_cretval, No.Take);
  }

  /**
   * Returns whether rows can be selected by dragging with the mouse.
   * Returns: %TRUE if rubberband selection is enabled
   */
  bool getEnableRubberband()
  {
    bool _retval;
    _retval = gtk_grid_view_get_enable_rubberband(cast(GtkGridView*)cPtr);
    return _retval;
  }

  /**
   * Gets the factory that's currently used to populate list items.
   * Returns: The factory in use
   */
  ListItemFactory getFactory()
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_grid_view_get_factory(cast(GtkGridView*)cPtr);
    auto _retval = ObjectG.getDObject!ListItemFactory(cast(GtkListItemFactory*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the maximum number of columns that the grid will use.
   * Returns: The maximum number of columns
   */
  uint getMaxColumns()
  {
    uint _retval;
    _retval = gtk_grid_view_get_max_columns(cast(GtkGridView*)cPtr);
    return _retval;
  }

  /**
   * Gets the minimum number of columns that the grid will use.
   * Returns: The minimum number of columns
   */
  uint getMinColumns()
  {
    uint _retval;
    _retval = gtk_grid_view_get_min_columns(cast(GtkGridView*)cPtr);
    return _retval;
  }

  /**
   * Gets the model that's currently used to read the items displayed.
   * Returns: The model in use
   */
  SelectionModel getModel()
  {
    GtkSelectionModel* _cretval;
    _cretval = gtk_grid_view_get_model(cast(GtkGridView*)cPtr);
    auto _retval = ObjectG.getDObject!SelectionModel(cast(GtkSelectionModel*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns whether items will be activated on single click and
   * selected on hover.
   * Returns: %TRUE if items are activated on single click
   */
  bool getSingleClickActivate()
  {
    bool _retval;
    _retval = gtk_grid_view_get_single_click_activate(cast(GtkGridView*)cPtr);
    return _retval;
  }

  /**
   * Gets the behavior set for the <kbd>Tab</kbd> key.
   * Returns: The behavior of the <kbd>Tab</kbd> key
   */
  ListTabBehavior getTabBehavior()
  {
    GtkListTabBehavior _cretval;
    _cretval = gtk_grid_view_get_tab_behavior(cast(GtkGridView*)cPtr);
    ListTabBehavior _retval = cast(ListTabBehavior)_cretval;
    return _retval;
  }

  /**
   * Scrolls to the item at the given position and performs the actions
   * specified in flags.
   * This function works no matter if the gridview is shown or focused.
   * If it isn't, then the changes will take effect once that happens.
   * Params:
   *   pos = position of the item
   *   flags = actions to perform
   *   scroll = details of how to perform
   *     the scroll operation or %NULL to scroll into view
   */
  void scrollTo(uint pos, ListScrollFlags flags, ScrollInfo scroll)
  {
    gtk_grid_view_scroll_to(cast(GtkGridView*)cPtr, pos, flags, scroll ? cast(GtkScrollInfo*)scroll.cPtr(Yes.Dup) : null);
  }

  /**
   * Sets whether selections can be changed by dragging with the mouse.
   * Params:
   *   enableRubberband = %TRUE to enable rubberband selection
   */
  void setEnableRubberband(bool enableRubberband)
  {
    gtk_grid_view_set_enable_rubberband(cast(GtkGridView*)cPtr, enableRubberband);
  }

  /**
   * Sets the `GtkListItemFactory` to use for populating list items.
   * Params:
   *   factory = the factory to use
   */
  void setFactory(ListItemFactory factory)
  {
    gtk_grid_view_set_factory(cast(GtkGridView*)cPtr, factory ? cast(GtkListItemFactory*)factory.cPtr(No.Dup) : null);
  }

  /**
   * Sets the maximum number of columns to use.
   * This number must be at least 1.
   * If max_columns is smaller than the minimum set via
   * [gtk.grid_view.GridView.setMinColumns], that value is used instead.
   * Params:
   *   maxColumns = The maximum number of columns
   */
  void setMaxColumns(uint maxColumns)
  {
    gtk_grid_view_set_max_columns(cast(GtkGridView*)cPtr, maxColumns);
  }

  /**
   * Sets the minimum number of columns to use.
   * This number must be at least 1.
   * If min_columns is smaller than the minimum set via
   * [gtk.grid_view.GridView.setMaxColumns], that value is ignored.
   * Params:
   *   minColumns = The minimum number of columns
   */
  void setMinColumns(uint minColumns)
  {
    gtk_grid_view_set_min_columns(cast(GtkGridView*)cPtr, minColumns);
  }

  /**
   * Sets the model to use.
   * This must be a [gtk.selection_model.SelectionModel].
   * Params:
   *   model = the model to use
   */
  void setModel(SelectionModel model)
  {
    gtk_grid_view_set_model(cast(GtkGridView*)cPtr, model ? cast(GtkSelectionModel*)(cast(ObjectG)model).cPtr(No.Dup) : null);
  }

  /**
   * Sets whether items should be activated on single click and
   * selected on hover.
   * Params:
   *   singleClickActivate = %TRUE to activate items on single click
   */
  void setSingleClickActivate(bool singleClickActivate)
  {
    gtk_grid_view_set_single_click_activate(cast(GtkGridView*)cPtr, singleClickActivate);
  }

  /**
   * Sets the behavior of the <kbd>Tab</kbd> and <kbd>Shift</kbd>+<kbd>Tab</kbd> keys.
   * Params:
   *   tabBehavior = The desired tab behavior
   */
  void setTabBehavior(ListTabBehavior tabBehavior)
  {
    gtk_grid_view_set_tab_behavior(cast(GtkGridView*)cPtr, tabBehavior);
  }

  /**
   * Emitted when a cell has been activated by the user,
   * usually via activating the GtkGridView|list.activate-item action.
   * This allows for a convenient way to handle activation in a gridview.
   * See [gtk.list_item.ListItem.gboolean] for details on how to use
   * this signal.
   * Params
   *   position = position of item to activate
   *   gridView = the instance the signal is connected to
   */
  alias ActivateCallbackDlg = void delegate(uint position, GridView gridView);
  alias ActivateCallbackFunc = void function(uint position, GridView gridView);

  /**
   * Connect to Activate signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivate(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ActivateCallbackDlg) || is(T : ActivateCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto gridView = getVal!GridView(_paramVals);
      auto position = getVal!uint(&_paramVals[1]);
      _dClosure.dlg(position, gridView);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }
}
