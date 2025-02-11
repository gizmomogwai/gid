module Arrow.LiteralExpression;

import Arrow.Datum;
import Arrow.Expression;
import Arrow.Types;
import Arrow.c.functions;
import Arrow.c.types;
import Gid.gid;

class LiteralExpression : Expression
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return garrow_literal_expression_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Datum datum)
  {
    GArrowLiteralExpression* _cretval;
    _cretval = garrow_literal_expression_new(datum ? cast(GArrowDatum*)datum.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }
}
