module pango.coverage;

import gid.global;
import gobject.object;
import pango.c.functions;
import pango.c.types;
import pango.types;

/**
 * A `PangoCoverage` structure is a map from Unicode characters
 * to [pango.CoverageLevel] values.
 * It is often necessary in Pango to determine if a particular
 * font can represent a particular character, and also how well
 * it can represent that character. The `PangoCoverage` is a data
 * structure that is used to represent that information. It is an
 * opaque structure with no public fields.
 */
class Coverage : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())pango_coverage_get_type != &gidSymbolNotFound ? pango_coverage_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new `PangoCoverage`
   * Returns: the newly allocated `PangoCoverage`, initialized
   *   to %PANGO_COVERAGE_NONE with a reference count of one, which
   *   should be freed with [pango.coverage.Coverage.unref].
   */
  this()
  {
    PangoCoverage* _cretval;
    _cretval = pango_coverage_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Convert data generated from [pango.coverage.Coverage.toBytes]
   * back to a `PangoCoverage`.
   * Params:
   *   bytes = binary data
   *     representing a `PangoCoverage`
   * Returns: a newly allocated `PangoCoverage`

   * Deprecated: This returns %NULL
   */
  static Coverage fromBytes(ubyte[] bytes)
  {
    PangoCoverage* _cretval;
    int _nBytes;
    if (bytes)
      _nBytes = cast(int)bytes.length;

    auto _bytes = cast(ubyte*)bytes.ptr;
    _cretval = pango_coverage_from_bytes(_bytes, _nBytes);
    auto _retval = ObjectG.getDObject!Coverage(cast(PangoCoverage*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Copy an existing `PangoCoverage`.
   * Returns: the newly allocated `PangoCoverage`,
   *   with a reference count of one, which should be freed with
   *   [pango.coverage.Coverage.unref].
   */
  Coverage copy()
  {
    PangoCoverage* _cretval;
    _cretval = pango_coverage_copy(cast(PangoCoverage*)cPtr);
    auto _retval = ObjectG.getDObject!Coverage(cast(PangoCoverage*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Determine whether a particular index is covered by coverage.
   * Params:
   *   index = the index to check
   * Returns: the coverage level of coverage for character index_.
   */
  CoverageLevel get(int index)
  {
    PangoCoverageLevel _cretval;
    _cretval = pango_coverage_get(cast(PangoCoverage*)cPtr, index);
    CoverageLevel _retval = cast(CoverageLevel)_cretval;
    return _retval;
  }

  /**
   * Set the coverage for each index in coverage to be the max $(LPAREN)better$(RPAREN)
   * value of the current coverage for the index and the coverage for
   * the corresponding index in other.
   * Params:
   *   other = another `PangoCoverage`

   * Deprecated: This function does nothing
   */
  void max(Coverage other)
  {
    pango_coverage_max(cast(PangoCoverage*)cPtr, other ? cast(PangoCoverage*)other.cPtr(No.Dup) : null);
  }

  /**
   * Modify a particular index within coverage
   * Params:
   *   index = the index to modify
   *   level = the new level for index_
   */
  void set(int index, CoverageLevel level)
  {
    pango_coverage_set(cast(PangoCoverage*)cPtr, index, level);
  }

  /**
   * Convert a `PangoCoverage` structure into a flat binary format.
   * Params:
   *   bytes = location to store result $(LPAREN)must be freed with [glib.global.gfree]$(RPAREN)

   * Deprecated: This returns %NULL
   */
  void toBytes(out ubyte[] bytes)
  {
    int _nBytes;
    ubyte* _bytes;
    pango_coverage_to_bytes(cast(PangoCoverage*)cPtr, &_bytes, &_nBytes);
    bytes.length = _nBytes;
    bytes[0 .. $] = _bytes[0 .. _nBytes];
    safeFree(cast(void*)_bytes);
  }
}
