module arrow.float_scalar;

import arrow.c.functions;
import arrow.c.types;
import arrow.scalar;
import arrow.types;
import gid.gid;

class FloatScalar : Scalar
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_float_scalar_get_type != &gidSymbolNotFound ? garrow_float_scalar_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(float value)
  {
    GArrowFloatScalar* _cretval;
    _cretval = garrow_float_scalar_new(value);
    this(_cretval, Yes.Take);
  }

  float getValue()
  {
    float _retval;
    _retval = garrow_float_scalar_get_value(cast(GArrowFloatScalar*)cPtr);
    return _retval;
  }
}
