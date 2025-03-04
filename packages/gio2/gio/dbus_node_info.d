module gio.dbus_node_info;

import gid.global;
import gio.c.functions;
import gio.c.types;
import gio.dbus_interface_info;
import gio.types;
import glib.error;
import glib.string_;
import gobject.boxed;

/**
 * Information about nodes in a remote object hierarchy.
 */
class DBusNodeInfo : Boxed
{

  this()
  {
    super(safeMalloc(GDBusNodeInfo.sizeof), Yes.Take);
  }

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  void* cPtr(Flag!"Dup" dup = No.Dup)
  {
    return dup ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_dbus_node_info_get_type != &gidSymbolNotFound ? g_dbus_node_info_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int refCount()
  {
    return (cast(GDBusNodeInfo*)cPtr).refCount;
  }

  @property void refCount(int propval)
  {
    (cast(GDBusNodeInfo*)cPtr).refCount = propval;
  }

  @property string path()
  {
    return (cast(GDBusNodeInfo*)cPtr).path.fromCString(No.Free);
  }

  @property void path(string propval)
  {
    safeFree(cast(void*)(cast(GDBusNodeInfo*)cPtr).path);
    (cast(GDBusNodeInfo*)cPtr).path = propval.toCString(Yes.Alloc);
  }

  /**
   * Parses xml_data and returns a #GDBusNodeInfo representing the data.
   * The introspection XML must contain exactly one top-level
   * <node> element.
   * Note that this routine is using a
   * [GMarkup][glib-Simple-XML-Subset-Parser.description]-based
   * parser that only accepts a subset of valid XML documents.
   * Params:
   *   xmlData = Valid D-Bus introspection XML.
   * Returns: A #GDBusNodeInfo structure or %NULL if error is set. Free
   *   with [gio.dbus_node_info.DBusNodeInfo.unref].
   */
  static DBusNodeInfo newForXml(string xmlData)
  {
    GDBusNodeInfo* _cretval;
    const(char)* _xmlData = xmlData.toCString(No.Alloc);
    GError *_err;
    _cretval = g_dbus_node_info_new_for_xml(_xmlData, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new DBusNodeInfo(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Appends an XML representation of info $(LPAREN)and its children$(RPAREN) to string_builder.
   * This function is typically used for generating introspection XML documents at run-time for
   * handling the `org.freedesktop.DBus.Introspectable.Introspect`  method.
   * Params:
   *   indent = Indentation level.
   *   stringBuilder = A #GString to to append XML data to.
   */
  void generateXml(uint indent, String stringBuilder)
  {
    g_dbus_node_info_generate_xml(cast(GDBusNodeInfo*)cPtr, indent, stringBuilder ? cast(GString*)stringBuilder.cPtr(No.Dup) : null);
  }

  /**
   * Looks up information about an interface.
   * The cost of this function is O$(LPAREN)n$(RPAREN) in number of interfaces.
   * Params:
   *   name = A D-Bus interface name.
   * Returns: A #GDBusInterfaceInfo or %NULL if not found. Do not free, it is owned by info.
   */
  DBusInterfaceInfo lookupInterface(string name)
  {
    GDBusInterfaceInfo* _cretval;
    const(char)* _name = name.toCString(No.Alloc);
    _cretval = g_dbus_node_info_lookup_interface(cast(GDBusNodeInfo*)cPtr, _name);
    auto _retval = _cretval ? new DBusInterfaceInfo(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }
}
