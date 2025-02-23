module gio.emblemed_icon;

import gid.gid;
import gio.c.functions;
import gio.c.types;
import gio.emblem;
import gio.icon;
import gio.icon_mixin;
import gio.types;
import gobject.object;

/**
 * `GEmblemedIcon` is an implementation of [Gio.Icon] that supports
 * adding an emblem to an icon. Adding multiple emblems to an
 * icon is ensured via [Gio.EmblemedIcon.addEmblem].
 * Note that `GEmblemedIcon` allows no control over the position
 * of the emblems. See also [Gio.Emblem] for more information.
 */
class EmblemedIcon : ObjectG, Icon
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_emblemed_icon_get_type != &gidSymbolNotFound ? g_emblemed_icon_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin IconT!();

  /**
   * Creates a new emblemed icon for icon with the emblem emblem.
   * Params:
   *   icon = a #GIcon
   *   emblem = a #GEmblem, or %NULL
   * Returns: a new #GIcon
   */
  this(Icon icon, Emblem emblem)
  {
    GIcon* _cretval;
    _cretval = g_emblemed_icon_new(icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(No.Dup) : null, emblem ? cast(GEmblem*)emblem.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * Adds emblem to the #GList of #GEmblems.
   * Params:
   *   emblem = a #GEmblem
   */
  void addEmblem(Emblem emblem)
  {
    g_emblemed_icon_add_emblem(cast(GEmblemedIcon*)cPtr, emblem ? cast(GEmblem*)emblem.cPtr(No.Dup) : null);
  }

  /**
   * Removes all the emblems from icon.
   */
  void clearEmblems()
  {
    g_emblemed_icon_clear_emblems(cast(GEmblemedIcon*)cPtr);
  }

  /**
   * Gets the list of emblems for the icon.
   * Returns: a #GList of
   *   #GEmblems that is owned by emblemed
   */
  Emblem[] getEmblems()
  {
    GList* _cretval;
    _cretval = g_emblemed_icon_get_emblems(cast(GEmblemedIcon*)cPtr);
    auto _retval = gListToD!(Emblem, GidOwnership.None)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Gets the main icon for emblemed.
   * Returns: a #GIcon that is owned by emblemed
   */
  Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_emblemed_icon_get_icon(cast(GEmblemedIcon*)cPtr);
    auto _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, No.Take);
    return _retval;
  }
}
