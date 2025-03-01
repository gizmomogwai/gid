module arrow.chunked_array_datum;

import arrow.c.functions;
import arrow.c.types;
import arrow.chunked_array;
import arrow.datum;
import arrow.types;
import gid.global;

class ChunkedArrayDatum : Datum
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_chunked_array_datum_get_type != &gidSymbolNotFound ? garrow_chunked_array_datum_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(ChunkedArray value)
  {
    GArrowChunkedArrayDatum* _cretval;
    _cretval = garrow_chunked_array_datum_new(value ? cast(GArrowChunkedArray*)value.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }
}
