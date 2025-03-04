module gsk.fill_node;

import gid.global;
import gsk.c.functions;
import gsk.c.types;
import gsk.path;
import gsk.render_node;
import gsk.types;

/**
 * A render node filling the area given by [gsk.path.Path]
 * and [gsk.FillRule] with the child node.
 */
class FillNode : RenderNode
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.FillNode");

    super(cast(GskRenderNode*)ptr, take);
  }

  /**
   * Creates a `GskRenderNode` that will fill the child in the area
   * given by path and fill_rule.
   * Params:
   *   child = The node to fill the area with
   *   path = The path describing the area to fill
   *   fillRule = The fill rule to use
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode child, Path path, FillRule fillRule)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_fill_node_new(child ? cast(GskRenderNode*)child.cPtr(No.Dup) : null, path ? cast(GskPath*)path.cPtr(No.Dup) : null, fillRule);
    this(_cretval, No.Take);
  }

  /**
   * Gets the child node that is getting drawn by the given node.
   * Returns: The child that is getting drawn
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_fill_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Retrieves the fill rule used to determine how the path is filled.
   * Returns: a `GskFillRule`
   */
  FillRule getFillRule()
  {
    GskFillRule _cretval;
    _cretval = gsk_fill_node_get_fill_rule(cast(GskRenderNode*)cPtr);
    FillRule _retval = cast(FillRule)_cretval;
    return _retval;
  }

  /**
   * Retrieves the path used to describe the area filled with the contents of
   * the node.
   * Returns: a `GskPath`
   */
  Path getPath()
  {
    GskPath* _cretval;
    _cretval = gsk_fill_node_get_path(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Path(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }
}
