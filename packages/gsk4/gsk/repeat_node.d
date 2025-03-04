module gsk.repeat_node;

import gid.global;
import graphene.rect;
import gsk.c.functions;
import gsk.c.types;
import gsk.render_node;
import gsk.types;

/**
 * A render node repeating its single child node.
 */
class RepeatNode : RenderNode
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.RepeatNode");

    super(cast(GskRenderNode*)ptr, take);
  }

  /**
   * Creates a `GskRenderNode` that will repeat the drawing of child across
   * the given bounds.
   * Params:
   *   bounds = The bounds of the area to be painted
   *   child = The child to repeat
   *   childBounds = The area of the child to repeat or %NULL to
   *     use the child's bounds
   * Returns: A new `GskRenderNode`
   */
  this(Rect bounds, RenderNode child, Rect childBounds)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_repeat_node_new(bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null, child ? cast(GskRenderNode*)child.cPtr(No.Dup) : null, childBounds ? cast(graphene_rect_t*)childBounds.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * Retrieves the child of node.
   * Returns: a `GskRenderNode`
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_repeat_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Retrieves the bounding rectangle of the child of node.
   * Returns: a bounding rectangle
   */
  Rect getChildBounds()
  {
    const(graphene_rect_t)* _cretval;
    _cretval = gsk_repeat_node_get_child_bounds(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }
}
