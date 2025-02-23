module arrowdataset.dataset_factory;

import arrowdataset.c.functions;
import arrowdataset.c.types;
import arrowdataset.dataset;
import arrowdataset.finish_options;
import arrowdataset.types;
import gid.gid;
import glib.error;
import gobject.object;

class DatasetFactory : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gadataset_dataset_factory_get_type != &gidSymbolNotFound ? gadataset_dataset_factory_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  Dataset finish(FinishOptions options)
  {
    GADatasetDataset* _cretval;
    GError *_err;
    _cretval = gadataset_dataset_factory_finish(cast(GADatasetDatasetFactory*)cPtr, options ? cast(GADatasetFinishOptions*)options.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!Dataset(cast(GADatasetDataset*)_cretval, Yes.Take);
    return _retval;
  }
}
