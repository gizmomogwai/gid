module arrow.time64_data_type;

import arrow.c.functions;
import arrow.c.types;
import arrow.time_data_type;
import arrow.types;
import gid.global;
import glib.error;

class Time64DataType : TimeDataType
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_time64_data_type_get_type != &gidSymbolNotFound ? garrow_time64_data_type_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(TimeUnit unit)
  {
    GArrowTime64DataType* _cretval;
    GError *_err;
    _cretval = garrow_time64_data_type_new(unit, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, Yes.Take);
  }
}
