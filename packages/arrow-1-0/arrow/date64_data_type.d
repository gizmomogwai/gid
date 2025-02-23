module arrow.date64_data_type;

import arrow.c.functions;
import arrow.c.types;
import arrow.temporal_data_type;
import arrow.types;
import gid.gid;

class Date64DataType : TemporalDataType
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_date64_data_type_get_type != &gidSymbolNotFound ? garrow_date64_data_type_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GArrowDate64DataType* _cretval;
    _cretval = garrow_date64_data_type_new();
    this(_cretval, Yes.Take);
  }
}
