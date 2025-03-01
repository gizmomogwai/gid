module arrow.double_scalar;

import arrow.c.functions;
import arrow.c.types;
import arrow.scalar;
import arrow.types;
import gid.global;

class DoubleScalar : Scalar
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_double_scalar_get_type != &gidSymbolNotFound ? garrow_double_scalar_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(double value)
  {
    GArrowDoubleScalar* _cretval;
    _cretval = garrow_double_scalar_new(value);
    this(_cretval, Yes.Take);
  }

  double getValue()
  {
    double _retval;
    _retval = garrow_double_scalar_get_value(cast(GArrowDoubleScalar*)cPtr);
    return _retval;
  }
}
