module pango.attr_string;

import gid.global;
import pango.attribute;
import pango.c.functions;
import pango.c.types;
import pango.types;

/**
 * The `PangoAttrString` structure is used to represent attributes with
 * a string value.
 */
class AttrString
{
  PangoAttrString cInstance;

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.AttrString");

    cInstance = *cast(PangoAttrString*)ptr;

    if (take)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Attribute attr()
  {
    return new Attribute(cast(PangoAttribute*)&(cast(PangoAttrString*)cPtr).attr);
  }

  @property string value()
  {
    return (cast(PangoAttrString*)cPtr).value.fromCString(No.Free);
  }

  @property void value(string propval)
  {
    safeFree(cast(void*)(cast(PangoAttrString*)cPtr).value);
    (cast(PangoAttrString*)cPtr).value = propval.toCString(Yes.Alloc);
  }
}
