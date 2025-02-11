module Arrow.NullArrayBuilderClass;

import Arrow.ArrayBuilderClass;
import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import Gid.gid;

class NullArrayBuilderClass
{
  GArrowNullArrayBuilderClass cInstance;

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Arrow.NullArrayBuilderClass");

    cInstance = *cast(GArrowNullArrayBuilderClass*)ptr;

    if (take)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ArrayBuilderClass parentClass()
  {
    return new ArrayBuilderClass(cast(GArrowArrayBuilderClass*)&(cast(GArrowNullArrayBuilderClass*)cPtr).parentClass);
  }
}
