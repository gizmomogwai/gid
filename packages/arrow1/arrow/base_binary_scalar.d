module arrow.base_binary_scalar;

import arrow.buffer;
import arrow.c.functions;
import arrow.c.types;
import arrow.scalar;
import arrow.types;
import gid.global;
import gobject.object;

class BaseBinaryScalar : Scalar
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_base_binary_scalar_get_type != &gidSymbolNotFound ? garrow_base_binary_scalar_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  Buffer getValue()
  {
    GArrowBuffer* _cretval;
    _cretval = garrow_base_binary_scalar_get_value(cast(GArrowBaseBinaryScalar*)cPtr);
    auto _retval = ObjectG.getDObject!Buffer(cast(GArrowBuffer*)_cretval, No.Take);
    return _retval;
  }
}
