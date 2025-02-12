module ArrowDataset.KeyValuePartitioningOptions;

import ArrowDataset.Types;
import ArrowDataset.c.functions;
import ArrowDataset.c.types;
import GObject.ObjectG;
import Gid.gid;

class KeyValuePartitioningOptions : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return gadataset_key_value_partitioning_options_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GADatasetKeyValuePartitioningOptions* _cretval;
    _cretval = gadataset_key_value_partitioning_options_new();
    this(_cretval, Yes.Take);
  }
}
