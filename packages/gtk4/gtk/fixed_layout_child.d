module gtk.fixed_layout_child;

import gid.global;
import gsk.transform;
import gtk.c.functions;
import gtk.c.types;
import gtk.layout_child;
import gtk.types;

/**
 * `GtkLayoutChild` subclass for children in a `GtkFixedLayout`.
 */
class FixedLayoutChild : LayoutChild
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_fixed_layout_child_get_type != &gidSymbolNotFound ? gtk_fixed_layout_child_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Retrieves the transformation of the child.
   * Returns: a `GskTransform`
   */
  Transform getTransform()
  {
    GskTransform* _cretval;
    _cretval = gtk_fixed_layout_child_get_transform(cast(GtkFixedLayoutChild*)cPtr);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Sets the transformation of the child of a `GtkFixedLayout`.
   * Params:
   *   transform = a `GskTransform`
   */
  void setTransform(Transform transform)
  {
    gtk_fixed_layout_child_set_transform(cast(GtkFixedLayoutChild*)cPtr, transform ? cast(GskTransform*)transform.cPtr(No.Dup) : null);
  }
}
