module Atk.ActionIfaceProxy;

import GObject.ObjectG;
import Atk.Action;
import Atk.ActionT;

/// Proxy object for Atk.Action interface when a GObject has no applicable D binding
class ActionIfaceProxy : IfaceProxy, Action
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Action);
  }

  mixin ActionT!();
}
