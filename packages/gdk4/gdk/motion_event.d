module gdk.motion_event;

import gdk.c.functions;
import gdk.c.types;
import gdk.event;
import gdk.types;
import gid.global;

/**
 * An event related to a pointer or touch device motion.
 */
class MotionEvent : Event
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.MotionEvent");

    super(cast(GdkEvent*)ptr, take);
  }
}
