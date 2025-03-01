module cairo.path;

import cairo.c.functions;
import cairo.c.types;
import cairo.types;
import gid.global;
import gobject.boxed;

/**
 * A data structure for holding a path. This data structure serves as
 * the return value for [cairo.context.Context.copyPath] and
 * [cairo.context.Context.copyPathFlat] as well the input value for
 * [cairo.context.Context.appendPath].
 * See #cairo_path_data_t for hints on how to iterate over the
 * actual data within the path.
 * The num_data member gives the number of elements in the data
 * array. This number is larger than the number of independent path
 * portions $(LPAREN)defined in #cairo_path_data_type_t$(RPAREN), since the data
 * includes both headers and coordinates for each portion.
 */
class Path : Boxed
{

  this()
  {
    super(safeMalloc(cairo_path_t.sizeof), Yes.Take);
  }

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  void* cPtr(Flag!"Dup" dup = No.Dup)
  {
    return dup ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())cairo_gobject_path_get_type != &gidSymbolNotFound ? cairo_gobject_path_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Status status()
  {
    return cast(Status)(cast(cairo_path_t*)cPtr).status;
  }

  @property void status(Status propval)
  {
    (cast(cairo_path_t*)cPtr).status = cast(cairo_status_t)propval;
  }

  @property int numData()
  {
    return (cast(cairo_path_t*)cPtr).numData;
  }

  @property void numData(int propval)
  {
    (cast(cairo_path_t*)cPtr).numData = propval;
  }
}
