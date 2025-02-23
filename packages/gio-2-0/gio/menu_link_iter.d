module gio.menu_link_iter;

import gid.gid;
import gio.c.functions;
import gio.c.types;
import gio.menu_model;
import gio.types;
import gobject.object;

/**
 * #GMenuLinkIter is an opaque structure type.  You must access it using
 * the functions below.
 */
class MenuLinkIter : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_menu_link_iter_get_type != &gidSymbolNotFound ? g_menu_link_iter_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the name of the link at the current iterator position.
   * The iterator is not advanced.
   * Returns: the type of the link
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_menu_link_iter_get_name(cast(GMenuLinkIter*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * This function combines [Gio.MenuLinkIter.next] with
   * [Gio.MenuLinkIter.getName] and [Gio.MenuLinkIter.getValue].
   * First the iterator is advanced to the next $(LPAREN)possibly first$(RPAREN) link.
   * If that fails, then %FALSE is returned and there are no other effects.
   * If successful, out_link and value are set to the name and #GMenuModel
   * of the link that has just been advanced to.  At this point,
   * [Gio.MenuLinkIter.getName] and [Gio.MenuLinkIter.getValue] will return the
   * same values again.
   * The value returned in out_link remains valid for as long as the iterator
   * remains at the current position.  The value returned in value must
   * be unreffed using [GObject.ObjectG.unref] when it is no longer in use.
   * Params:
   *   outLink = the name of the link
   *   value = the linked #GMenuModel
   * Returns: %TRUE on success, or %FALSE if there is no additional link
   */
  bool getNext(out string outLink, out MenuModel value)
  {
    bool _retval;
    char* _outLink;
    GMenuModel* _value;
    _retval = g_menu_link_iter_get_next(cast(GMenuLinkIter*)cPtr, &_outLink, &_value);
    outLink = _outLink.fromCString(No.Free);
    value = new MenuModel(cast(void*)_value, Yes.Take);
    return _retval;
  }

  /**
   * Gets the linked #GMenuModel at the current iterator position.
   * The iterator is not advanced.
   * Returns: the #GMenuModel that is linked to
   */
  MenuModel getValue()
  {
    GMenuModel* _cretval;
    _cretval = g_menu_link_iter_get_value(cast(GMenuLinkIter*)cPtr);
    auto _retval = ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Attempts to advance the iterator to the next $(LPAREN)possibly first$(RPAREN)
   * link.
   * %TRUE is returned on success, or %FALSE if there are no more links.
   * You must call this function when you first acquire the iterator to
   * advance it to the first link $(LPAREN)and determine if the first link exists
   * at all$(RPAREN).
   * Returns: %TRUE on success, or %FALSE when there are no more links
   */
  bool next()
  {
    bool _retval;
    _retval = g_menu_link_iter_next(cast(GMenuLinkIter*)cPtr);
    return _retval;
  }
}
