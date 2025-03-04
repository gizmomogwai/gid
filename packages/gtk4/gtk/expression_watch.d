module gtk.expression_watch;

import gid.global;
import gobject.boxed;
import gobject.value;
import gtk.c.functions;
import gtk.c.types;
import gtk.types;

/**
 * An opaque structure representing a watched `GtkExpression`.
 * The contents of `GtkExpressionWatch` should only be accessed through the
 * provided API.
 */
class ExpressionWatch : Boxed
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
    return cast(void function())gtk_expression_watch_get_type != &gidSymbolNotFound ? gtk_expression_watch_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Evaluates the watched expression and on success stores the result
   * in `value`.
   * This is equivalent to calling [gtk.expression.Expression.evaluate] with the
   * expression and this pointer originally used to create `watch`.
   * Params:
   *   value = an empty `GValue` to be set
   * Returns: `TRUE` if the expression could be evaluated and `value` was set
   */
  bool evaluate(Value value)
  {
    bool _retval;
    _retval = gtk_expression_watch_evaluate(cast(GtkExpressionWatch*)cPtr, value ? cast(GValue*)value.cPtr(No.Dup) : null);
    return _retval;
  }

  /**
   * Stops watching an expression.
   * See [gtk.expression.Expression.watch] for how the watch
   * was established.
   */
  void unwatch()
  {
    gtk_expression_watch_unwatch(cast(GtkExpressionWatch*)cPtr);
  }
}
