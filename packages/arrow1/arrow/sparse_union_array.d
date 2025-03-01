module arrow.sparse_union_array;

import arrow.array;
import arrow.c.functions;
import arrow.c.types;
import arrow.int8_array;
import arrow.sparse_union_data_type;
import arrow.types;
import arrow.union_array;
import gid.global;
import glib.error;
import gobject.object;

class SparseUnionArray : UnionArray
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_sparse_union_array_get_type != &gidSymbolNotFound ? garrow_sparse_union_array_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Int8Array typeIds, Array[] fields)
  {
    GArrowSparseUnionArray* _cretval;
    auto _fields = gListFromD!(Array)(fields);
    scope(exit) containerFree!(GList*, Array, GidOwnership.None)(_fields);
    GError *_err;
    _cretval = garrow_sparse_union_array_new(typeIds ? cast(GArrowInt8Array*)typeIds.cPtr(No.Dup) : null, _fields, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, Yes.Take);
  }

  static SparseUnionArray newDataType(SparseUnionDataType dataType, Int8Array typeIds, Array[] fields)
  {
    GArrowSparseUnionArray* _cretval;
    auto _fields = gListFromD!(Array)(fields);
    scope(exit) containerFree!(GList*, Array, GidOwnership.None)(_fields);
    GError *_err;
    _cretval = garrow_sparse_union_array_new_data_type(dataType ? cast(GArrowSparseUnionDataType*)dataType.cPtr(No.Dup) : null, typeIds ? cast(GArrowInt8Array*)typeIds.cPtr(No.Dup) : null, _fields, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!SparseUnionArray(cast(GArrowSparseUnionArray*)_cretval, Yes.Take);
    return _retval;
  }
}
