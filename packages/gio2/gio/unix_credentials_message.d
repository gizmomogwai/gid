module gio.unix_credentials_message;

import gid.global;
import gio.c.functions;
import gio.c.types;
import gio.credentials;
import gio.socket_control_message;
import gio.types;
import gobject.object;

/**
 * This [gio.socket_control_message.SocketControlMessage] contains a [gio.credentials.Credentials]
 * instance.  It may be sent using [gio.socket.Socket.sendMessage] and received
 * using [gio.socket.Socket.receiveMessage] over UNIX sockets $(LPAREN)ie: sockets in
 * the `G_SOCKET_FAMILY_UNIX` family$(RPAREN).
 * For an easier way to send and receive credentials over
 * stream-oriented UNIX sockets, see
 * [gio.unix_connection.UnixConnection.sendCredentials] and
 * [gio.unix_connection.UnixConnection.receiveCredentials]. To receive credentials of
 * a foreign process connected to a socket, use
 * [gio.socket.Socket.getCredentials].
 * Since GLib 2.72, `GUnixCredentialMessage` is available on all platforms. It
 * requires underlying system support $(LPAREN)such as Windows 10 with `AF_UNIX`$(RPAREN) at run
 * time.
 * Before GLib 2.72, `<gio/gunixcredentialsmessage.h>` belonged to the UNIX-specific
 * GIO interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file
 * when using it. This is no longer necessary since GLib 2.72.
 */
class UnixCredentialsMessage : SocketControlMessage
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_unix_credentials_message_get_type != &gidSymbolNotFound ? g_unix_credentials_message_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GUnixCredentialsMessage with credentials matching the current processes.
   * Returns: a new #GUnixCredentialsMessage
   */
  this()
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_credentials_message_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Creates a new #GUnixCredentialsMessage holding credentials.
   * Params:
   *   credentials = A #GCredentials object.
   * Returns: a new #GUnixCredentialsMessage
   */
  static UnixCredentialsMessage newWithCredentials(Credentials credentials)
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_credentials_message_new_with_credentials(credentials ? cast(GCredentials*)credentials.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!UnixCredentialsMessage(cast(GSocketControlMessage*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Checks if passing #GCredentials on a #GSocket is supported on this platform.
   * Returns: %TRUE if supported, %FALSE otherwise
   */
  static bool isSupported()
  {
    bool _retval;
    _retval = g_unix_credentials_message_is_supported();
    return _retval;
  }

  /**
   * Gets the credentials stored in message.
   * Returns: A #GCredentials instance. Do not free, it is owned by message.
   */
  Credentials getCredentials()
  {
    GCredentials* _cretval;
    _cretval = g_unix_credentials_message_get_credentials(cast(GUnixCredentialsMessage*)cPtr);
    auto _retval = ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, No.Take);
    return _retval;
  }
}
