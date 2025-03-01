module arrowflight.do_put_result;

import arrowflight.c.functions;
import arrowflight.c.types;
import arrowflight.types;
import gid.global;
import gobject.object;

class DoPutResult : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gaflight_do_put_result_get_type != &gidSymbolNotFound ? gaflight_do_put_result_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }
}
