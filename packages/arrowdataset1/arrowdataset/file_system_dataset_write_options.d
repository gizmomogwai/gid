module arrowdataset.file_system_dataset_write_options;

import arrowdataset.c.functions;
import arrowdataset.c.types;
import arrowdataset.types;
import gid.global;
import gobject.object;

class FileSystemDatasetWriteOptions : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gadataset_file_system_dataset_write_options_get_type != &gidSymbolNotFound ? gadataset_file_system_dataset_write_options_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GADatasetFileSystemDatasetWriteOptions* _cretval;
    _cretval = gadataset_file_system_dataset_write_options_new();
    this(_cretval, Yes.Take);
  }
}
