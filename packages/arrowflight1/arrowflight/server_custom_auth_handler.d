module arrowflight.server_custom_auth_handler;

import arrowflight.c.functions;
import arrowflight.c.types;
import arrowflight.server_auth_handler;
import arrowflight.server_auth_reader;
import arrowflight.server_auth_sender;
import arrowflight.server_call_context;
import arrowflight.types;
import gid.global;
import glib.bytes;
import glib.error;

class ServerCustomAuthHandler : ServerAuthHandler
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gaflight_server_custom_auth_handler_get_type != &gidSymbolNotFound ? gaflight_server_custom_auth_handler_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Authenticates the client on initial connection. The server can send
   * and read responses from the client at any time.
   * Params:
   *   context = A #GAFlightServerCallContext.
   *   sender = A #GAFlightServerAuthSender.
   *   reader = A #GAFlightServerAuthReader.
   */
  void authenticate(ServerCallContext context, ServerAuthSender sender, ServerAuthReader reader)
  {
    GError *_err;
    gaflight_server_custom_auth_handler_authenticate(cast(GAFlightServerCustomAuthHandler*)cPtr, context ? cast(GAFlightServerCallContext*)context.cPtr(No.Dup) : null, sender ? cast(GAFlightServerAuthSender*)sender.cPtr(No.Dup) : null, reader ? cast(GAFlightServerAuthReader*)reader.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
  }

  /**
   * Validates a per-call client token.
   * Params:
   *   context = A #GAFlightServerCallContext.
   *   token = The client token. May be the empty string if the client does not
   *     provide a token.
   * Returns: The identity of the peer, if
   *   this authentication method supports it.
   */
  Bytes isValid(ServerCallContext context, Bytes token)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = gaflight_server_custom_auth_handler_is_valid(cast(GAFlightServerCustomAuthHandler*)cPtr, context ? cast(GAFlightServerCallContext*)context.cPtr(No.Dup) : null, token ? cast(GBytes*)token.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }
}
