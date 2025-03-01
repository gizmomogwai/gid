module gsk.cairo_node;

import cairo.context;
import cairo.surface;
import gid.global;
import graphene.rect;
import gsk.c.functions;
import gsk.c.types;
import gsk.render_node;
import gsk.types;

/**
 * A render node for a Cairo surface.
 */
class CairoNode : RenderNode
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.CairoNode");

    super(cast(GskRenderNode*)ptr, take);
  }

  /**
   * Creates a `GskRenderNode` that will render a cairo surface
   * into the area given by bounds.
   * You can draw to the cairo surface using [gsk.cairo_node.CairoNode.getDrawContext].
   * Params:
   *   bounds = the rectangle to render to
   * Returns: A new `GskRenderNode`
   */
  this(Rect bounds)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_cairo_node_new(bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * Creates a Cairo context for drawing using the surface associated
   * to the render node.
   * If no surface exists yet, a surface will be created optimized for
   * rendering to renderer.
   * Returns: a Cairo context used for drawing; use
   *   [cairo.global.destroy] when done drawing
   */
  Context getDrawContext()
  {
    cairo_t* _cretval;
    _cretval = gsk_cairo_node_get_draw_context(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Context(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Retrieves the Cairo surface used by the render node.
   * Returns: a Cairo surface
   */
  Surface getSurface()
  {
    cairo_surface_t* _cretval;
    _cretval = gsk_cairo_node_get_surface(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Surface(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }
}
