module Arrow.Decimal256Array;

import Arrow.Decimal256;
import Arrow.FixedSizeBinaryArray;
import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import GObject.ObjectG;
import Gid.gid;

class Decimal256Array : FixedSizeBinaryArray
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return garrow_decimal256_array_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  string formatValue(long i)
  {
    char* _cretval;
    _cretval = garrow_decimal256_array_format_value(cast(GArrowDecimal256Array*)cPtr, i);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  alias getValue = FixedSizeBinaryArray.getValue;

  Decimal256 getValue(long i)
  {
    GArrowDecimal256* _cretval;
    _cretval = garrow_decimal256_array_get_value(cast(GArrowDecimal256Array*)cPtr, i);
    auto _retval = ObjectG.getDObject!Decimal256(cast(GArrowDecimal256*)_cretval, Yes.Take);
    return _retval;
  }
}
