module Gsk.global;

import gid.global;
import gobject.value;
import gsk.c.functions;
import gsk.c.types;
import gsk.render_node;
import gsk.types;


/**
 * Retrieves the `GskRenderNode` stored inside the given `value`, and acquires
 * a reference to it.
 * Params:
 *   value = a [gobject.value.Value] initialized with type `GSK_TYPE_RENDER_NODE`
 * Returns: a `GskRenderNode`
 */
RenderNode valueDupRenderNode(Value value)
{
  GskRenderNode* _cretval;
  _cretval = gsk_value_dup_render_node(value ? cast(GValue*)value.cPtr(No.Dup) : null);
  auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Retrieves the `GskRenderNode` stored inside the given `value`.
 * Params:
 *   value = a `GValue` initialized with type `GSK_TYPE_RENDER_NODE`
 * Returns: a `GskRenderNode`
 */
RenderNode valueGetRenderNode(Value value)
{
  GskRenderNode* _cretval;
  _cretval = gsk_value_get_render_node(value ? cast(GValue*)value.cPtr(No.Dup) : null);
  auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, No.Take) : null;
  return _retval;
}

/**
 * Stores the given `GskRenderNode` inside `value`.
 * The [gobject.value.Value] will acquire a reference to the `node`.
 * Params:
 *   value = a [gobject.value.Value] initialized with type `GSK_TYPE_RENDER_NODE`
 *   node = a `GskRenderNode`
 */
void valueSetRenderNode(Value value, RenderNode node)
{
  gsk_value_set_render_node(value ? cast(GValue*)value.cPtr(No.Dup) : null, node ? cast(GskRenderNode*)node.cPtr(No.Dup) : null);
}

/**
 * Stores the given `GskRenderNode` inside `value`.
 * This function transfers the ownership of the `node` to the `GValue`.
 * Params:
 *   value = a [gobject.value.Value] initialized with type `GSK_TYPE_RENDER_NODE`
 *   node = a `GskRenderNode`
 */
void valueTakeRenderNode(Value value, RenderNode node)
{
  gsk_value_take_render_node(value ? cast(GValue*)value.cPtr(No.Dup) : null, node ? cast(GskRenderNode*)node.cPtr(Yes.Dup) : null);
}
