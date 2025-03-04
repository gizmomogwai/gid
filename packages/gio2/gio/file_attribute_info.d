module gio.file_attribute_info;

import gid.global;
import gio.c.functions;
import gio.c.types;
import gio.types;

/**
 * Information about a specific attribute.
 */
class FileAttributeInfo
{
  GFileAttributeInfo cInstance;

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileAttributeInfo");

    cInstance = *cast(GFileAttributeInfo*)ptr;

    if (take)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string name()
  {
    return (cast(GFileAttributeInfo*)cPtr).name.fromCString(No.Free);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GFileAttributeInfo*)cPtr).name);
    (cast(GFileAttributeInfo*)cPtr).name = propval.toCString(Yes.Alloc);
  }

  @property FileAttributeType type()
  {
    return cast(FileAttributeType)(cast(GFileAttributeInfo*)cPtr).type;
  }

  @property void type(FileAttributeType propval)
  {
    (cast(GFileAttributeInfo*)cPtr).type = cast(GFileAttributeType)propval;
  }

  @property FileAttributeInfoFlags flags()
  {
    return cast(FileAttributeInfoFlags)(cast(GFileAttributeInfo*)cPtr).flags;
  }

  @property void flags(FileAttributeInfoFlags propval)
  {
    (cast(GFileAttributeInfo*)cPtr).flags = cast(GFileAttributeInfoFlags)propval;
  }
}
