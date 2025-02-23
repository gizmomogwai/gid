module gobject.param_spec_double;

import gid.gid;
import gobject.c.functions;
import gobject.c.types;
import gobject.param_spec;
import gobject.types;

/**
 * A #GParamSpec derived structure that contains the meta data for double properties.
 */
class ParamSpecDouble : ParamSpec
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecDouble");

    super(cast(GParamSpec*)ptr, take);
  }
}
