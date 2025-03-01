module glib.test_log_msg;

import gid.global;
import glib.c.functions;
import glib.c.types;
import glib.types;

class TestLogMsg
{
  GTestLogMsg cInstance;

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TestLogMsg");

    cInstance = *cast(GTestLogMsg*)ptr;

    if (take)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }
}
