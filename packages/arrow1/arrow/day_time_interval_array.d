module arrow.day_time_interval_array;

import arrow.buffer;
import arrow.c.functions;
import arrow.c.types;
import arrow.day_millisecond;
import arrow.primitive_array;
import arrow.types;
import gid.global;
import gobject.object;

class DayTimeIntervalArray : PrimitiveArray
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_day_time_interval_array_get_type != &gidSymbolNotFound ? garrow_day_time_interval_array_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(long length, Buffer data, Buffer nullBitmap, long nNulls)
  {
    GArrowDayTimeIntervalArray* _cretval;
    _cretval = garrow_day_time_interval_array_new(length, data ? cast(GArrowBuffer*)data.cPtr(No.Dup) : null, nullBitmap ? cast(GArrowBuffer*)nullBitmap.cPtr(No.Dup) : null, nNulls);
    this(_cretval, Yes.Take);
  }

  DayMillisecond getValue(long i)
  {
    GArrowDayMillisecond* _cretval;
    _cretval = garrow_day_time_interval_array_get_value(cast(GArrowDayTimeIntervalArray*)cPtr, i);
    auto _retval = ObjectG.getDObject!DayMillisecond(cast(GArrowDayMillisecond*)_cretval, Yes.Take);
    return _retval;
  }

  DayMillisecond[] getValues()
  {
    GList* _cretval;
    _cretval = garrow_day_time_interval_array_get_values(cast(GArrowDayTimeIntervalArray*)cPtr);
    auto _retval = gListToD!(DayMillisecond, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }
}
