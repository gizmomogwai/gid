module Arrow.RecordBatchWriter;

import Arrow.RecordBatch;
import Arrow.Table;
import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;

class RecordBatchWriter : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return garrow_record_batch_writer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  bool close()
  {
    bool _retval;
    GError *_err;
    _retval = garrow_record_batch_writer_close(cast(GArrowRecordBatchWriter*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  bool isClosed()
  {
    bool _retval;
    _retval = garrow_record_batch_writer_is_closed(cast(GArrowRecordBatchWriter*)cPtr);
    return _retval;
  }

  bool writeRecordBatch(RecordBatch recordBatch)
  {
    bool _retval;
    GError *_err;
    _retval = garrow_record_batch_writer_write_record_batch(cast(GArrowRecordBatchWriter*)cPtr, recordBatch ? cast(GArrowRecordBatch*)recordBatch.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  bool writeTable(Table table)
  {
    bool _retval;
    GError *_err;
    _retval = garrow_record_batch_writer_write_table(cast(GArrowRecordBatchWriter*)cPtr, table ? cast(GArrowTable*)table.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
