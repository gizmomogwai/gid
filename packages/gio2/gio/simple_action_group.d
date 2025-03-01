module gio.simple_action_group;

import gid.global;
import gio.action;
import gio.action_group;
import gio.action_group_mixin;
import gio.action_map;
import gio.action_map_mixin;
import gio.action_mixin;
import gio.c.functions;
import gio.c.types;
import gio.types;
import gobject.object;

/**
 * `GSimpleActionGroup` is a hash table filled with [gio.action.Action] objects,
 * implementing the [gio.action_group.ActionGroup] and [gio.action_map.ActionMap]
 * interfaces.
 */
class SimpleActionGroup : ObjectG, ActionGroup, ActionMap
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_simple_action_group_get_type != &gidSymbolNotFound ? g_simple_action_group_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionGroupT!();
  mixin ActionMapT!();

  /**
   * Creates a new, empty, #GSimpleActionGroup.
   * Returns: a new #GSimpleActionGroup
   */
  this()
  {
    GSimpleActionGroup* _cretval;
    _cretval = g_simple_action_group_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Adds an action to the action group.
   * If the action group already contains an action with the same name as
   * action then the old action is dropped from the group.
   * The action group takes its own reference on action.
   * Params:
   *   action = a #GAction

   * Deprecated: Use [gio.action_map.ActionMap.addAction]
   */
  void insert(Action action)
  {
    g_simple_action_group_insert(cast(GSimpleActionGroup*)cPtr, action ? cast(GAction*)(cast(ObjectG)action).cPtr(No.Dup) : null);
  }

  /**
   * Looks up the action with the name action_name in the group.
   * If no such action exists, returns %NULL.
   * Params:
   *   actionName = the name of an action
   * Returns: a #GAction, or %NULL

   * Deprecated: Use [gio.action_map.ActionMap.lookupAction]
   */
  Action lookup(string actionName)
  {
    GAction* _cretval;
    const(char)* _actionName = actionName.toCString(No.Alloc);
    _cretval = g_simple_action_group_lookup(cast(GSimpleActionGroup*)cPtr, _actionName);
    auto _retval = ObjectG.getDObject!Action(cast(GAction*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Removes the named action from the action group.
   * If no action of this name is in the group then nothing happens.
   * Params:
   *   actionName = the name of the action

   * Deprecated: Use [gio.action_map.ActionMap.removeAction]
   */
  void remove(string actionName)
  {
    const(char)* _actionName = actionName.toCString(No.Alloc);
    g_simple_action_group_remove(cast(GSimpleActionGroup*)cPtr, _actionName);
  }
}
