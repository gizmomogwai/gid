module Arrow.UnionDataType;

import Arrow.DataType;
import Arrow.Field;
import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import GObject.ObjectG;
import Gid.gid;

class UnionDataType : DataType
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return garrow_union_data_type_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  Field getField(int i)
  {
    GArrowField* _cretval;
    _cretval = garrow_union_data_type_get_field(cast(GArrowUnionDataType*)cPtr, i);
    auto _retval = ObjectG.getDObject!Field(cast(GArrowField*)_cretval, Yes.Take);
    return _retval;
  }

  Field[] getFields()
  {
    GList* _cretval;
    _cretval = garrow_union_data_type_get_fields(cast(GArrowUnionDataType*)cPtr);
    auto _retval = gListToD!(Field, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  int getNFields()
  {
    int _retval;
    _retval = garrow_union_data_type_get_n_fields(cast(GArrowUnionDataType*)cPtr);
    return _retval;
  }

  byte[] getTypeCodes()
  {
    byte* _cretval;
    size_t _cretlength;
    _cretval = garrow_union_data_type_get_type_codes(cast(GArrowUnionDataType*)cPtr, &_cretlength);
    byte[] _retval;

    if (_cretval)
    {
      _retval = cast(byte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }
}
