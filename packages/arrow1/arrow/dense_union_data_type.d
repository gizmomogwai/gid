module arrow.dense_union_data_type;

import arrow.c.functions;
import arrow.c.types;
import arrow.field;
import arrow.types;
import arrow.union_data_type;
import gid.global;

class DenseUnionDataType : UnionDataType
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_dense_union_data_type_get_type != &gidSymbolNotFound ? garrow_dense_union_data_type_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Field[] fields, byte[] typeCodes)
  {
    GArrowDenseUnionDataType* _cretval;
    auto _fields = gListFromD!(Field)(fields);
    scope(exit) containerFree!(GList*, Field, GidOwnership.None)(_fields);
    size_t _nTypeCodes;
    if (typeCodes)
      _nTypeCodes = cast(size_t)typeCodes.length;

    auto _typeCodes = cast(byte*)typeCodes.ptr;
    _cretval = garrow_dense_union_data_type_new(_fields, _typeCodes, _nTypeCodes);
    this(_cretval, Yes.Take);
  }
}
