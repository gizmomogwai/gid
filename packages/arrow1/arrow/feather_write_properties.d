module arrow.feather_write_properties;

import arrow.c.functions;
import arrow.c.types;
import arrow.types;
import gid.global;
import gobject.object;

class FeatherWriteProperties : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_feather_write_properties_get_type != &gidSymbolNotFound ? garrow_feather_write_properties_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GArrowFeatherWriteProperties* _cretval;
    _cretval = garrow_feather_write_properties_new();
    this(_cretval, Yes.Take);
  }
}
