module Arrow.ExecutePlanClass;

import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import GObject.ObjectClass;
import Gid.gid;

class ExecutePlanClass
{
  GArrowExecutePlanClass cInstance;

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Arrow.ExecutePlanClass");

    cInstance = *cast(GArrowExecutePlanClass*)ptr;

    if (take)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GArrowExecutePlanClass*)cPtr).parentClass);
  }
}
