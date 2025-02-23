module gobject.param_spec_override;

import gid.gid;
import gobject.c.functions;
import gobject.c.types;
import gobject.param_spec;
import gobject.types;

/**
 * A #GParamSpec derived structure that redirects operations to
 * other types of #GParamSpec.
 * All operations other than getting or setting the value are redirected,
 * including accessing the nick and blurb, validating a value, and so
 * forth.
 * See [GObject.ParamSpec.getRedirectTarget] for retrieving the overridden
 * property. #GParamSpecOverride is used in implementing
 * [GObject.ObjectClass.overrideProperty], and will not be directly useful
 * unless you are implementing a new base type similar to GObject.
 */
class ParamSpecOverride : ParamSpec
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecOverride");

    super(cast(GParamSpec*)ptr, take);
  }
}
