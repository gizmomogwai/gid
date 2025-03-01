module gio.action_map_mixin;

public import gio.action_map_iface_proxy;
public import gid.global;
public import gio.action;
public import gio.action_mixin;
public import gio.c.functions;
public import gio.c.types;
public import gio.types;
public import gobject.object;

/**
 * `GActionMap` is an interface for action containers.
 * The `GActionMap` interface is implemented by [gio.action_group.ActionGroup]
 * implementations that operate by containing a number of named
 * [gio.action.Action] instances, such as [gio.simple_action_group.SimpleActionGroup].
 * One useful application of this interface is to map the
 * names of actions from various action groups to unique,
 * prefixed names $(LPAREN)e.g. by prepending "app." or "win."$(RPAREN).
 * This is the motivation for the 'Map' part of the interface
 * name.
 */
template ActionMapT()
{

  /**
   * Adds an action to the action_map.
   * If the action map already contains an action with the same name
   * as action then the old action is dropped from the action map.
   * The action map takes its own reference on action.
   * Params:
   *   action = a #GAction
   */
  override void addAction(Action action)
  {
    g_action_map_add_action(cast(GActionMap*)cPtr, action ? cast(GAction*)(cast(ObjectG)action).cPtr(No.Dup) : null);
  }

  /**
   * Looks up the action with the name action_name in action_map.
   * If no such action exists, returns %NULL.
   * Params:
   *   actionName = the name of an action
   * Returns: a #GAction, or %NULL
   */
  override Action lookupAction(string actionName)
  {
    GAction* _cretval;
    const(char)* _actionName = actionName.toCString(No.Alloc);
    _cretval = g_action_map_lookup_action(cast(GActionMap*)cPtr, _actionName);
    auto _retval = ObjectG.getDObject!Action(cast(GAction*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Removes the named action from the action map.
   * If no action of this name is in the map then nothing happens.
   * Params:
   *   actionName = the name of the action
   */
  override void removeAction(string actionName)
  {
    const(char)* _actionName = actionName.toCString(No.Alloc);
    g_action_map_remove_action(cast(GActionMap*)cPtr, _actionName);
  }
}
