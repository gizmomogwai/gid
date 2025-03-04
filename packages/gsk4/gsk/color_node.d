module gsk.color_node;

import gdk.rgba;
import gid.global;
import graphene.rect;
import gsk.c.functions;
import gsk.c.types;
import gsk.render_node;
import gsk.types;

/**
 * A render node for a solid color.
 */
class ColorNode : RenderNode
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ColorNode");

    super(cast(GskRenderNode*)ptr, take);
  }

  /**
   * Creates a `GskRenderNode` that will render the color specified by rgba into
   * the area given by bounds.
   * Params:
   *   rgba = a `GdkRGBA` specifying a color
   *   bounds = the rectangle to render the color into
   * Returns: A new `GskRenderNode`
   */
  this(RGBA rgba, Rect bounds)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_color_node_new(rgba ? cast(GdkRGBA*)rgba.cPtr(No.Dup) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * Retrieves the color of the given node.
   * Returns: the color of the node
   */
  RGBA getColor()
  {
    const(GdkRGBA)* _cretval;
    _cretval = gsk_color_node_get_color(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RGBA(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }
}
