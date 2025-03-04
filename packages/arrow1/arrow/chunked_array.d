module arrow.chunked_array;

import arrow.array;
import arrow.boolean_array;
import arrow.c.functions;
import arrow.c.types;
import arrow.data_type;
import arrow.filter_options;
import arrow.take_options;
import arrow.types;
import arrow.uint64_array;
import gid.global;
import glib.error;
import gobject.object;

class ChunkedArray : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_chunked_array_get_type != &gidSymbolNotFound ? garrow_chunked_array_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Array[] chunks)
  {
    GArrowChunkedArray* _cretval;
    auto _chunks = gListFromD!(Array)(chunks);
    scope(exit) containerFree!(GList*, Array, GidOwnership.None)(_chunks);
    GError *_err;
    _cretval = garrow_chunked_array_new(_chunks, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, Yes.Take);
  }

  static ChunkedArray newEmpty(DataType dataType)
  {
    GArrowChunkedArray* _cretval;
    GError *_err;
    _cretval = garrow_chunked_array_new_empty(dataType ? cast(GArrowDataType*)dataType.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!ChunkedArray(cast(GArrowChunkedArray*)_cretval, Yes.Take);
    return _retval;
  }

  Array combine()
  {
    GArrowArray* _cretval;
    GError *_err;
    _cretval = garrow_chunked_array_combine(cast(GArrowChunkedArray*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!Array(cast(GArrowArray*)_cretval, Yes.Take);
    return _retval;
  }

  bool equal(ChunkedArray otherChunkedArray)
  {
    bool _retval;
    _retval = garrow_chunked_array_equal(cast(GArrowChunkedArray*)cPtr, otherChunkedArray ? cast(GArrowChunkedArray*)otherChunkedArray.cPtr(No.Dup) : null);
    return _retval;
  }

  ChunkedArray filter(BooleanArray filter, FilterOptions options)
  {
    GArrowChunkedArray* _cretval;
    GError *_err;
    _cretval = garrow_chunked_array_filter(cast(GArrowChunkedArray*)cPtr, filter ? cast(GArrowBooleanArray*)filter.cPtr(No.Dup) : null, options ? cast(GArrowFilterOptions*)options.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!ChunkedArray(cast(GArrowChunkedArray*)_cretval, Yes.Take);
    return _retval;
  }

  ChunkedArray filterChunkedArray(ChunkedArray filter, FilterOptions options)
  {
    GArrowChunkedArray* _cretval;
    GError *_err;
    _cretval = garrow_chunked_array_filter_chunked_array(cast(GArrowChunkedArray*)cPtr, filter ? cast(GArrowChunkedArray*)filter.cPtr(No.Dup) : null, options ? cast(GArrowFilterOptions*)options.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!ChunkedArray(cast(GArrowChunkedArray*)_cretval, Yes.Take);
    return _retval;
  }

  Array getChunk(uint i)
  {
    GArrowArray* _cretval;
    _cretval = garrow_chunked_array_get_chunk(cast(GArrowChunkedArray*)cPtr, i);
    auto _retval = ObjectG.getDObject!Array(cast(GArrowArray*)_cretval, Yes.Take);
    return _retval;
  }

  Array[] getChunks()
  {
    GList* _cretval;
    _cretval = garrow_chunked_array_get_chunks(cast(GArrowChunkedArray*)cPtr);
    auto _retval = gListToD!(Array, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  ulong getLength()
  {
    ulong _retval;
    _retval = garrow_chunked_array_get_length(cast(GArrowChunkedArray*)cPtr);
    return _retval;
  }

  uint getNChunks()
  {
    uint _retval;
    _retval = garrow_chunked_array_get_n_chunks(cast(GArrowChunkedArray*)cPtr);
    return _retval;
  }

  ulong getNNulls()
  {
    ulong _retval;
    _retval = garrow_chunked_array_get_n_nulls(cast(GArrowChunkedArray*)cPtr);
    return _retval;
  }

  ulong getNRows()
  {
    ulong _retval;
    _retval = garrow_chunked_array_get_n_rows(cast(GArrowChunkedArray*)cPtr);
    return _retval;
  }

  DataType getValueDataType()
  {
    GArrowDataType* _cretval;
    _cretval = garrow_chunked_array_get_value_data_type(cast(GArrowChunkedArray*)cPtr);
    auto _retval = ObjectG.getDObject!DataType(cast(GArrowDataType*)_cretval, Yes.Take);
    return _retval;
  }

  Type getValueType()
  {
    GArrowType _cretval;
    _cretval = garrow_chunked_array_get_value_type(cast(GArrowChunkedArray*)cPtr);
    Type _retval = cast(Type)_cretval;
    return _retval;
  }

  ChunkedArray slice(ulong offset, ulong length)
  {
    GArrowChunkedArray* _cretval;
    _cretval = garrow_chunked_array_slice(cast(GArrowChunkedArray*)cPtr, offset, length);
    auto _retval = ObjectG.getDObject!ChunkedArray(cast(GArrowChunkedArray*)_cretval, Yes.Take);
    return _retval;
  }

  UInt64Array sortIndices(SortOrder order)
  {
    GArrowUInt64Array* _cretval;
    GError *_err;
    _cretval = garrow_chunked_array_sort_indices(cast(GArrowChunkedArray*)cPtr, order, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!UInt64Array(cast(GArrowUInt64Array*)_cretval, Yes.Take);
    return _retval;
  }

  ChunkedArray take(Array indices, TakeOptions options)
  {
    GArrowChunkedArray* _cretval;
    GError *_err;
    _cretval = garrow_chunked_array_take(cast(GArrowChunkedArray*)cPtr, indices ? cast(GArrowArray*)indices.cPtr(No.Dup) : null, options ? cast(GArrowTakeOptions*)options.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!ChunkedArray(cast(GArrowChunkedArray*)_cretval, Yes.Take);
    return _retval;
  }

  ChunkedArray takeChunkedArray(ChunkedArray indices, TakeOptions options)
  {
    GArrowChunkedArray* _cretval;
    GError *_err;
    _cretval = garrow_chunked_array_take_chunked_array(cast(GArrowChunkedArray*)cPtr, indices ? cast(GArrowChunkedArray*)indices.cPtr(No.Dup) : null, options ? cast(GArrowTakeOptions*)options.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!ChunkedArray(cast(GArrowChunkedArray*)_cretval, Yes.Take);
    return _retval;
  }

  string toString_()
  {
    char* _cretval;
    GError *_err;
    _cretval = garrow_chunked_array_to_string(cast(GArrowChunkedArray*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }
}
