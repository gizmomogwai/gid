module gsk.glrenderer;

import gid.global;
import gsk.c.functions;
import gsk.c.types;
import gsk.renderer;
import gsk.types;

class GLRenderer : Renderer
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gsk_gl_renderer_get_type != &gidSymbolNotFound ? gsk_gl_renderer_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GskRenderer` using the new OpenGL renderer.
   * Returns: a new GL renderer
   */
  this()
  {
    GskRenderer* _cretval;
    _cretval = gsk_gl_renderer_new();
    this(_cretval, Yes.Take);
  }
}
