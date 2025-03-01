module gtk.combo_box_text;

import gid.global;
import gobject.object;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.cell_editable;
import gtk.cell_editable_mixin;
import gtk.cell_layout;
import gtk.cell_layout_mixin;
import gtk.combo_box;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.types;

/**
 * A `GtkComboBoxText` is a simple variant of `GtkComboBox` for text-only
 * use cases.
 * ![An example GtkComboBoxText](combo-box-text.png)
 * `GtkComboBoxText` hides the model-view complexity of `GtkComboBox`.
 * To create a `GtkComboBoxText`, use [gtk.combo_box_text.ComboBoxText.new_] or
 * [gtk.combo_box_text.ComboBoxText.newWithEntry].
 * You can add items to a `GtkComboBoxText` with
 * [gtk.combo_box_text.ComboBoxText.appendText],
 * [gtk.combo_box_text.ComboBoxText.insertText] or
 * [gtk.combo_box_text.ComboBoxText.prependText] and remove options with
 * [gtk.combo_box_text.ComboBoxText.remove].
 * If the `GtkComboBoxText` contains an entry $(LPAREN)via the
 * property@Gtk.ComboBox:has-entry property$(RPAREN), its contents can be retrieved
 * using [gtk.combo_box_text.ComboBoxText.getActiveText].
 * You should not call [gtk.combo_box.ComboBox.setModel] or attempt to pack more
 * cells into this combo box via its [gtk.cell_layout.CellLayout] interface.
 * ## GtkComboBoxText as GtkBuildable
 * The `GtkComboBoxText` implementation of the `GtkBuildable` interface supports
 * adding items directly using the `<items>` element and specifying `<item>`
 * elements for each item. Each `<item>` element can specify the “id”
 * corresponding to the appended text and also supports the regular
 * translation attributes “translatable”, “context” and “comments”.
 * Here is a UI definition fragment specifying `GtkComboBoxText` items:
 * ```xml
 * <object class\="GtkComboBoxText">
 * <items>
 * <item translatable\="yes" id\="factory">Factory</item>
 * <item translatable\="yes" id\="home">Home</item>
 * <item translatable\="yes" id\="subway">Subway</item>
 * </items>
 * </object>
 * ```
 * ## CSS nodes
 * ```
 * combobox
 * ╰── box.linked
 * ├── entry.combo
 * ├── button.combo
 * ╰── window.popup
 * ```
 * `GtkComboBoxText` has a single CSS node with name combobox. It adds
 * the style class .combo to the main CSS nodes of its entry and button
 * children, and the .linked class to the node of its internal box.

 * Deprecated: Use [gtk.drop_down.DropDown] with a [gtk.string_list.StringList]
 *   instead
 */
class ComboBoxText : ComboBox
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_combo_box_text_get_type != &gidSymbolNotFound ? gtk_combo_box_text_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkComboBoxText`.
   * Returns: A new `GtkComboBoxText`

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_text_new();
    this(_cretval, No.Take);
  }

  /**
   * Creates a new `GtkComboBoxText` with an entry.
   * Returns: a new `GtkComboBoxText`

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  static ComboBoxText newWithEntry()
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_text_new_with_entry();
    auto _retval = ObjectG.getDObject!ComboBoxText(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Appends text to the list of strings stored in combo_box.
   * If id is non-%NULL then it is used as the ID of the row.
   * This is the same as calling [gtk.combo_box_text.ComboBoxText.insert]
   * with a position of -1.
   * Params:
   *   id = a string ID for this value
   *   text = A string

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  void append(string id, string text)
  {
    const(char)* _id = id.toCString(No.Alloc);
    const(char)* _text = text.toCString(No.Alloc);
    gtk_combo_box_text_append(cast(GtkComboBoxText*)cPtr, _id, _text);
  }

  /**
   * Appends text to the list of strings stored in combo_box.
   * This is the same as calling [gtk.combo_box_text.ComboBoxText.insertText]
   * with a position of -1.
   * Params:
   *   text = A string

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  void appendText(string text)
  {
    const(char)* _text = text.toCString(No.Alloc);
    gtk_combo_box_text_append_text(cast(GtkComboBoxText*)cPtr, _text);
  }

  /**
   * Returns the currently active string in combo_box.
   * If no row is currently selected, %NULL is returned.
   * If combo_box contains an entry, this function will
   * return its contents $(LPAREN)which will not necessarily
   * be an item from the list$(RPAREN).
   * Returns: a newly allocated
   *   string containing the currently active text.
   *   Must be freed with [glib.global.gfree].

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  string getActiveText()
  {
    char* _cretval;
    _cretval = gtk_combo_box_text_get_active_text(cast(GtkComboBoxText*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Inserts text at position in the list of strings stored in combo_box.
   * If id is non-%NULL then it is used as the ID of the row.
   * See propertyGtk.ComboBox:id-column.
   * If position is negative then text is appended.
   * Params:
   *   position = An index to insert text
   *   id = a string ID for this value
   *   text = A string to display

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  void insert(int position, string id, string text)
  {
    const(char)* _id = id.toCString(No.Alloc);
    const(char)* _text = text.toCString(No.Alloc);
    gtk_combo_box_text_insert(cast(GtkComboBoxText*)cPtr, position, _id, _text);
  }

  /**
   * Inserts text at position in the list of strings stored in combo_box.
   * If position is negative then text is appended.
   * This is the same as calling [gtk.combo_box_text.ComboBoxText.insert]
   * with a %NULL ID string.
   * Params:
   *   position = An index to insert text
   *   text = A string

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  void insertText(int position, string text)
  {
    const(char)* _text = text.toCString(No.Alloc);
    gtk_combo_box_text_insert_text(cast(GtkComboBoxText*)cPtr, position, _text);
  }

  /**
   * Prepends text to the list of strings stored in combo_box.
   * If id is non-%NULL then it is used as the ID of the row.
   * This is the same as calling [gtk.combo_box_text.ComboBoxText.insert]
   * with a position of 0.
   * Params:
   *   id = a string ID for this value
   *   text = a string

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  void prepend(string id, string text)
  {
    const(char)* _id = id.toCString(No.Alloc);
    const(char)* _text = text.toCString(No.Alloc);
    gtk_combo_box_text_prepend(cast(GtkComboBoxText*)cPtr, _id, _text);
  }

  /**
   * Prepends text to the list of strings stored in combo_box.
   * This is the same as calling [gtk.combo_box_text.ComboBoxText.insertText]
   * with a position of 0.
   * Params:
   *   text = A string

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  void prependText(string text)
  {
    const(char)* _text = text.toCString(No.Alloc);
    gtk_combo_box_text_prepend_text(cast(GtkComboBoxText*)cPtr, _text);
  }

  /**
   * Removes the string at position from combo_box.
   * Params:
   *   position = Index of the item to remove

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  void remove(int position)
  {
    gtk_combo_box_text_remove(cast(GtkComboBoxText*)cPtr, position);
  }

  /**
   * Removes all the text entries from the combo box.

   * Deprecated: Use [gtk.drop_down.DropDown]
   */
  void removeAll()
  {
    gtk_combo_box_text_remove_all(cast(GtkComboBoxText*)cPtr);
  }
}
