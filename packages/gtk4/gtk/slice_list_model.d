module gtk.slice_list_model;

import gid.global;
import gio.list_model;
import gio.list_model_mixin;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.section_model;
import gtk.section_model_mixin;
import gtk.types;

/**
 * `GtkSliceListModel` is a list model that presents a slice of another model.
 * This is useful when implementing paging by setting the size to the number
 * of elements per page and updating the offset whenever a different page is
 * opened.
 * `GtkSliceListModel` passes through sections from the underlying model.
 */
class SliceListModel : ObjectG, ListModel, SectionModel
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_slice_list_model_get_type != &gidSymbolNotFound ? gtk_slice_list_model_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();
  mixin SectionModelT!();

  /**
   * Creates a new slice model.
   * It presents the slice from offset to offset + size
   * of the given model.
   * Params:
   *   model = The model to use
   *   offset = the offset of the slice
   *   size = maximum size of the slice
   * Returns: A new `GtkSliceListModel`
   */
  this(ListModel model, uint offset, uint size)
  {
    GtkSliceListModel* _cretval;
    _cretval = gtk_slice_list_model_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(Yes.Dup) : null, offset, size);
    this(_cretval, Yes.Take);
  }

  /**
   * Gets the model that is currently being used or %NULL if none.
   * Returns: The model in use
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_slice_list_model_get_model(cast(GtkSliceListModel*)cPtr);
    auto _retval = ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the offset set via [gtk.slice_list_model.SliceListModel.setOffset].
   * Returns: The offset
   */
  uint getOffset()
  {
    uint _retval;
    _retval = gtk_slice_list_model_get_offset(cast(GtkSliceListModel*)cPtr);
    return _retval;
  }

  /**
   * Gets the size set via [gtk.slice_list_model.SliceListModel.setSize].
   * Returns: The size
   */
  uint getSize()
  {
    uint _retval;
    _retval = gtk_slice_list_model_get_size(cast(GtkSliceListModel*)cPtr);
    return _retval;
  }

  /**
   * Sets the model to show a slice of.
   * The model's item type must conform to self's item type.
   * Params:
   *   model = The model to be sliced
   */
  void setModel(ListModel model)
  {
    gtk_slice_list_model_set_model(cast(GtkSliceListModel*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(No.Dup) : null);
  }

  /**
   * Sets the offset into the original model for this slice.
   * If the offset is too large for the sliced model,
   * self will end up empty.
   * Params:
   *   offset = the new offset to use
   */
  void setOffset(uint offset)
  {
    gtk_slice_list_model_set_offset(cast(GtkSliceListModel*)cPtr, offset);
  }

  /**
   * Sets the maximum size. self will never have more items
   * than size.
   * It can however have fewer items if the offset is too large
   * or the model sliced from doesn't have enough items.
   * Params:
   *   size = the maximum size
   */
  void setSize(uint size)
  {
    gtk_slice_list_model_set_size(cast(GtkSliceListModel*)cPtr, size);
  }
}
