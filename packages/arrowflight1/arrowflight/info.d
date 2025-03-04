module arrowflight.info;

import arrow.read_options;
import arrow.schema;
import arrowflight.c.functions;
import arrowflight.c.types;
import arrowflight.descriptor;
import arrowflight.endpoint;
import arrowflight.types;
import gid.global;
import glib.error;
import gobject.object;

class Info : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gaflight_info_get_type != &gidSymbolNotFound ? gaflight_info_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Schema schema, Descriptor descriptor, Endpoint[] endpoints, long totalRecords, long totalBytes)
  {
    GAFlightInfo* _cretval;
    auto _endpoints = gListFromD!(Endpoint)(endpoints);
    scope(exit) containerFree!(GList*, Endpoint, GidOwnership.None)(_endpoints);
    GError *_err;
    _cretval = gaflight_info_new(schema ? cast(GArrowSchema*)schema.cPtr(No.Dup) : null, descriptor ? cast(GAFlightDescriptor*)descriptor.cPtr(No.Dup) : null, _endpoints, totalRecords, totalBytes, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, Yes.Take);
  }

  bool equal(Info otherInfo)
  {
    bool _retval;
    _retval = gaflight_info_equal(cast(GAFlightInfo*)cPtr, otherInfo ? cast(GAFlightInfo*)otherInfo.cPtr(No.Dup) : null);
    return _retval;
  }

  Descriptor getDescriptor()
  {
    GAFlightDescriptor* _cretval;
    _cretval = gaflight_info_get_descriptor(cast(GAFlightInfo*)cPtr);
    auto _retval = ObjectG.getDObject!Descriptor(cast(GAFlightDescriptor*)_cretval, Yes.Take);
    return _retval;
  }

  Endpoint[] getEndpoints()
  {
    GList* _cretval;
    _cretval = gaflight_info_get_endpoints(cast(GAFlightInfo*)cPtr);
    auto _retval = gListToD!(Endpoint, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  Schema getSchema(ReadOptions options)
  {
    GArrowSchema* _cretval;
    GError *_err;
    _cretval = gaflight_info_get_schema(cast(GAFlightInfo*)cPtr, options ? cast(GArrowReadOptions*)options.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!Schema(cast(GArrowSchema*)_cretval, Yes.Take);
    return _retval;
  }

  long getTotalBytes()
  {
    long _retval;
    _retval = gaflight_info_get_total_bytes(cast(GAFlightInfo*)cPtr);
    return _retval;
  }

  long getTotalRecords()
  {
    long _retval;
    _retval = gaflight_info_get_total_records(cast(GAFlightInfo*)cPtr);
    return _retval;
  }
}
