module arrowflight.server_auth_sender;

import arrowflight.c.functions;
import arrowflight.c.types;
import arrowflight.types;
import gid.global;
import glib.bytes;
import glib.error;
import gobject.object;

class ServerAuthSender : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gaflight_server_auth_sender_get_type != &gidSymbolNotFound ? gaflight_server_auth_sender_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Writes a message to the client.
   * Params:
   *   message = A #GBytes to be sent.
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool write(Bytes message)
  {
    bool _retval;
    GError *_err;
    _retval = gaflight_server_auth_sender_write(cast(GAFlightServerAuthSender*)cPtr, message ? cast(GBytes*)message.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
