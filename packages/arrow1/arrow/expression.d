module arrow.expression;

import arrow.c.functions;
import arrow.c.types;
import arrow.types;
import gid.global;
import gobject.object;

class Expression : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_expression_get_type != &gidSymbolNotFound ? garrow_expression_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  bool equal(Expression otherExpression)
  {
    bool _retval;
    _retval = garrow_expression_equal(cast(GArrowExpression*)cPtr, otherExpression ? cast(GArrowExpression*)otherExpression.cPtr(No.Dup) : null);
    return _retval;
  }

  string toString_()
  {
    char* _cretval;
    _cretval = garrow_expression_to_string(cast(GArrowExpression*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }
}
