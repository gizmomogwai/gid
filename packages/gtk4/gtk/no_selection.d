module gtk.no_selection;

import gid.global;
import gio.list_model;
import gio.list_model_mixin;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.section_model;
import gtk.section_model_mixin;
import gtk.selection_model;
import gtk.selection_model_mixin;
import gtk.types;

/**
 * `GtkNoSelection` is a `GtkSelectionModel` that does not allow selecting
 * anything.
 * This model is meant to be used as a simple wrapper around a `GListModel`
 * when a `GtkSelectionModel` is required.
 * `GtkNoSelection` passes through sections from the underlying model.
 */
class NoSelection : ObjectG, ListModel, SectionModel, SelectionModel
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_no_selection_get_type != &gidSymbolNotFound ? gtk_no_selection_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();
  mixin SectionModelT!();
  mixin SelectionModelT!();

  /**
   * Creates a new selection to handle model.
   * Params:
   *   model = the `GListModel` to manage
   * Returns: a new `GtkNoSelection`
   */
  this(ListModel model)
  {
    GtkNoSelection* _cretval;
    _cretval = gtk_no_selection_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(Yes.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * Gets the model that self is wrapping.
   * Returns: The model being wrapped
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_no_selection_get_model(cast(GtkNoSelection*)cPtr);
    auto _retval = ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Sets the model that self should wrap.
   * If model is %NULL, this model will be empty.
   * Params:
   *   model = A `GListModel` to wrap
   */
  void setModel(ListModel model)
  {
    gtk_no_selection_set_model(cast(GtkNoSelection*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(No.Dup) : null);
  }
}
