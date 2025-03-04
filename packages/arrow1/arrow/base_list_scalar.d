module arrow.base_list_scalar;

import arrow.array;
import arrow.c.functions;
import arrow.c.types;
import arrow.scalar;
import arrow.types;
import gid.global;
import gobject.object;

class BaseListScalar : Scalar
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_base_list_scalar_get_type != &gidSymbolNotFound ? garrow_base_list_scalar_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  Array getValue()
  {
    GArrowArray* _cretval;
    _cretval = garrow_base_list_scalar_get_value(cast(GArrowBaseListScalar*)cPtr);
    auto _retval = ObjectG.getDObject!Array(cast(GArrowArray*)_cretval, No.Take);
    return _retval;
  }
}
