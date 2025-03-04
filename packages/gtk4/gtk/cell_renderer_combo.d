module gtk.cell_renderer_combo;

import gid.global;
import gobject.dclosure;
import gtk.c.functions;
import gtk.c.types;
import gtk.cell_renderer_text;
import gtk.tree_iter;
import gtk.types;

/**
 * Renders a combobox in a cell
 * `GtkCellRendererCombo` renders text in a cell like `GtkCellRendererText` from
 * which it is derived. But while `GtkCellRendererText` offers a simple entry to
 * edit the text, `GtkCellRendererCombo` offers a `GtkComboBox`
 * widget to edit the text. The values to display in the combo box are taken from
 * the tree model specified in the `GtkCellRendererCombo`:model property.
 * The combo cell renderer takes care of adding a text cell renderer to the combo
 * box and sets it to display the column specified by its
 * `GtkCellRendererCombo`:text-column property. Further properties of the combo box
 * can be set in a handler for the `GtkCellRenderer::editing-started` signal.

 * Deprecated: List views use widgets to display their contents. You
 *   should use [gtk.drop_down.DropDown] instead
 */
class CellRendererCombo : CellRendererText
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_cell_renderer_combo_get_type != &gidSymbolNotFound ? gtk_cell_renderer_combo_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkCellRendererCombo`.
   * Adjust how text is drawn using object properties.
   * Object properties can be set globally $(LPAREN)with [gobject.object.ObjectG.set]$(RPAREN).
   * Also, with `GtkTreeViewColumn`, you can bind a property to a value
   * in a `GtkTreeModel`. For example, you can bind the “text” property
   * on the cell renderer to a string value in the model, thus rendering
   * a different string in each row of the `GtkTreeView`.
   * Returns: the new cell renderer
   */
  this()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_renderer_combo_new();
    this(_cretval, No.Take);
  }

  /**
   * This signal is emitted each time after the user selected an item in
   * the combo box, either by using the mouse or the arrow keys.  Contrary
   * to GtkComboBox, GtkCellRendererCombo::changed is not emitted for
   * changes made to a selected item in the entry.  The argument new_iter
   * corresponds to the newly selected item in the combo box and it is relative
   * to the GtkTreeModel set via the model property on GtkCellRendererCombo.
   * Note that as soon as you change the model displayed in the tree view,
   * the tree view will immediately cease the editing operating.  This
   * means that you most probably want to refrain from changing the model
   * until the combo cell renderer emits the edited or editing_canceled signal.
   * Params
   *   pathString = a string of the path identifying the edited cell
   *     $(LPAREN)relative to the tree view model$(RPAREN)
   *   newIter = the new iter selected in the combo box
   *     $(LPAREN)relative to the combo box model$(RPAREN)
   *   cellRendererCombo = the instance the signal is connected to
   */
  alias ChangedCallbackDlg = void delegate(string pathString, TreeIter newIter, CellRendererCombo cellRendererCombo);
  alias ChangedCallbackFunc = void function(string pathString, TreeIter newIter, CellRendererCombo cellRendererCombo);

  /**
   * Connect to Changed signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ChangedCallbackDlg) || is(T : ChangedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto cellRendererCombo = getVal!CellRendererCombo(_paramVals);
      auto pathString = getVal!string(&_paramVals[1]);
      auto newIter = getVal!TreeIter(&_paramVals[2]);
      _dClosure.dlg(pathString, newIter, cellRendererCombo);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }
}
