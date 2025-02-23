module gtk.string_sorter;

import gid.gid;
import gtk.c.functions;
import gtk.c.types;
import gtk.expression;
import gtk.sorter;
import gtk.types;

/**
 * `GtkStringSorter` is a `GtkSorter` that compares strings.
 * It does the comparison in a linguistically correct way using the
 * current locale by normalizing Unicode strings and possibly case-folding
 * them before performing the comparison.
 * To obtain the strings to compare, this sorter evaluates a
 * [Gtk.Expression].
 */
class StringSorter : Sorter
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_string_sorter_get_type != &gidSymbolNotFound ? gtk_string_sorter_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new string sorter that compares items using the given
   * expression.
   * Unless an expression is set on it, this sorter will always
   * compare items as invalid.
   * Params:
   *   expression = The expression to evaluate
   * Returns: a new `GtkStringSorter`
   */
  this(Expression expression)
  {
    GtkStringSorter* _cretval;
    _cretval = gtk_string_sorter_new(expression ? cast(GtkExpression*)expression.cPtr(Yes.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * Gets which collation method the sorter uses.
   * Returns: The collation method
   */
  Collation getCollation()
  {
    GtkCollation _cretval;
    _cretval = gtk_string_sorter_get_collation(cast(GtkStringSorter*)cPtr);
    Collation _retval = cast(Collation)_cretval;
    return _retval;
  }

  /**
   * Gets the expression that is evaluated to obtain strings from items.
   * Returns: a `GtkExpression`
   */
  Expression getExpression()
  {
    GtkExpression* _cretval;
    _cretval = gtk_string_sorter_get_expression(cast(GtkStringSorter*)cPtr);
    auto _retval = _cretval ? new Expression(cast(GtkExpression*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Gets whether the sorter ignores case differences.
   * Returns: %TRUE if self is ignoring case differences
   */
  bool getIgnoreCase()
  {
    bool _retval;
    _retval = gtk_string_sorter_get_ignore_case(cast(GtkStringSorter*)cPtr);
    return _retval;
  }

  /**
   * Sets the collation method to use for sorting.
   * Params:
   *   collation = the collation method
   */
  void setCollation(Collation collation)
  {
    gtk_string_sorter_set_collation(cast(GtkStringSorter*)cPtr, collation);
  }

  /**
   * Sets the expression that is evaluated to obtain strings from items.
   * The expression must have the type %G_TYPE_STRING.
   * Params:
   *   expression = a `GtkExpression`
   */
  void setExpression(Expression expression)
  {
    gtk_string_sorter_set_expression(cast(GtkStringSorter*)cPtr, expression ? cast(GtkExpression*)expression.cPtr(No.Dup) : null);
  }

  /**
   * Sets whether the sorter will ignore case differences.
   * Params:
   *   ignoreCase = %TRUE to ignore case differences
   */
  void setIgnoreCase(bool ignoreCase)
  {
    gtk_string_sorter_set_ignore_case(cast(GtkStringSorter*)cPtr, ignoreCase);
  }
}
