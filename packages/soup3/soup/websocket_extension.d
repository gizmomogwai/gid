module soup.websocket_extension;

import gid.global;
import glib.bytes;
import glib.error;
import gobject.object;
import soup.c.functions;
import soup.c.types;
import soup.types;

/**
 * A WebSocket extension
 * #SoupWebsocketExtension is the base class for WebSocket extension objects.
 */
class WebsocketExtension : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())soup_websocket_extension_get_type != &gidSymbolNotFound ? soup_websocket_extension_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Get the parameters strings to be included in the request header.
   * If the extension doesn't include any parameter in the request, this function
   * returns %NULL.
   * Returns: a new allocated string with the parameters
   */
  string getRequestParams()
  {
    char* _cretval;
    _cretval = soup_websocket_extension_get_request_params(cast(SoupWebsocketExtension*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Get the parameters strings to be included in the response header.
   * If the extension doesn't include any parameter in the response, this function
   * returns %NULL.
   * Returns: a new allocated string with the parameters
   */
  string getResponseParams()
  {
    char* _cretval;
    _cretval = soup_websocket_extension_get_response_params(cast(SoupWebsocketExtension*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Process a message after it's received.
   * If the payload isn't changed the given payload is just returned, otherwise
   * [glib.bytes.Bytes.unref] is called on the given payload and a new
   * [glib.bytes.Bytes] is returned with the new data.
   * Extensions using reserved bits of the header will reset them in header.
   * Params:
   *   header = the message header
   *   payload = the payload data
   * Returns: the message payload data, or %NULL in case of error
   */
  Bytes processIncomingMessage(ref ubyte header, Bytes payload)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = soup_websocket_extension_process_incoming_message(cast(SoupWebsocketExtension*)cPtr, cast(ubyte*)&header, payload ? cast(GBytes*)payload.cPtr(Yes.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Process a message before it's sent.
   * If the payload isn't changed the given payload is just returned, otherwise
   * methodGlib.Bytes.unref is called on the given payload and a new
   * [glib.bytes.Bytes] is returned with the new data.
   * Extensions using reserved bits of the header will change them in header.
   * Params:
   *   header = the message header
   *   payload = the payload data
   * Returns: the message payload data, or %NULL in case of error
   */
  Bytes processOutgoingMessage(ref ubyte header, Bytes payload)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = soup_websocket_extension_process_outgoing_message(cast(SoupWebsocketExtension*)cPtr, cast(ubyte*)&header, payload ? cast(GBytes*)payload.cPtr(Yes.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }
}
