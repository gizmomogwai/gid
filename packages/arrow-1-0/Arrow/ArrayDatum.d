module Arrow.ArrayDatum;

import Arrow.Array;
import Arrow.Datum;
import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import Gid.gid;

class ArrayDatum : Datum
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return garrow_array_datum_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Array value)
  {
    GArrowArrayDatum* _cretval;
    _cretval = garrow_array_datum_new(value ? cast(GArrowArray*)value.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }
}
