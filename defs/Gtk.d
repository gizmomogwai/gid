//!repo Gtk-4.0

//# Add missing c:type for GtkSnapshot
//!set class[Snapshot][c:type] GtkSnapshot

//# CellArea::add-editable signal has parameter name which conflicts with cellArea instance name, rename it
//!set class[CellArea].glib:signal[add-editable].parameters.parameter[cell_area][name] area

//# Set arrays to be zero-terminated=1
//!set function[accelerator_parse_with_keycode].parameters.parameter[accelerator_codes].array[][zero-terminated] 1
//!set class[IconTheme].method[get_icon_sizes].return-value.array[][zero-terminated] 1

//# axes param takes a GDK_AXIS_IGNORE terminated array (0 value) and expects the out values[] array to be the same size (use length of axes array)
//!set class[GestureStylus].method[get_axes].parameters.parameter[axes].array[][zero-terminated] 1
//!set class[GestureStylus].method[get_axes].parameters.parameter[values].array[][length] 0

//# Change Builder.new_from_string to take an array of characters with a length, to remove the length and optimize
//!set class[Builder].constructor[new_from_string].parameters.parameter[string].type '<array length="1" c:type="gchar*"><type name="char" c:type="char"/></array>'

//# Use array of characters with a length, to remove the length and optimize
//!set class[TextBuffer].method[set_text].parameters.parameter[text].type '<array length="1" c:type="const gchar*"><type name="char" c:type="char"/></array>'
//!set class[TextBuffer].method[insert].parameters.parameter[text].type '<array length="2" c:type="const gchar*"><type name="char" c:type="char"/></array>'
//!set class[TextBuffer].method[insert_at_cursor].parameters.parameter[text].type '<array length="1" c:type="const gchar*"><type name="char" c:type="char"/></array>'
//!set class[TextBuffer].method[insert_interactive].parameters.parameter[text].type '<array length="2" c:type="const gchar*"><type name="char" c:type="char"/></array>'
//!set class[TextBuffer].method[insert_interactive_at_cursor].parameters.parameter[text].type '<array length="1" c:type="const gchar*"><type name="char" c:type="char"/></array>'
//!set class[TextBuffer].method[insert_markup].parameters.parameter[markup].type '<array length="2" c:type="const gchar*"><type name="char" c:type="char"/></array>'
//!set interface[Editable].method[insert_text].parameters.parameter[text].type '<array length="1" c:type="const gchar*"><type name="char" c:type="char"/></array>'
//!set class[IMContext].method[set_surrounding].parameters.parameter[text].type '<array length="1" c:type="const gchar*"><type name="char" c:type="char"/></array>'
//!set class[IMContext].method[set_surrounding_with_selection].parameters.parameter[text].type '<array length="1" c:type="const gchar*"><type name="char" c:type="char"/></array>'

//!class CustomSorter
//!set class[CustomSorter].constructor[new][disable] 1
//!set class[CustomSorter].method[set_sort_func][disable] 1
  import gobject.object;

  // Define a sort delegate that takes ObjectG objects, instead of the CompareDataFunc which is passed raw ObjectC pointers
  alias CustomSortDelegate = int delegate(ObjectG aObj, ObjectG bObj);

  /**
   * Creates a new `GtkSorter` that works by calling
   * sortFunc to compare items.
   * If sortFunc is null, all items are considered equal.
   * Params:
   *   sortFunc = the callback delegate to use for sorting
   * Returns: a new `CustomSorter`
   */
  this(CustomSortDelegate sortFunc)
  {
    extern(C) int _sortFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CustomSortDelegate*)userData;
      auto aObj = cast(ObjectC*)a;
      auto bObj = cast(ObjectC*)b;

      int _retval = (*_dlg)(ObjectG.getDObject!ObjectG(aObj), ObjectG.getDObject!ObjectG(bObj));
      return _retval;
    }

    GtkCustomSorter* _cretval;
    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    _cretval = gtk_custom_sorter_new(&_sortFuncCallback, _sortFunc, &thawDelegate);
    this(_cretval, Yes.Take);
  }

  /**
   * Sets $(LPAREN)or unsets$(RPAREN) the function used for sorting items.
   * If sort_func is %NULL, all items are considered equal.
   * If the sort func changes its sorting behavior,
   * [Gtk.Sorter.changed] needs to be called.
   * If a previous function was set, its user_destroy will be
   * called now.
   * Params:
   *   sortFunc = function to sort items
   */
  void setSortFunc(CustomSortDelegate sortFunc)
  {
    extern(C) int _sortFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CustomSortDelegate*)userData;
      auto aObj = cast(ObjectC*)a;
      auto bObj = cast(ObjectC*)b;

      int _retval = (*_dlg)(ObjectG.getDObject!ObjectG(aObj), ObjectG.getDObject!ObjectG(bObj));
      return _retval;
    }

    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    gtk_custom_sorter_set_sort_func(cast(GtkCustomSorter*)cPtr, &_sortFuncCallback, _sortFunc, &thawDelegate);
  }
