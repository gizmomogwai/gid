module arrow.jsonread_options;

import arrow.c.functions;
import arrow.c.types;
import arrow.types;
import gid.global;
import gobject.object;

class JSONReadOptions : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_json_read_options_get_type != &gidSymbolNotFound ? garrow_json_read_options_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GArrowJSONReadOptions* _cretval;
    _cretval = garrow_json_read_options_new();
    this(_cretval, Yes.Take);
  }
}
