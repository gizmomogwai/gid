module arrow.time64_array_builder;

import arrow.array_builder;
import arrow.c.functions;
import arrow.c.types;
import arrow.time64_data_type;
import arrow.types;
import gid.gid;
import glib.error;

class Time64ArrayBuilder : ArrayBuilder
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_time64_array_builder_get_type != &gidSymbolNotFound ? garrow_time64_array_builder_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Time64DataType dataType)
  {
    GArrowTime64ArrayBuilder* _cretval;
    _cretval = garrow_time64_array_builder_new(dataType ? cast(GArrowTime64DataType*)dataType.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  bool append(long value)
  {
    bool _retval;
    GError *_err;
    _retval = garrow_time64_array_builder_append(cast(GArrowTime64ArrayBuilder*)cPtr, value, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  bool appendValue(long value)
  {
    bool _retval;
    GError *_err;
    _retval = garrow_time64_array_builder_append_value(cast(GArrowTime64ArrayBuilder*)cPtr, value, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Append multiple values at once. It's more efficient than multiple
   * `append` and `append_null` calls.
   * Params:
   *   values = The array of
   *     the number of milliseconds since UNIX epoch in signed 64bit integer.
   *   isValids = The array of
   *     boolean that shows whether the Nth value is valid or not. If the
   *     Nth `is_valids` is %TRUE, the Nth `values` is valid value. Otherwise
   *     the Nth value is null value.
   * Returns: %TRUE on success, %FALSE if there was an error.
   */
  bool appendValues(long[] values, bool[] isValids)
  {
    bool _retval;
    long _valuesLength;
    if (values)
      _valuesLength = cast(long)values.length;

    auto _values = cast(const(long)*)values.ptr;
    long _isValidsLength;
    if (isValids)
      _isValidsLength = cast(long)isValids.length;

    auto _isValids = cast(const(bool)*)isValids.ptr;
    GError *_err;
    _retval = garrow_time64_array_builder_append_values(cast(GArrowTime64ArrayBuilder*)cPtr, _values, _valuesLength, _isValids, _isValidsLength, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
