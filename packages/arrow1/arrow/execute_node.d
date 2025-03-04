module arrow.execute_node;

import arrow.c.functions;
import arrow.c.types;
import arrow.schema;
import arrow.types;
import gid.global;
import gobject.object;

class ExecuteNode : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_execute_node_get_type != &gidSymbolNotFound ? garrow_execute_node_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  string getKindName()
  {
    const(char)* _cretval;
    _cretval = garrow_execute_node_get_kind_name(cast(GArrowExecuteNode*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  Schema getOutputSchema()
  {
    GArrowSchema* _cretval;
    _cretval = garrow_execute_node_get_output_schema(cast(GArrowExecuteNode*)cPtr);
    auto _retval = ObjectG.getDObject!Schema(cast(GArrowSchema*)_cretval, Yes.Take);
    return _retval;
  }
}
