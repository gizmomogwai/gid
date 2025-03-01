module arrow.list_scalar;

import arrow.base_list_scalar;
import arrow.c.functions;
import arrow.c.types;
import arrow.list_array;
import arrow.types;
import gid.global;

class ListScalar : BaseListScalar
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_list_scalar_get_type != &gidSymbolNotFound ? garrow_list_scalar_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(ListArray value)
  {
    GArrowListScalar* _cretval;
    _cretval = garrow_list_scalar_new(value ? cast(GArrowListArray*)value.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }
}
