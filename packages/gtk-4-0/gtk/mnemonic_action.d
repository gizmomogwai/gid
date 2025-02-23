module gtk.mnemonic_action;

import gid.gid;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.shortcut_action;
import gtk.types;

/**
 * A `GtkShortcutAction` that calls [Gtk.Widget.mnemonicActivate].
 */
class MnemonicAction : ShortcutAction
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_mnemonic_action_get_type != &gidSymbolNotFound ? gtk_mnemonic_action_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the mnemonic action.
   * This is an action that calls [Gtk.Widget.mnemonicActivate]
   * on the given widget upon activation.
   * Returns: The mnemonic action
   */
  static MnemonicAction get()
  {
    GtkShortcutAction* _cretval;
    _cretval = gtk_mnemonic_action_get();
    auto _retval = ObjectG.getDObject!MnemonicAction(cast(GtkShortcutAction*)_cretval, No.Take);
    return _retval;
  }
}
