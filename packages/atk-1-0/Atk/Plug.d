module Atk.Plug;

import Atk.Component;
import Atk.ComponentT;
import Atk.ObjectAtk;
import Atk.Types;
import Atk.c.functions;
import Atk.c.types;
import Gid.gid;

/**
 * Toplevel for embedding into other processes
 * See class@AtkSocket
 */
class Plug : ObjectAtk, Component
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import Gid.loader : gidSymbolNotFound;
    return cast(void function())atk_plug_get_type != &gidSymbolNotFound ? atk_plug_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ComponentT!();

  /**
   * Creates a new #AtkPlug instance.
   * Returns: the newly created #AtkPlug
   */
  this()
  {
    AtkObject* _cretval;
    _cretval = atk_plug_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Gets the unique ID of an #AtkPlug object, which can be used to
   * embed inside of an #AtkSocket using [Atk.Socket.embed].
   * Internally, this calls a class function that should be registered
   * by the IPC layer $(LPAREN)usually at-spi2-atk$(RPAREN). The implementor of an
   * #AtkPlug object should call this function $(LPAREN)after atk-bridge is
   * loaded$(RPAREN) and pass the value to the process implementing the
   * #AtkSocket, so it could embed the plug.
   * Returns: the unique ID for the plug
   */
  string getId()
  {
    char* _cretval;
    _cretval = atk_plug_get_id(cast(AtkPlug*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Sets child as accessible child of plug and plug as accessible parent of
   * child. child can be NULL.
   * In some cases, one can not use the AtkPlug type directly as accessible
   * object for the toplevel widget of the application. For instance in the gtk
   * case, GtkPlugAccessible can not inherit both from GtkWindowAccessible and
   * from AtkPlug. In such a case, one can create, in addition to the standard
   * accessible object for the toplevel widget, an AtkPlug object, and make the
   * former the child of the latter by calling [Atk.Plug.setChild].
   * Params:
   *   child = an #AtkObject to be set as accessible child of plug.
   */
  void setChild(ObjectAtk child)
  {
    atk_plug_set_child(cast(AtkPlug*)cPtr, child ? cast(AtkObject*)child.cPtr(No.Dup) : null);
  }
}
