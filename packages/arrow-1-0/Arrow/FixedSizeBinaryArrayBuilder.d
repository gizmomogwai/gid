module Arrow.FixedSizeBinaryArrayBuilder;

import Arrow.ArrayBuilder;
import Arrow.FixedSizeBinaryDataType;
import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import GLib.Bytes;
import GLib.ErrorG;
import Gid.gid;

class FixedSizeBinaryArrayBuilder : ArrayBuilder
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return garrow_fixed_size_binary_array_builder_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this(FixedSizeBinaryDataType dataType)
  {
    GArrowFixedSizeBinaryArrayBuilder* _cretval;
    _cretval = garrow_fixed_size_binary_array_builder_new(dataType ? cast(GArrowFixedSizeBinaryDataType*)dataType.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  bool appendValue(ubyte[] value)
  {
    bool _retval;
    int _length;
    if (value)
      _length = cast(int)value.length;

    auto _value = cast(const(ubyte)*)value.ptr;
    GError *_err;
    _retval = garrow_fixed_size_binary_array_builder_append_value(cast(GArrowFixedSizeBinaryArrayBuilder*)cPtr, _value, _length, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  bool appendValueBytes(Bytes value)
  {
    bool _retval;
    GError *_err;
    _retval = garrow_fixed_size_binary_array_builder_append_value_bytes(cast(GArrowFixedSizeBinaryArrayBuilder*)cPtr, value ? cast(GBytes*)value.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Append multiple values at once. It's more efficient than multiple
   * `append` and `append_null` calls.
   * Params:
   *   values = The array of #GBytes.
   *   isValids = The array of
   *     boolean that shows whether the Nth value is valid or not. If the
   *     Nth is_valids is %TRUE, the Nth values is valid value. Otherwise
   *     the Nth value is null value.
   * Returns: %TRUE on success, %FALSE if there was an error.
   */
  bool appendValues(Bytes[] values, bool[] isValids)
  {
    bool _retval;
    long _valuesLength;
    if (values)
      _valuesLength = cast(long)values.length;

    GBytes*[] _tmpvalues;
    foreach (obj; values)
      _tmpvalues ~= cast(GBytes*)obj.cPtr;
    GBytes** _values = _tmpvalues.ptr;

    long _isValidsLength;
    if (isValids)
      _isValidsLength = cast(long)isValids.length;

    auto _isValids = cast(const(bool)*)isValids.ptr;
    GError *_err;
    _retval = garrow_fixed_size_binary_array_builder_append_values(cast(GArrowFixedSizeBinaryArrayBuilder*)cPtr, _values, _valuesLength, _isValids, _isValidsLength, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Append multiple values at once. It's more efficient than multiple
   * `append` and `append_null` calls.
   * This is more efficient than
   * [Arrow.FixedSizeBinaryArrayBuilder.appendValues].
   * Params:
   *   values = A #GBytes that contains multiple values.
   *   isValids = The array of
   *     boolean that shows whether the Nth value is valid or not. If the
   *     Nth is_valids is %TRUE, the Nth values is valid value. Otherwise
   *     the Nth value is null value.
   * Returns: %TRUE on success, %FALSE if there was an error.
   */
  bool appendValuesPacked(Bytes values, bool[] isValids)
  {
    bool _retval;
    long _isValidsLength;
    if (isValids)
      _isValidsLength = cast(long)isValids.length;

    auto _isValids = cast(const(bool)*)isValids.ptr;
    GError *_err;
    _retval = garrow_fixed_size_binary_array_builder_append_values_packed(cast(GArrowFixedSizeBinaryArrayBuilder*)cPtr, values ? cast(GBytes*)values.cPtr(No.Dup) : null, _isValids, _isValidsLength, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
