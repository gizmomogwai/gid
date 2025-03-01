module gtk.grid_layout;

import gid.global;
import gtk.c.functions;
import gtk.c.types;
import gtk.layout_manager;
import gtk.types;

/**
 * `GtkGridLayout` is a layout manager which arranges child widgets in
 * rows and columns.
 * Children have an "attach point" defined by the horizontal and vertical
 * index of the cell they occupy; children can span multiple rows or columns.
 * The layout properties for setting the attach points and spans are set
 * using the [gtk.grid_layout_child.GridLayoutChild] associated to each child widget.
 * The behaviour of `GtkGridLayout` when several children occupy the same
 * grid cell is undefined.
 * `GtkGridLayout` can be used like a `GtkBoxLayout` if all children are
 * attached to the same row or column; however, if you only ever need a
 * single row or column, you should consider using `GtkBoxLayout`.
 */
class GridLayout : LayoutManager
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_grid_layout_get_type != &gidSymbolNotFound ? gtk_grid_layout_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkGridLayout`.
   * Returns: the newly created `GtkGridLayout`
   */
  this()
  {
    GtkLayoutManager* _cretval;
    _cretval = gtk_grid_layout_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Retrieves the row set with [gtk.grid_layout.GridLayout.setBaselineRow].
   * Returns: the global baseline row
   */
  int getBaselineRow()
  {
    int _retval;
    _retval = gtk_grid_layout_get_baseline_row(cast(GtkGridLayout*)cPtr);
    return _retval;
  }

  /**
   * Checks whether all columns of grid should have the same width.
   * Returns: %TRUE if the columns are homogeneous, and %FALSE otherwise
   */
  bool getColumnHomogeneous()
  {
    bool _retval;
    _retval = gtk_grid_layout_get_column_homogeneous(cast(GtkGridLayout*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the spacing set with [gtk.grid_layout.GridLayout.setColumnSpacing].
   * Returns: the spacing between consecutive columns
   */
  uint getColumnSpacing()
  {
    uint _retval;
    _retval = gtk_grid_layout_get_column_spacing(cast(GtkGridLayout*)cPtr);
    return _retval;
  }

  /**
   * Returns the baseline position of row.
   * If no value has been set with
   * [gtk.grid_layout.GridLayout.setRowBaselinePosition],
   * the default value of %GTK_BASELINE_POSITION_CENTER
   * is returned.
   * Params:
   *   row = a row index
   * Returns: the baseline position of row
   */
  BaselinePosition getRowBaselinePosition(int row)
  {
    GtkBaselinePosition _cretval;
    _cretval = gtk_grid_layout_get_row_baseline_position(cast(GtkGridLayout*)cPtr, row);
    BaselinePosition _retval = cast(BaselinePosition)_cretval;
    return _retval;
  }

  /**
   * Checks whether all rows of grid should have the same height.
   * Returns: %TRUE if the rows are homogeneous, and %FALSE otherwise
   */
  bool getRowHomogeneous()
  {
    bool _retval;
    _retval = gtk_grid_layout_get_row_homogeneous(cast(GtkGridLayout*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the spacing set with [gtk.grid_layout.GridLayout.setRowSpacing].
   * Returns: the spacing between consecutive rows
   */
  uint getRowSpacing()
  {
    uint _retval;
    _retval = gtk_grid_layout_get_row_spacing(cast(GtkGridLayout*)cPtr);
    return _retval;
  }

  /**
   * Sets which row defines the global baseline for the entire grid.
   * Each row in the grid can have its own local baseline, but only
   * one of those is global, meaning it will be the baseline in the
   * parent of the grid.
   * Params:
   *   row = the row index
   */
  void setBaselineRow(int row)
  {
    gtk_grid_layout_set_baseline_row(cast(GtkGridLayout*)cPtr, row);
  }

  /**
   * Sets whether all columns of grid should have the same width.
   * Params:
   *   homogeneous = %TRUE to make columns homogeneous
   */
  void setColumnHomogeneous(bool homogeneous)
  {
    gtk_grid_layout_set_column_homogeneous(cast(GtkGridLayout*)cPtr, homogeneous);
  }

  /**
   * Sets the amount of space to insert between consecutive columns.
   * Params:
   *   spacing = the amount of space between columns, in pixels
   */
  void setColumnSpacing(uint spacing)
  {
    gtk_grid_layout_set_column_spacing(cast(GtkGridLayout*)cPtr, spacing);
  }

  /**
   * Sets how the baseline should be positioned on row of the
   * grid, in case that row is assigned more space than is requested.
   * Params:
   *   row = a row index
   *   pos = a `GtkBaselinePosition`
   */
  void setRowBaselinePosition(int row, BaselinePosition pos)
  {
    gtk_grid_layout_set_row_baseline_position(cast(GtkGridLayout*)cPtr, row, pos);
  }

  /**
   * Sets whether all rows of grid should have the same height.
   * Params:
   *   homogeneous = %TRUE to make rows homogeneous
   */
  void setRowHomogeneous(bool homogeneous)
  {
    gtk_grid_layout_set_row_homogeneous(cast(GtkGridLayout*)cPtr, homogeneous);
  }

  /**
   * Sets the amount of space to insert between consecutive rows.
   * Params:
   *   spacing = the amount of space between rows, in pixels
   */
  void setRowSpacing(uint spacing)
  {
    gtk_grid_layout_set_row_spacing(cast(GtkGridLayout*)cPtr, spacing);
  }
}
