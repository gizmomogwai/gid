module gdk.proximity_event;

import gdk.c.functions;
import gdk.c.types;
import gdk.event;
import gdk.types;
import gid.global;

/**
 * An event related to the proximity of a tool to a device.
 */
class ProximityEvent : Event
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.ProximityEvent");

    super(cast(GdkEvent*)ptr, take);
  }
}
