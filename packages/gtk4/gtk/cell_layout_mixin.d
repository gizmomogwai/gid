module gtk.cell_layout_mixin;

public import gtk.cell_layout_iface_proxy;
public import gid.global;
public import gobject.object;
public import gtk.c.functions;
public import gtk.c.types;
public import gtk.cell_area;
public import gtk.cell_renderer;
public import gtk.tree_iter;
public import gtk.tree_model;
public import gtk.tree_model_mixin;
public import gtk.types;

/**
 * An interface for packing cells
 * `GtkCellLayout` is an interface to be implemented by all objects which
 * want to provide a `GtkTreeViewColumn` like API for packing cells,
 * setting attributes and data funcs.
 * One of the notable features provided by implementations of
 * `GtkCellLayout` are attributes. Attributes let you set the properties
 * in flexible ways. They can just be set to constant values like regular
 * properties. But they can also be mapped to a column of the underlying
 * tree model with [gtk.cell_layout.CellLayout.setAttributes], which means that the value
 * of the attribute can change from cell to cell as they are rendered by
 * the cell renderer. Finally, it is possible to specify a function with
 * [gtk.cell_layout.CellLayout.setCellDataFunc] that is called to determine the
 * value of the attribute for each cell that is rendered.
 * ## GtkCellLayouts as GtkBuildable
 * Implementations of GtkCellLayout which also implement the GtkBuildable
 * interface $(LPAREN)`GtkCellView`, `GtkIconView`, `GtkComboBox`,
 * `GtkEntryCompletion`, `GtkTreeViewColumn`$(RPAREN) accept `GtkCellRenderer` objects
 * as `<child>` elements in UI definitions. They support a custom `<attributes>`
 * element for their children, which can contain multiple `<attribute>`
 * elements. Each `<attribute>` element has a name attribute which specifies
 * a property of the cell renderer; the content of the element is the
 * attribute value.
 * This is an example of a UI definition fragment specifying attributes:
 * ```xml
 * <object class\="GtkCellView">
 * <child>
 * <object class\="GtkCellRendererText"/>
 * <attributes>
 * <attribute name\="text">0</attribute>
 * </attributes>
 * </child>
 * </object>
 * ```
 * Furthermore for implementations of `GtkCellLayout` that use a `GtkCellArea`
 * to lay out cells $(LPAREN)all `GtkCellLayout`s in GTK use a `GtkCellArea`$(RPAREN)
 * [cell properties](class.CellArea.html#cell-properties) can also be defined
 * in the format by specifying the custom `<cell-packing>` attribute which can
 * contain multiple `<property>` elements.
 * Here is a UI definition fragment specifying cell properties:
 * ```xml
 * <object class\="GtkTreeViewColumn">
 * <child>
 * <object class\="GtkCellRendererText"/>
 * <cell-packing>
 * <property name\="align">True</property>
 * <property name\="expand">False</property>
 * </cell-packing>
 * </child>
 * </object>
 * ```
 * ## Subclassing GtkCellLayout implementations
 * When subclassing a widget that implements `GtkCellLayout` like
 * `GtkIconView` or `GtkComboBox`, there are some considerations related
 * to the fact that these widgets internally use a `GtkCellArea`.
 * The cell area is exposed as a construct-only property by these
 * widgets. This means that it is possible to e.g. do
 * ```c
 * GtkWIdget *combo \=
 * g_object_new $(LPAREN)GTK_TYPE_COMBO_BOX, "cell-area", my_cell_area, NULL$(RPAREN);
 * ```
 * to use a custom cell area with a combo box. But construct properties
 * are only initialized after instance `init$(LPAREN)$(RPAREN)`
 * functions have run, which means that using functions which rely on
 * the existence of the cell area in your subclass `init$(LPAREN)$(RPAREN)` function will
 * cause the default cell area to be instantiated. In this case, a provided
 * construct property value will be ignored $(LPAREN)with a warning, to alert
 * you to the problem$(RPAREN).
 * ```c
 * static void
 * my_combo_box_init $(LPAREN)MyComboBox *b$(RPAREN)
 * {
 * GtkCellRenderer *cell;
 * cell \= gtk_cell_renderer_pixbuf_new $(LPAREN)$(RPAREN);
 * // The following call causes the default cell area for combo boxes,
 * // a GtkCellAreaBox, to be instantiated
 * gtk_cell_layout_pack_start $(LPAREN)GTK_CELL_LAYOUT $(LPAREN)b$(RPAREN), cell, FALSE$(RPAREN);
 * ...
 * }
 * GtkWidget *
 * my_combo_box_new $(LPAREN)GtkCellArea *area$(RPAREN)
 * {
 * // This call is going to cause a warning about area being ignored
 * return g_object_new $(LPAREN)MY_TYPE_COMBO_BOX, "cell-area", area, NULL$(RPAREN);
 * }
 * ```
 * If supporting alternative cell areas with your derived widget is
 * not important, then this does not have to concern you. If you want
 * to support alternative cell areas, you can do so by moving the
 * problematic calls out of `init$(LPAREN)$(RPAREN)` and into a `constructor$(LPAREN)$(RPAREN)`
 * for your class.

 * Deprecated: List views use widgets to display their contents.
 *   See [gtk.layout_manager.LayoutManager] for layout manager delegate objects
 */
template CellLayoutT()
{

  /**
   * Adds an attribute mapping to the list in cell_layout.
   * The column is the column of the model to get a value from, and the
   * attribute is the property on cell to be set from that value. So for
   * example if column 2 of the model contains strings, you could have the
   * “text” attribute of a `GtkCellRendererText` get its values from column 2.
   * In this context "attribute" and "property" are used interchangeably.
   * Params:
   *   cell = a `GtkCellRenderer`
   *   attribute = a property on the renderer
   *   column = the column position on the model to get the attribute from
   */
  override void addAttribute(CellRenderer cell, string attribute, int column)
  {
    const(char)* _attribute = attribute.toCString(No.Alloc);
    gtk_cell_layout_add_attribute(cast(GtkCellLayout*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(No.Dup) : null, _attribute, column);
  }

  /**
   * Unsets all the mappings on all renderers on cell_layout and
   * removes all renderers from cell_layout.
   */
  override void clear()
  {
    gtk_cell_layout_clear(cast(GtkCellLayout*)cPtr);
  }

  /**
   * Clears all existing attributes previously set with
   * [gtk.cell_layout.CellLayout.setAttributes].
   * Params:
   *   cell = a `GtkCellRenderer` to clear the attribute mapping on
   */
  override void clearAttributes(CellRenderer cell)
  {
    gtk_cell_layout_clear_attributes(cast(GtkCellLayout*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(No.Dup) : null);
  }

  /**
   * Returns the underlying `GtkCellArea` which might be cell_layout
   * if called on a `GtkCellArea` or might be %NULL if no `GtkCellArea`
   * is used by cell_layout.
   * Returns: the cell area used by cell_layout
   */
  override CellArea getArea()
  {
    GtkCellArea* _cretval;
    _cretval = gtk_cell_layout_get_area(cast(GtkCellLayout*)cPtr);
    auto _retval = ObjectG.getDObject!CellArea(cast(GtkCellArea*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns the cell renderers which have been added to cell_layout.
   * Returns: a list of cell renderers. The list, but not the renderers has
   *   been newly allocated and should be freed with [glib.list.List.free]
   *   when no longer needed.
   */
  override CellRenderer[] getCells()
  {
    GList* _cretval;
    _cretval = gtk_cell_layout_get_cells(cast(GtkCellLayout*)cPtr);
    auto _retval = gListToD!(CellRenderer, GidOwnership.Container)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Adds the cell to the end of cell_layout. If expand is %FALSE, then the
   * cell is allocated no more space than it needs. Any unused space is
   * divided evenly between cells for which expand is %TRUE.
   * Note that reusing the same cell renderer is not supported.
   * Params:
   *   cell = a `GtkCellRenderer`
   *   expand = %TRUE if cell is to be given extra space allocated to cell_layout
   */
  override void packEnd(CellRenderer cell, bool expand)
  {
    gtk_cell_layout_pack_end(cast(GtkCellLayout*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(No.Dup) : null, expand);
  }

  /**
   * Packs the cell into the beginning of cell_layout. If expand is %FALSE,
   * then the cell is allocated no more space than it needs. Any unused space
   * is divided evenly between cells for which expand is %TRUE.
   * Note that reusing the same cell renderer is not supported.
   * Params:
   *   cell = a `GtkCellRenderer`
   *   expand = %TRUE if cell is to be given extra space allocated to cell_layout
   */
  override void packStart(CellRenderer cell, bool expand)
  {
    gtk_cell_layout_pack_start(cast(GtkCellLayout*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(No.Dup) : null, expand);
  }

  /**
   * Re-inserts cell at position.
   * Note that cell has already to be packed into cell_layout
   * for this to function properly.
   * Params:
   *   cell = a `GtkCellRenderer` to reorder
   *   position = new position to insert cell at
   */
  override void reorder(CellRenderer cell, int position)
  {
    gtk_cell_layout_reorder(cast(GtkCellLayout*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(No.Dup) : null, position);
  }

  /**
   * Sets the `GtkCellLayout`DataFunc to use for cell_layout.
   * This function is used instead of the standard attributes mapping
   * for setting the column value, and should set the value of cell_layout’s
   * cell renderer$(LPAREN)s$(RPAREN) as appropriate.
   * func may be %NULL to remove a previously set function.
   * Params:
   *   cell = a `GtkCellRenderer`
   *   func = the `GtkCellLayout`DataFunc to use
   */
  override void setCellDataFunc(CellRenderer cell, CellLayoutDataFunc func)
  {
    extern(C) void _funcCallback(GtkCellLayout* cellLayout, GtkCellRenderer* cell, GtkTreeModel* treeModel, GtkTreeIter* iter, void* data)
    {
      auto _dlg = cast(CellLayoutDataFunc*)data;

      (*_dlg)(ObjectG.getDObject!CellLayout(cast(void*)cellLayout, No.Take), ObjectG.getDObject!CellRenderer(cast(void*)cell, No.Take), ObjectG.getDObject!TreeModel(cast(void*)treeModel, No.Take), iter ? new TreeIter(cast(void*)iter, No.Take) : null);
    }
    auto _funcCB = func ? &_funcCallback : null;

    auto _func = func ? freezeDelegate(cast(void*)&func) : null;
    GDestroyNotify _funcDestroyCB = func ? &thawDelegate : null;
    gtk_cell_layout_set_cell_data_func(cast(GtkCellLayout*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(No.Dup) : null, _funcCB, _func, _funcDestroyCB);
  }
}
