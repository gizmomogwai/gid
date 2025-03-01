module gio.themed_icon;

import gid.global;
import gio.c.functions;
import gio.c.types;
import gio.icon;
import gio.icon_mixin;
import gio.types;
import gobject.object;

/**
 * `GThemedIcon` is an implementation of [gio.icon.Icon] that supports icon
 * themes.
 * `GThemedIcon` contains a list of all of the icons present in an icon
 * theme, so that icons can be looked up quickly. `GThemedIcon` does
 * not provide actual pixmaps for icons, just the icon names.
 * Ideally something like method@Gtk.IconTheme.choose_icon should be used to
 * resolve the list of names so that fallback icons work nicely with
 * themes that inherit other themes.
 */
class ThemedIcon : ObjectG, Icon
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_themed_icon_get_type != &gidSymbolNotFound ? g_themed_icon_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin IconT!();

  /**
   * Creates a new themed icon for iconname.
   * Params:
   *   iconname = a string containing an icon name.
   * Returns: a new #GThemedIcon.
   */
  this(string iconname)
  {
    GIcon* _cretval;
    const(char)* _iconname = iconname.toCString(No.Alloc);
    _cretval = g_themed_icon_new(_iconname);
    this(_cretval, Yes.Take);
  }

  /**
   * Creates a new themed icon for iconnames.
   * Params:
   *   iconnames = an array of strings containing icon names.
   * Returns: a new #GThemedIcon
   */
  static ThemedIcon newFromNames(string[] iconnames)
  {
    GIcon* _cretval;
    int _len;
    if (iconnames)
      _len = cast(int)iconnames.length;

    char*[] _tmpiconnames;
    foreach (s; iconnames)
      _tmpiconnames ~= s.toCString(No.Alloc);
    char** _iconnames = _tmpiconnames.ptr;
    _cretval = g_themed_icon_new_from_names(_iconnames, _len);
    auto _retval = ObjectG.getDObject!ThemedIcon(cast(GIcon*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Creates a new themed icon for iconname, and all the names
   * that can be created by shortening iconname at '-' characters.
   * In the following example, icon1 and icon2 are equivalent:
   * |[<!-- language\="C" -->
   * const char *names[] \= {
   * "gnome-dev-cdrom-audio",
   * "gnome-dev-cdrom",
   * "gnome-dev",
   * "gnome"
   * };
   * icon1 \= g_themed_icon_new_from_names $(LPAREN)names, 4$(RPAREN);
   * icon2 \= g_themed_icon_new_with_default_fallbacks $(LPAREN)"gnome-dev-cdrom-audio"$(RPAREN);
   * ]|
   * Params:
   *   iconname = a string containing an icon name
   * Returns: a new #GThemedIcon.
   */
  static ThemedIcon newWithDefaultFallbacks(string iconname)
  {
    GIcon* _cretval;
    const(char)* _iconname = iconname.toCString(No.Alloc);
    _cretval = g_themed_icon_new_with_default_fallbacks(_iconname);
    auto _retval = ObjectG.getDObject!ThemedIcon(cast(GIcon*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Append a name to the list of icons from within icon.
   * Note that doing so invalidates the hash computed by prior calls
   * to [gio.icon.Icon.hash].
   * Params:
   *   iconname = name of icon to append to list of icons from within icon.
   */
  void appendName(string iconname)
  {
    const(char)* _iconname = iconname.toCString(No.Alloc);
    g_themed_icon_append_name(cast(GThemedIcon*)cPtr, _iconname);
  }

  /**
   * Gets the names of icons from within icon.
   * Returns: a list of icon names.
   */
  string[] getNames()
  {
    const(char*)* _cretval;
    _cretval = g_themed_icon_get_names(cast(GThemedIcon*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(No.Free);
    }
    return _retval;
  }

  /**
   * Prepend a name to the list of icons from within icon.
   * Note that doing so invalidates the hash computed by prior calls
   * to [gio.icon.Icon.hash].
   * Params:
   *   iconname = name of icon to prepend to list of icons from within icon.
   */
  void prependName(string iconname)
  {
    const(char)* _iconname = iconname.toCString(No.Alloc);
    g_themed_icon_prepend_name(cast(GThemedIcon*)cPtr, _iconname);
  }
}
