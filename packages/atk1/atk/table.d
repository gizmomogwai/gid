module atk.table;

public import atk.table_iface_proxy;
import atk.c.functions;
import atk.c.types;
import atk.object;
import atk.types;
import gid.global;
import gobject.dclosure;
import gobject.object;

/**
 * The ATK interface implemented for UI components which contain tabular or row/column information.
 * #AtkTable should be implemented by components which present
 * elements ordered via rows and columns.  It may also be used to
 * present tree-structured information if the nodes of the trees can
 * be said to contain multiple "columns".  Individual elements of an
 * #AtkTable are typically referred to as "cells". Those cells should
 * implement the interface #AtkTableCell, but #Atk doesn't require
 * them to be direct children of the current #AtkTable. They can be
 * grand-children, grand-grand-children etc. #AtkTable provides the
 * API needed to get a individual cell based on the row and column
 * numbers.
 * Children of #AtkTable are frequently "lightweight" objects, that
 * is, they may not have backing widgets in the host UI toolkit.  They
 * are therefore often transient.
 * Since tables are often very complex, #AtkTable includes provision
 * for offering simplified summary information, as well as row and
 * column headers and captions.  Headers and captions are #AtkObjects
 * which may implement other interfaces $(LPAREN)#AtkText, #AtkImage, etc.$(RPAREN) as
 * appropriate.  #AtkTable summaries may themselves be $(LPAREN)simplified$(RPAREN)
 * #AtkTables, etc.
 * Note for implementors: in the past, #AtkTable required that all the
 * cells should be direct children of #AtkTable, and provided some
 * index based methods to request the cells. The practice showed that
 * that forcing made #AtkTable implementation complex, and hard to
 * expose other kind of children, like rows or captions. Right now,
 * index-based methods are deprecated.
 */
interface Table
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())atk_table_get_type != &gidSymbolNotFound ? atk_table_get_type() : cast(GType)0;
  }

  /**
   * Adds the specified column to the selection.
   * Params:
   *   column = a #gint representing a column in table
   * Returns: a gboolean representing if the column was successfully added to
   *   the selection, or 0 if value does not implement this interface.
   */
  bool addColumnSelection(int column);

  /**
   * Adds the specified row to the selection.
   * Params:
   *   row = a #gint representing a row in table
   * Returns: a gboolean representing if row was successfully added to selection,
   *   or 0 if value does not implement this interface.
   */
  bool addRowSelection(int row);

  /**
   * Gets the caption for the table.
   * Returns: a AtkObject* representing the
   *   table caption, or %NULL if value does not implement this interface.
   */
  ObjectAtk getCaption();

  /**
   * Gets a #gint representing the column at the specified index_.
   * Params:
   *   index = a #gint representing an index in table
   * Returns: a gint representing the column at the specified index,
   *   or -1 if the table does not implement this method.

   * Deprecated: Since 2.12.
   */
  int getColumnAtIndex(int index);

  /**
   * Gets the description text of the specified column in the table
   * Params:
   *   column = a #gint representing a column in table
   * Returns: a gchar* representing the column description, or %NULL
   *   if value does not implement this interface.
   */
  string getColumnDescription(int column);

  /**
   * Gets the number of columns occupied by the accessible object
   * at the specified row and column in the table.
   * Params:
   *   row = a #gint representing a row in table
   *   column = a #gint representing a column in table
   * Returns: a gint representing the column extent at specified position, or 0
   *   if value does not implement this interface.
   */
  int getColumnExtentAt(int row, int column);

  /**
   * Gets the column header of a specified column in an accessible table.
   * Params:
   *   column = a #gint representing a column in the table
   * Returns: a AtkObject* representing the
   *   specified column header, or %NULL if value does not implement this
   *   interface.
   */
  ObjectAtk getColumnHeader(int column);

  /**
   * Gets a #gint representing the index at the specified row and
   * column.
   * Params:
   *   row = a #gint representing a row in table
   *   column = a #gint representing a column in table
   * Returns: a #gint representing the index at specified position.
   *   The value -1 is returned if the object at row,column is not a child
   *   of table or table does not implement this interface.

   * Deprecated: Since 2.12. Use [atk.table.Table.refAt] in order to get the
   *   accessible that represents the cell at $(LPAREN)row, column$(RPAREN)
   */
  int getIndexAt(int row, int column);

  /**
   * Gets the number of columns in the table.
   * Returns: a gint representing the number of columns, or 0
   *   if value does not implement this interface.
   */
  int getNColumns();

  /**
   * Gets the number of rows in the table.
   * Returns: a gint representing the number of rows, or 0
   *   if value does not implement this interface.
   */
  int getNRows();

  /**
   * Gets a #gint representing the row at the specified index_.
   * Params:
   *   index = a #gint representing an index in table
   * Returns: a gint representing the row at the specified index,
   *   or -1 if the table does not implement this method.

   * Deprecated: since 2.12.
   */
  int getRowAtIndex(int index);

  /**
   * Gets the description text of the specified row in the table
   * Params:
   *   row = a #gint representing a row in table
   * Returns: a gchar* representing the row description, or
   *   %NULL if value does not implement this interface.
   */
  string getRowDescription(int row);

  /**
   * Gets the number of rows occupied by the accessible object
   * at a specified row and column in the table.
   * Params:
   *   row = a #gint representing a row in table
   *   column = a #gint representing a column in table
   * Returns: a gint representing the row extent at specified position, or 0
   *   if value does not implement this interface.
   */
  int getRowExtentAt(int row, int column);

  /**
   * Gets the row header of a specified row in an accessible table.
   * Params:
   *   row = a #gint representing a row in the table
   * Returns: a AtkObject* representing the
   *   specified row header, or %NULL if value does not implement this
   *   interface.
   */
  ObjectAtk getRowHeader(int row);

  /**
   * Gets the selected columns of the table by initializing **selected with
   * the selected column numbers. This array should be freed by the caller.
   * Params:
   *   selected = a #gint** that is to contain the selected columns numbers
   */
  void getSelectedColumns(out int[] selected);

  /**
   * Gets the selected rows of the table by initializing **selected with
   * the selected row numbers. This array should be freed by the caller.
   * Params:
   *   selected = a #gint** that is to contain the selected row numbers
   */
  void getSelectedRows(out int[] selected);

  /**
   * Gets the summary description of the table.
   * Returns: a AtkObject* representing a summary description
   *   of the table, or zero if value does not implement this interface.
   */
  ObjectAtk getSummary();

  /**
   * Gets a boolean value indicating whether the specified column
   * is selected
   * Params:
   *   column = a #gint representing a column in table
   * Returns: a gboolean representing if the column is selected, or 0
   *   if value does not implement this interface.
   */
  bool isColumnSelected(int column);

  /**
   * Gets a boolean value indicating whether the specified row
   * is selected
   * Params:
   *   row = a #gint representing a row in table
   * Returns: a gboolean representing if the row is selected, or 0
   *   if value does not implement this interface.
   */
  bool isRowSelected(int row);

  /**
   * Gets a boolean value indicating whether the accessible object
   * at the specified row and column is selected
   * Params:
   *   row = a #gint representing a row in table
   *   column = a #gint representing a column in table
   * Returns: a gboolean representing if the cell is selected, or 0
   *   if value does not implement this interface.
   */
  bool isSelected(int row, int column);

  /**
   * Get a reference to the table cell at row, column. This cell
   * should implement the interface #AtkTableCell
   * Params:
   *   row = a #gint representing a row in table
   *   column = a #gint representing a column in table
   * Returns: an #AtkObject representing the referred
   *   to accessible
   */
  ObjectAtk refAt(int row, int column);

  /**
   * Adds the specified column to the selection.
   * Params:
   *   column = a #gint representing a column in table
   * Returns: a gboolean representing if the column was successfully removed from
   *   the selection, or 0 if value does not implement this interface.
   */
  bool removeColumnSelection(int column);

  /**
   * Removes the specified row from the selection.
   * Params:
   *   row = a #gint representing a row in table
   * Returns: a gboolean representing if the row was successfully removed from
   *   the selection, or 0 if value does not implement this interface.
   */
  bool removeRowSelection(int row);

  /**
   * Sets the caption for the table.
   * Params:
   *   caption = a #AtkObject representing the caption to set for table
   */
  void setCaption(ObjectAtk caption);

  /**
   * Sets the description text for the specified column of the table.
   * Params:
   *   column = a #gint representing a column in table
   *   description = a #gchar representing the description text
   *     to set for the specified column of the table
   */
  void setColumnDescription(int column, string description);

  /**
   * Sets the specified column header to header.
   * Params:
   *   column = a #gint representing a column in table
   *   header = an #AtkTable
   */
  void setColumnHeader(int column, ObjectAtk header);

  /**
   * Sets the description text for the specified row of table.
   * Params:
   *   row = a #gint representing a row in table
   *   description = a #gchar representing the description text
   *     to set for the specified row of table
   */
  void setRowDescription(int row, string description);

  /**
   * Sets the specified row header to header.
   * Params:
   *   row = a #gint representing a row in table
   *   header = an #AtkTable
   */
  void setRowHeader(int row, ObjectAtk header);

  /**
   * Sets the summary description of the table.
   * Params:
   *   accessible = an #AtkObject representing the summary description
   *     to set for table
   */
  void setSummary(ObjectAtk accessible);

  /**
   * The "column-deleted" signal is emitted by an object which
   * implements the AtkTable interface when a column is deleted.
   * Params
   *   arg1 = The index of the first column deleted.
   *   arg2 = The number of columns deleted.
   *   table = the instance the signal is connected to
   */
  alias ColumnDeletedCallbackDlg = void delegate(int arg1, int arg2, Table table);
  alias ColumnDeletedCallbackFunc = void function(int arg1, int arg2, Table table);

  /**
   * Connect to ColumnDeleted signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectColumnDeleted(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ColumnDeletedCallbackDlg) || is(T : ColumnDeletedCallbackFunc));

  /**
   * The "column-inserted" signal is emitted by an object which
   * implements the AtkTable interface when a column is inserted.
   * Params
   *   arg1 = The index of the column inserted.
   *   arg2 = The number of colums inserted.
   *   table = the instance the signal is connected to
   */
  alias ColumnInsertedCallbackDlg = void delegate(int arg1, int arg2, Table table);
  alias ColumnInsertedCallbackFunc = void function(int arg1, int arg2, Table table);

  /**
   * Connect to ColumnInserted signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectColumnInserted(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ColumnInsertedCallbackDlg) || is(T : ColumnInsertedCallbackFunc));

  /**
   * The "column-reordered" signal is emitted by an object which
   * implements the AtkTable interface when the columns are
   * reordered.
   *   table = the instance the signal is connected to
   */
  alias ColumnReorderedCallbackDlg = void delegate(Table table);
  alias ColumnReorderedCallbackFunc = void function(Table table);

  /**
   * Connect to ColumnReordered signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectColumnReordered(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ColumnReorderedCallbackDlg) || is(T : ColumnReorderedCallbackFunc));

  /**
   * The "model-changed" signal is emitted by an object which
   * implements the AtkTable interface when the model displayed by
   * the table changes.
   *   table = the instance the signal is connected to
   */
  alias ModelChangedCallbackDlg = void delegate(Table table);
  alias ModelChangedCallbackFunc = void function(Table table);

  /**
   * Connect to ModelChanged signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectModelChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ModelChangedCallbackDlg) || is(T : ModelChangedCallbackFunc));

  /**
   * The "row-deleted" signal is emitted by an object which
   * implements the AtkTable interface when a row is deleted.
   * Params
   *   arg1 = The index of the first row deleted.
   *   arg2 = The number of rows deleted.
   *   table = the instance the signal is connected to
   */
  alias RowDeletedCallbackDlg = void delegate(int arg1, int arg2, Table table);
  alias RowDeletedCallbackFunc = void function(int arg1, int arg2, Table table);

  /**
   * Connect to RowDeleted signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRowDeleted(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RowDeletedCallbackDlg) || is(T : RowDeletedCallbackFunc));

  /**
   * The "row-inserted" signal is emitted by an object which
   * implements the AtkTable interface when a row is inserted.
   * Params
   *   arg1 = The index of the first row inserted.
   *   arg2 = The number of rows inserted.
   *   table = the instance the signal is connected to
   */
  alias RowInsertedCallbackDlg = void delegate(int arg1, int arg2, Table table);
  alias RowInsertedCallbackFunc = void function(int arg1, int arg2, Table table);

  /**
   * Connect to RowInserted signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRowInserted(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RowInsertedCallbackDlg) || is(T : RowInsertedCallbackFunc));

  /**
   * The "row-reordered" signal is emitted by an object which
   * implements the AtkTable interface when the rows are
   * reordered.
   *   table = the instance the signal is connected to
   */
  alias RowReorderedCallbackDlg = void delegate(Table table);
  alias RowReorderedCallbackFunc = void function(Table table);

  /**
   * Connect to RowReordered signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRowReordered(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RowReorderedCallbackDlg) || is(T : RowReorderedCallbackFunc));
  }
