module arrow.struct_data_type;

import arrow.c.functions;
import arrow.c.types;
import arrow.data_type;
import arrow.field;
import arrow.types;
import gid.global;
import gobject.object;

class StructDataType : DataType
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_struct_data_type_get_type != &gidSymbolNotFound ? garrow_struct_data_type_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Field[] fields)
  {
    GArrowStructDataType* _cretval;
    auto _fields = gListFromD!(Field)(fields);
    scope(exit) containerFree!(GList*, Field, GidOwnership.None)(_fields);
    _cretval = garrow_struct_data_type_new(_fields);
    this(_cretval, Yes.Take);
  }

  Field getField(int i)
  {
    GArrowField* _cretval;
    _cretval = garrow_struct_data_type_get_field(cast(GArrowStructDataType*)cPtr, i);
    auto _retval = ObjectG.getDObject!Field(cast(GArrowField*)_cretval, Yes.Take);
    return _retval;
  }

  Field getFieldByName(string name)
  {
    GArrowField* _cretval;
    const(char)* _name = name.toCString(No.Alloc);
    _cretval = garrow_struct_data_type_get_field_by_name(cast(GArrowStructDataType*)cPtr, _name);
    auto _retval = ObjectG.getDObject!Field(cast(GArrowField*)_cretval, Yes.Take);
    return _retval;
  }

  int getFieldIndex(string name)
  {
    int _retval;
    const(char)* _name = name.toCString(No.Alloc);
    _retval = garrow_struct_data_type_get_field_index(cast(GArrowStructDataType*)cPtr, _name);
    return _retval;
  }

  Field[] getFields()
  {
    GList* _cretval;
    _cretval = garrow_struct_data_type_get_fields(cast(GArrowStructDataType*)cPtr);
    auto _retval = gListToD!(Field, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  int getNFields()
  {
    int _retval;
    _retval = garrow_struct_data_type_get_n_fields(cast(GArrowStructDataType*)cPtr);
    return _retval;
  }
}
