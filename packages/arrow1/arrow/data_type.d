module arrow.data_type;

import arrow.c.functions;
import arrow.c.types;
import arrow.types;
import gid.global;
import glib.error;
import gobject.object;

class DataType : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_data_type_get_type != &gidSymbolNotFound ? garrow_data_type_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  static DataType import_(void* cAbiSchema)
  {
    GArrowDataType* _cretval;
    GError *_err;
    _cretval = garrow_data_type_import(cAbiSchema, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!DataType(cast(GArrowDataType*)_cretval, Yes.Take);
    return _retval;
  }

  bool equal(DataType otherDataType)
  {
    bool _retval;
    _retval = garrow_data_type_equal(cast(GArrowDataType*)cPtr, otherDataType ? cast(GArrowDataType*)otherDataType.cPtr(No.Dup) : null);
    return _retval;
  }

  void* export_()
  {
    GError *_err;
    auto _retval = garrow_data_type_export(cast(GArrowDataType*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  Type getId()
  {
    GArrowType _cretval;
    _cretval = garrow_data_type_get_id(cast(GArrowDataType*)cPtr);
    Type _retval = cast(Type)_cretval;
    return _retval;
  }

  string getName()
  {
    char* _cretval;
    _cretval = garrow_data_type_get_name(cast(GArrowDataType*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  string toString_()
  {
    char* _cretval;
    _cretval = garrow_data_type_to_string(cast(GArrowDataType*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }
}
