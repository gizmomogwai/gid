module gsk.shadow_node;

import gid.global;
import gsk.c.functions;
import gsk.c.types;
import gsk.render_node;
import gsk.shadow;
import gsk.types;

/**
 * A render node drawing one or more shadows behind its single child node.
 */
class ShadowNode : RenderNode
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ShadowNode");

    super(cast(GskRenderNode*)ptr, take);
  }

  /**
   * Retrieves the child `GskRenderNode` of the shadow node.
   * Returns: the child render node
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_shadow_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Retrieves the number of shadows in the node.
   * Returns: the number of shadows.
   */
  size_t getNShadows()
  {
    size_t _retval;
    _retval = gsk_shadow_node_get_n_shadows(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the shadow data at the given index i.
   * Params:
   *   i = the given index
   * Returns: the shadow data
   */
  Shadow getShadow(size_t i)
  {
    const(GskShadow)* _cretval;
    _cretval = gsk_shadow_node_get_shadow(cast(GskRenderNode*)cPtr, i);
    auto _retval = _cretval ? new Shadow(cast(GskShadow*)_cretval) : null;
    return _retval;
  }
}
