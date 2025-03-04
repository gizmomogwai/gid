module gsk.cross_fade_node;

import gid.global;
import gsk.c.functions;
import gsk.c.types;
import gsk.render_node;
import gsk.types;

/**
 * A render node cross fading between two child nodes.
 */
class CrossFadeNode : RenderNode
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.CrossFadeNode");

    super(cast(GskRenderNode*)ptr, take);
  }

  /**
   * Creates a `GskRenderNode` that will do a cross-fade between start and end.
   * Params:
   *   start = The start node to be drawn
   *   end = The node to be cross_fadeed onto the start node
   *   progress = How far the fade has progressed from start to end. The value will
   *     be clamped to the range [0 ... 1]
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode start, RenderNode end, float progress)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_cross_fade_node_new(start ? cast(GskRenderNode*)start.cPtr(No.Dup) : null, end ? cast(GskRenderNode*)end.cPtr(No.Dup) : null, progress);
    this(_cretval, Yes.Take);
  }

  /**
   * Retrieves the child `GskRenderNode` at the end of the cross-fade.
   * Returns: a `GskRenderNode`
   */
  RenderNode getEndChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_cross_fade_node_get_end_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Retrieves the progress value of the cross fade.
   * Returns: the progress value, between 0 and 1
   */
  float getProgress()
  {
    float _retval;
    _retval = gsk_cross_fade_node_get_progress(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the child `GskRenderNode` at the beginning of the cross-fade.
   * Returns: a `GskRenderNode`
   */
  RenderNode getStartChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_cross_fade_node_get_start_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, No.Take) : null;
    return _retval;
  }
}
