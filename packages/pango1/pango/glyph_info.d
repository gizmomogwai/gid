module pango.glyph_info;

import gid.global;
import pango.c.functions;
import pango.c.types;
import pango.types;

/**
 * A `PangoGlyphInfo` structure represents a single glyph with
 * positioning information and visual attributes.
 */
class GlyphInfo
{
  PangoGlyphInfo cInstance;

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.GlyphInfo");

    cInstance = *cast(PangoGlyphInfo*)ptr;

    if (take)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Glyph glyph()
  {
    return (cast(PangoGlyphInfo*)cPtr).glyph;
  }

  @property void glyph(Glyph propval)
  {
    (cast(PangoGlyphInfo*)cPtr).glyph = propval;
  }

  @property GlyphGeometry geometry()
  {
    return (cast(PangoGlyphInfo*)cPtr).geometry;
  }

  @property void geometry(GlyphGeometry propval)
  {
    (cast(PangoGlyphInfo*)cPtr).geometry = propval;
  }

  @property GlyphVisAttr attr()
  {
    return (cast(PangoGlyphInfo*)cPtr).attr;
  }

  @property void attr(GlyphVisAttr propval)
  {
    (cast(PangoGlyphInfo*)cPtr).attr = propval;
  }
}
