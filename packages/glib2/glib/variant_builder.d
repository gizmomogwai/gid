module glib.variant_builder;

import gid.global;
import glib.c.functions;
import glib.c.types;
import glib.types;
import glib.variant;
import glib.variant_type;
import gobject.boxed;

/**
 * A utility type for constructing container-type #GVariant instances.
 * This is an opaque structure and may only be accessed using the
 * following functions.
 * #GVariantBuilder is not threadsafe in any way.  Do not attempt to
 * access it from more than one thread.
 */
class VariantBuilder : Boxed
{

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
    return cast(void function())g_variant_builder_get_type != &gidSymbolNotFound ? g_variant_builder_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates and initialises a new #GVariantBuilder.
   * You should call [glib.variant_builder.VariantBuilder.unref] on the return value when it
   * is no longer needed.  The memory will not be automatically freed by
   * any other call.
   * In most cases it is easier to place a #GVariantBuilder directly on
   * the stack of the calling function and initialise it with
   * [glib.variant_builder.VariantBuilder.init_].
   * Params:
   *   type = a container type
   * Returns: a #GVariantBuilder
   */
  this(VariantType type)
  {
    GVariantBuilder* _cretval;
    _cretval = g_variant_builder_new(type ? cast(GVariantType*)type.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * Adds value to builder.
   * It is an error to call this function in any way that would create an
   * inconsistent value to be constructed.  Some examples of this are
   * putting different types of items into an array, putting the wrong
   * types or number of items in a tuple, putting more than one value into
   * a variant, etc.
   * If value is a floating reference $(LPAREN)see [glib.variant.VariantG.refSink]$(RPAREN),
   * the builder instance takes ownership of value.
   * Params:
   *   value = a #GVariant
   */
  void addValue(VariantG value)
  {
    g_variant_builder_add_value(cast(GVariantBuilder*)cPtr, value ? cast(VariantC*)value.cPtr(No.Dup) : null);
  }

  /**
   * Closes the subcontainer inside the given builder that was opened by
   * the most recent call to [glib.variant_builder.VariantBuilder.open].
   * It is an error to call this function in any way that would create an
   * inconsistent value to be constructed $(LPAREN)ie: too few values added to the
   * subcontainer$(RPAREN).
   */
  void close()
  {
    g_variant_builder_close(cast(GVariantBuilder*)cPtr);
  }

  /**
   * Ends the builder process and returns the constructed value.
   * It is not permissible to use builder in any way after this call
   * except for reference counting operations $(LPAREN)in the case of a
   * heap-allocated #GVariantBuilder$(RPAREN) or by reinitialising it with
   * [glib.variant_builder.VariantBuilder.init_] (in the case of stack-allocated). This
   * means that for the stack-allocated builders there is no need to
   * call [glib.variant_builder.VariantBuilder.clear] after the call to
   * [glib.variant_builder.VariantBuilder.end].
   * It is an error to call this function in any way that would create an
   * inconsistent value to be constructed $(LPAREN)ie: insufficient number of
   * items added to a container with a specific number of children
   * required$(RPAREN).  It is also an error to call this function if the builder
   * was created with an indefinite array or maybe type and no children
   * have been added; in this case it is impossible to infer the type of
   * the empty array.
   * Returns: a new, floating, #GVariant
   */
  VariantG end()
  {
    VariantC* _cretval;
    _cretval = g_variant_builder_end(cast(GVariantBuilder*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Opens a subcontainer inside the given builder.  When done adding
   * items to the subcontainer, [glib.variant_builder.VariantBuilder.close] must be called. type
   * is the type of the container: so to build a tuple of several values, type
   * must include the tuple itself.
   * It is an error to call this function in any way that would cause an
   * inconsistent value to be constructed $(LPAREN)ie: adding too many values or
   * a value of an incorrect type$(RPAREN).
   * Example of building a nested variant:
   * |[<!-- language\="C" -->
   * GVariantBuilder builder;
   * guint32 some_number \= get_number $(LPAREN)$(RPAREN);
   * g_autoptr $(LPAREN)GHashTable$(RPAREN) some_dict \= get_dict $(LPAREN)$(RPAREN);
   * GHashTableIter iter;
   * const gchar *key;
   * const GVariant *value;
   * g_autoptr $(LPAREN)GVariant$(RPAREN) output \= NULL;
   * g_variant_builder_init $(LPAREN)&builder, G_VARIANT_TYPE $(LPAREN)"$(LPAREN)ua{sv}$(RPAREN)"$(RPAREN)$(RPAREN);
   * g_variant_builder_add $(LPAREN)&builder, "u", some_number$(RPAREN);
   * g_variant_builder_open $(LPAREN)&builder, G_VARIANT_TYPE $(LPAREN)"a{sv}"$(RPAREN)$(RPAREN);
   * g_hash_table_iter_init $(LPAREN)&iter, some_dict$(RPAREN);
   * while $(LPAREN)g_hash_table_iter_next $(LPAREN)&iter, $(LPAREN)gpointer *$(RPAREN) &key, $(LPAREN)gpointer *$(RPAREN) &value$(RPAREN)$(RPAREN)
   * {
   * g_variant_builder_open $(LPAREN)&builder, G_VARIANT_TYPE $(LPAREN)"{sv}"$(RPAREN)$(RPAREN);
   * g_variant_builder_add $(LPAREN)&builder, "s", key$(RPAREN);
   * g_variant_builder_add $(LPAREN)&builder, "v", value$(RPAREN);
   * g_variant_builder_close $(LPAREN)&builder$(RPAREN);
   * }
   * g_variant_builder_close $(LPAREN)&builder$(RPAREN);
   * output \= g_variant_builder_end $(LPAREN)&builder$(RPAREN);
   * ]|
   * Params:
   *   type = the #GVariantType of the container
   */
  void open(VariantType type)
  {
    g_variant_builder_open(cast(GVariantBuilder*)cPtr, type ? cast(GVariantType*)type.cPtr(No.Dup) : null);
  }
}
