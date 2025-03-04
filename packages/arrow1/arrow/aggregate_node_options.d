module arrow.aggregate_node_options;

import arrow.aggregation;
import arrow.c.functions;
import arrow.c.types;
import arrow.execute_node_options;
import arrow.types;
import gid.global;
import glib.error;

class AggregateNodeOptions : ExecuteNodeOptions
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_aggregate_node_options_get_type != &gidSymbolNotFound ? garrow_aggregate_node_options_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Aggregation[] aggregations, string[] keys)
  {
    GArrowAggregateNodeOptions* _cretval;
    auto _aggregations = gListFromD!(Aggregation)(aggregations);
    scope(exit) containerFree!(GList*, Aggregation, GidOwnership.None)(_aggregations);
    size_t _nKeys;
    if (keys)
      _nKeys = cast(size_t)keys.length;

    char*[] _tmpkeys;
    foreach (s; keys)
      _tmpkeys ~= s.toCString(No.Alloc);
    const(char*)* _keys = _tmpkeys.ptr;

    GError *_err;
    _cretval = garrow_aggregate_node_options_new(_aggregations, _keys, _nKeys, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, Yes.Take);
  }
}
