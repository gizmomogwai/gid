module gtk.builder_list_item_factory;

import gid.global;
import glib.bytes;
import gobject.object;
import gtk.builder_scope;
import gtk.builder_scope_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.list_item_factory;
import gtk.types;

/**
 * `GtkBuilderListItemFactory` is a `GtkListItemFactory` that creates
 * widgets by instantiating `GtkBuilder` UI templates.
 * The templates must be extending `GtkListItem`, and typically use
 * `GtkExpression`s to obtain data from the items in the model.
 * Example:
 * ```xml
 * <interface>
 * <template class\="GtkListItem">
 * <property name\="child">
 * <object class\="GtkLabel">
 * <property name\="xalign">0</property>
 * <binding name\="label">
 * <lookup name\="name" type\="SettingsKey">
 * <lookup name\="item">GtkListItem</lookup>
 * </lookup>
 * </binding>
 * </object>
 * </property>
 * </template>
 * </interface>
 * ```
 */
class BuilderListItemFactory : ListItemFactory
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_builder_list_item_factory_get_type != &gidSymbolNotFound ? gtk_builder_list_item_factory_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkBuilderListItemFactory` that instantiates widgets
   * using bytes as the data to pass to `GtkBuilder`.
   * Params:
   *   scope_ = A scope to use when instantiating
   *   bytes = the `GBytes` containing the ui file to instantiate
   * Returns: a new `GtkBuilderListItemFactory`
   */
  static BuilderListItemFactory newFromBytes(BuilderScope scope_, Bytes bytes)
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_builder_list_item_factory_new_from_bytes(scope_ ? cast(GtkBuilderScope*)(cast(ObjectG)scope_).cPtr(No.Dup) : null, bytes ? cast(GBytes*)bytes.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!BuilderListItemFactory(cast(GtkListItemFactory*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Creates a new `GtkBuilderListItemFactory` that instantiates widgets
   * using data read from the given resource_path to pass to `GtkBuilder`.
   * Params:
   *   scope_ = A scope to use when instantiating
   *   resourcePath = valid path to a resource that contains the data
   * Returns: a new `GtkBuilderListItemFactory`
   */
  static BuilderListItemFactory newFromResource(BuilderScope scope_, string resourcePath)
  {
    GtkListItemFactory* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(No.Alloc);
    _cretval = gtk_builder_list_item_factory_new_from_resource(scope_ ? cast(GtkBuilderScope*)(cast(ObjectG)scope_).cPtr(No.Dup) : null, _resourcePath);
    auto _retval = ObjectG.getDObject!BuilderListItemFactory(cast(GtkListItemFactory*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the data used as the `GtkBuilder` UI template for constructing
   * listitems.
   * Returns: The `GtkBuilder` data
   */
  Bytes getBytes()
  {
    GBytes* _cretval;
    _cretval = gtk_builder_list_item_factory_get_bytes(cast(GtkBuilderListItemFactory*)cPtr);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * If the data references a resource, gets the path of that resource.
   * Returns: The path to the resource
   */
  string getResource()
  {
    const(char)* _cretval;
    _cretval = gtk_builder_list_item_factory_get_resource(cast(GtkBuilderListItemFactory*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets the scope used when constructing listitems.
   * Returns: The scope used when constructing listitems
   */
  BuilderScope getScope()
  {
    GtkBuilderScope* _cretval;
    _cretval = gtk_builder_list_item_factory_get_scope(cast(GtkBuilderListItemFactory*)cPtr);
    auto _retval = ObjectG.getDObject!BuilderScope(cast(GtkBuilderScope*)_cretval, No.Take);
    return _retval;
  }
}
