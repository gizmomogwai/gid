module arrow.rank_options;

import arrow.c.functions;
import arrow.c.types;
import arrow.function_options;
import arrow.sort_key;
import arrow.types;
import gid.global;

class RankOptions : FunctionOptions
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_rank_options_get_type != &gidSymbolNotFound ? garrow_rank_options_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GArrowRankOptions* _cretval;
    _cretval = garrow_rank_options_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Add a sort key to be used.
   * Params:
   *   sortKey = The sort key to be added.
   */
  void addSortKey(SortKey sortKey)
  {
    garrow_rank_options_add_sort_key(cast(GArrowRankOptions*)cPtr, sortKey ? cast(GArrowSortKey*)sortKey.cPtr(No.Dup) : null);
  }

  alias equal = FunctionOptions.equal;

  bool equal(RankOptions otherOptions)
  {
    bool _retval;
    _retval = garrow_rank_options_equal(cast(GArrowRankOptions*)cPtr, otherOptions ? cast(GArrowRankOptions*)otherOptions.cPtr(No.Dup) : null);
    return _retval;
  }

  SortKey[] getSortKeys()
  {
    GList* _cretval;
    _cretval = garrow_rank_options_get_sort_keys(cast(GArrowRankOptions*)cPtr);
    auto _retval = gListToD!(SortKey, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Set sort keys to be used.
   * Params:
   *   sortKeys = The sort keys to be used.
   */
  void setSortKeys(SortKey[] sortKeys)
  {
    auto _sortKeys = gListFromD!(SortKey)(sortKeys);
    scope(exit) containerFree!(GList*, SortKey, GidOwnership.None)(_sortKeys);
    garrow_rank_options_set_sort_keys(cast(GArrowRankOptions*)cPtr, _sortKeys);
  }
}
