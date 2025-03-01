module arrow.record_batch_stream_reader;

import arrow.c.functions;
import arrow.c.types;
import arrow.input_stream;
import arrow.record_batch_reader;
import arrow.types;
import gid.global;
import glib.error;

class RecordBatchStreamReader : RecordBatchReader
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_record_batch_stream_reader_get_type != &gidSymbolNotFound ? garrow_record_batch_stream_reader_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(InputStream stream)
  {
    GArrowRecordBatchStreamReader* _cretval;
    GError *_err;
    _cretval = garrow_record_batch_stream_reader_new(stream ? cast(GArrowInputStream*)stream.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, Yes.Take);
  }
}
