module arrowflight.data_stream;

import arrowflight.c.functions;
import arrowflight.c.types;
import arrowflight.types;
import gid.global;
import gobject.object;

class DataStream : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gaflight_data_stream_get_type != &gidSymbolNotFound ? gaflight_data_stream_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }
}
