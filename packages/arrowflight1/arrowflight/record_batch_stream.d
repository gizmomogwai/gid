module arrowflight.record_batch_stream;

import arrow.record_batch_reader;
import arrow.write_options;
import arrowflight.c.functions;
import arrowflight.c.types;
import arrowflight.data_stream;
import arrowflight.types;
import gid.global;

class RecordBatchStream : DataStream
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gaflight_record_batch_stream_get_type != &gidSymbolNotFound ? gaflight_record_batch_stream_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(RecordBatchReader reader, WriteOptions options)
  {
    GAFlightRecordBatchStream* _cretval;
    _cretval = gaflight_record_batch_stream_new(reader ? cast(GArrowRecordBatchReader*)reader.cPtr(No.Dup) : null, options ? cast(GArrowWriteOptions*)options.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }
}
