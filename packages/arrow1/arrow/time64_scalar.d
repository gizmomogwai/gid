module arrow.time64_scalar;

import arrow.c.functions;
import arrow.c.types;
import arrow.scalar;
import arrow.time64_data_type;
import arrow.types;
import gid.global;

class Time64Scalar : Scalar
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_time64_scalar_get_type != &gidSymbolNotFound ? garrow_time64_scalar_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Time64DataType dataType, long value)
  {
    GArrowTime64Scalar* _cretval;
    _cretval = garrow_time64_scalar_new(dataType ? cast(GArrowTime64DataType*)dataType.cPtr(No.Dup) : null, value);
    this(_cretval, Yes.Take);
  }

  long getValue()
  {
    long _retval;
    _retval = garrow_time64_scalar_get_value(cast(GArrowTime64Scalar*)cPtr);
    return _retval;
  }
}
