module gio.remote_action_group_interface;

import gid.gid;
import gio.c.functions;
import gio.c.types;
import gio.types;
import gobject.type_interface;

/**
 * The virtual function table for #GRemoteActionGroup.
 */
class RemoteActionGroupInterface
{
  GRemoteActionGroupInterface cInstance;

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.RemoteActionGroupInterface");

    cInstance = *cast(GRemoteActionGroupInterface*)ptr;

    if (take)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GRemoteActionGroupInterface*)cPtr).gIface);
  }

  alias ActivateActionFullFuncType = extern(C) void function(GRemoteActionGroup* remote, const(char)* actionName, VariantC* parameter, VariantC* platformData);

  @property ActivateActionFullFuncType activateActionFull()
  {
    return (cast(GRemoteActionGroupInterface*)cPtr).activateActionFull;
  }

  alias ChangeActionStateFullFuncType = extern(C) void function(GRemoteActionGroup* remote, const(char)* actionName, VariantC* value, VariantC* platformData);

  @property ChangeActionStateFullFuncType changeActionStateFull()
  {
    return (cast(GRemoteActionGroupInterface*)cPtr).changeActionStateFull;
  }
}
