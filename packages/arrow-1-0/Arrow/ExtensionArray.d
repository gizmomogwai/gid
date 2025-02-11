module Arrow.ExtensionArray;

import Arrow.Array;
import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import GObject.ObjectG;
import Gid.gid;

class ExtensionArray : Array
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return garrow_extension_array_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  Array getStorage()
  {
    GArrowArray* _cretval;
    _cretval = garrow_extension_array_get_storage(cast(GArrowExtensionArray*)cPtr);
    auto _retval = ObjectG.getDObject!Array(cast(GArrowArray*)_cretval, Yes.Take);
    return _retval;
  }
}
