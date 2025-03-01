module soup.server;

import gid.global;
import gio.iostream;
import gio.socket;
import gio.socket_address;
import gio.tls_certificate;
import gio.tls_database;
import gio.types;
import glib.error;
import glib.uri;
import gobject.dclosure;
import gobject.object;
import gobject.types;
import soup.auth_domain;
import soup.c.functions;
import soup.c.types;
import soup.server_message;
import soup.types;
import soup.websocket_connection;

/**
 * A HTTP server.
 * #SoupServer implements a simple HTTP server.
 * To begin, create a server using [soup.server.Server.new_]. Add at least one
 * handler by calling [soup.server.Server.addHandler] or
 * [soup.server.Server.addEarlyHandler]; the handler will be called to
 * process any requests underneath the path you pass. $(LPAREN)If you want all
 * requests to go to the same handler, just pass "/" $(LPAREN)or %NULL$(RPAREN) for
 * the path.$(RPAREN)
 * When a new connection is accepted $(LPAREN)or a new request is started on
 * an existing persistent connection$(RPAREN), the #SoupServer will emit
 * signal@Server::request-started and then begin processing the request
 * as described below, but note that once the message is assigned a
 * status-code, then callbacks after that point will be
 * skipped. Note also that it is not defined when the callbacks happen
 * relative to various class@ServerMessage signals.
 * Once the headers have been read, #SoupServer will check if there is
 * a class@AuthDomain `$(LPAREN)qv$(RPAREN)` covering the Request-URI; if so, and if the
 * message does not contain suitable authorization, then the
 * class@AuthDomain will set a status of %SOUP_STATUS_UNAUTHORIZED on
 * the message.
 * After checking for authorization, #SoupServer will look for "early"
 * handlers $(LPAREN)added with [soup.server.Server.addEarlyHandler]$(RPAREN) matching the
 * Request-URI. If one is found, it will be run; in particular, this
 * can be used to connect to signals to do a streaming read of the
 * request body.
 * $(LPAREN)At this point, if the request headers contain `Expect:
 * 100-continue`, and a status code has been set, then
 * #SoupServer will skip the remaining steps and return the response.
 * If the request headers contain `Expect:
 * 100-continue` and no status code has been set,
 * #SoupServer will return a %SOUP_STATUS_CONTINUE status before
 * continuing.$(RPAREN)
 * The server will then read in the response body $(LPAREN)if present$(RPAREN). At
 * this point, if there are no handlers at all defined for the
 * Request-URI, then the server will return %SOUP_STATUS_NOT_FOUND to
 * the client.
 * Otherwise $(LPAREN)assuming no previous step assigned a status to the
 * message$(RPAREN) any "normal" handlers $(LPAREN)added with
 * [soup.server.Server.addHandler]$(RPAREN) for the message's Request-URI will be
 * run.
 * Then, if the path has a WebSocket handler registered $(LPAREN)and has
 * not yet been assigned a status$(RPAREN), #SoupServer will attempt to
 * validate the WebSocket handshake, filling in the response and
 * setting a status of %SOUP_STATUS_SWITCHING_PROTOCOLS or
 * %SOUP_STATUS_BAD_REQUEST accordingly.
 * If the message still has no status code at this point $(LPAREN)and has not
 * been paused with [soup.server_message.ServerMessage.pause]$(RPAREN), then it will be
 * given a status of %SOUP_STATUS_INTERNAL_SERVER_ERROR $(LPAREN)because at
 * least one handler ran, but returned without assigning a status$(RPAREN).
 * Finally, the server will emit signal@Server::request-finished $(LPAREN)or
 * signal@Server::request-aborted if an I/O error occurred before
 * handling was completed$(RPAREN).
 * If you want to handle the special "*" URI $(LPAREN)eg, "OPTIONS *"$(RPAREN), you
 * must explicitly register a handler for "*"; the default handler
 * will not be used for that case.
 * If you want to process https connections in addition to $(LPAREN)or instead
 * of$(RPAREN) http connections, you can set the property@Server:tls-certificate
 * property.
 * Once the server is set up, make one or more calls to
 * [soup.server.Server.listen], [soup.server.Server.listenLocal], or
 * [soup.server.Server.listenAll] to tell it where to listen for
 * connections. $(LPAREN)All ports on a #SoupServer use the same handlers; if
 * you need to handle some ports differently, such as returning
 * different data for http and https, you'll need to create multiple
 * `SoupServer`s, or else check the passed-in URI in the handler
 * function.$(RPAREN).
 * #SoupServer will begin processing connections as soon as you return
 * to $(LPAREN)or start$(RPAREN) the main loop for the current thread-default
 * [glib.main_context.MainContext].
 */
class Server : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())soup_server_get_type != &gidSymbolNotFound ? soup_server_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Adds a new client stream to the server.
   * Params:
   *   stream = a #GIOStream
   *   localAddr = the local #GSocketAddress associated with the
   *     stream
   *   remoteAddr = the remote #GSocketAddress associated with the
   *     stream
   * Returns: %TRUE on success, %FALSE if the stream could not be
   *   accepted or any other error occurred $(LPAREN)in which case error will be
   *   set$(RPAREN).
   */
  bool acceptIostream(IOStream stream, SocketAddress localAddr, SocketAddress remoteAddr)
  {
    bool _retval;
    GError *_err;
    _retval = soup_server_accept_iostream(cast(SoupServer*)cPtr, stream ? cast(GIOStream*)stream.cPtr(No.Dup) : null, localAddr ? cast(GSocketAddress*)localAddr.cPtr(No.Dup) : null, remoteAddr ? cast(GSocketAddress*)remoteAddr.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Adds an authentication domain to server.
   * Each auth domain will have the chance to require authentication for each
   * request that comes in; normally auth domains will require authentication for
   * requests on certain paths that they have been set up to watch, or that meet
   * other criteria set by the caller. If an auth domain determines that a request
   * requires authentication $(LPAREN)and the request doesn't contain authentication$(RPAREN),
   * server will automatically reject the request with an appropriate status $(LPAREN)401
   * Unauthorized or 407 Proxy Authentication Required$(RPAREN). If the request used the
   * SoupServer:100-continue Expectation, server will reject it before the
   * request body is sent.
   * Params:
   *   authDomain = a #SoupAuthDomain
   */
  void addAuthDomain(AuthDomain authDomain)
  {
    soup_server_add_auth_domain(cast(SoupServer*)cPtr, authDomain ? cast(SoupAuthDomain*)authDomain.cPtr(No.Dup) : null);
  }

  /**
   * Adds an "early" handler to server for requests prefixed by path.
   * Note that "normal" and "early" handlers are matched up together, so if you
   * add a normal handler for "/foo" and an early handler for "/foo/bar", then a
   * request to "/foo/bar" $(LPAREN)or any path below it$(RPAREN) will run only the early handler.
   * $(LPAREN)But if you add both handlers at the same path, then both will get run.$(RPAREN)
   * For requests under path $(LPAREN)that have not already been assigned a
   * status code by a classAuthDomain or a signal handler$(RPAREN), callback
   * will be invoked after receiving the request headers, but before
   * receiving the request body; the message's method and
   * request-headers properties will be set.
   * Early handlers are generally used for processing requests with request bodies
   * in a streaming fashion. If you determine that the request will contain a
   * message body, normally you would call [soup.message_body.MessageBody.setAccumulate] on
   * the message's request-body to turn off request-body accumulation, and connect
   * to the message's signalServerMessage::got-chunk signal to process each
   * chunk as it comes in.
   * To complete the message processing after the full message body has
   * been read, you can either also connect to signalServerMessage::got-body,
   * or else you can register a non-early handler for path as well. As
   * long as you have not set the status-code by the time
   * signalServerMessage::got-body is emitted, the non-early handler will be
   * run as well.
   * Params:
   *   path = the toplevel path for the handler
   *   callback = callback to invoke for
   *     requests under path
   */
  void addEarlyHandler(string path, ServerCallback callback)
  {
    extern(C) void _callbackCallback(SoupServer* server, SoupServerMessage* msg, const(char)* path, GHashTable* query, void* userData)
    {
      auto _dlg = cast(ServerCallback*)userData;
      string _path = path.fromCString(No.Free);
      auto _query = gHashTableToD!(string, string, GidOwnership.None)(query);

      (*_dlg)(ObjectG.getDObject!Server(cast(void*)server, No.Take), ObjectG.getDObject!ServerMessage(cast(void*)msg, No.Take), _path, _query);
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    const(char)* _path = path.toCString(No.Alloc);
    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    GDestroyNotify _callbackDestroyCB = callback ? &thawDelegate : null;
    soup_server_add_early_handler(cast(SoupServer*)cPtr, _path, _callbackCB, _callback, _callbackDestroyCB);
  }

  /**
   * Adds a handler to server for requests prefixed by path.
   * If path is %NULL or "/", then this will be the default handler for all
   * requests that don't have a more specific handler. $(LPAREN)Note though that if you
   * want to handle requests to the special "*" URI, you must explicitly register
   * a handler for "*"; the default handler will not be used for that case.$(RPAREN)
   * For requests under path $(LPAREN)that have not already been assigned a
   * status code by a classAuthDomain, an early server handler, or a
   * signal handler$(RPAREN), callback will be invoked after receiving the
   * request body; the classServerMessage's method, request-headers,
   * and request-body properties will be set.
   * After determining what to do with the request, the callback must at a minimum
   * call [soup.server_message.ServerMessage.setStatus] on the message to set the response
   * status code. Additionally, it may set response headers and/or fill in the
   * response body.
   * If the callback cannot fully fill in the response before returning
   * $(LPAREN)eg, if it needs to wait for information from a database, or
   * another network server$(RPAREN), it should call [soup.server_message.ServerMessage.pause]
   * to tell server to not send the response right away. When the
   * response is ready, call [soup.server_message.ServerMessage.unpause] to cause it
   * to be sent.
   * To send the response body a bit at a time using "chunked" encoding, first
   * call [soup.message_headers.MessageHeaders.setEncoding] to set %SOUP_ENCODING_CHUNKED on
   * the response-headers. Then call [soup.message_body.MessageBody.append] $(LPAREN)or
   * [soup.message_body.MessageBody.appendBytes]$(RPAREN)$(RPAREN) to append each chunk as it becomes ready,
   * and [soup.server_message.ServerMessage.unpause] to make sure it's running. $(LPAREN)The server
   * will automatically pause the message if it is using chunked encoding but no
   * more chunks are available.$(RPAREN) When you are done, call
   * [soup.message_body.MessageBody.complete] to indicate that no more chunks are coming.
   * Params:
   *   path = the toplevel path for the handler
   *   callback = callback to invoke for
   *     requests under path
   */
  void addHandler(string path, ServerCallback callback)
  {
    extern(C) void _callbackCallback(SoupServer* server, SoupServerMessage* msg, const(char)* path, GHashTable* query, void* userData)
    {
      auto _dlg = cast(ServerCallback*)userData;
      string _path = path.fromCString(No.Free);
      auto _query = gHashTableToD!(string, string, GidOwnership.None)(query);

      (*_dlg)(ObjectG.getDObject!Server(cast(void*)server, No.Take), ObjectG.getDObject!ServerMessage(cast(void*)msg, No.Take), _path, _query);
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    const(char)* _path = path.toCString(No.Alloc);
    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    GDestroyNotify _callbackDestroyCB = callback ? &thawDelegate : null;
    soup_server_add_handler(cast(SoupServer*)cPtr, _path, _callbackCB, _callback, _callbackDestroyCB);
  }

  /**
   * Add support for a WebSocket extension of the given extension_type.
   * When a WebSocket client requests an extension of extension_type,
   * a new classWebsocketExtension of type extension_type will be created
   * to handle the request.
   * Note that classWebsocketExtensionDeflate is supported by default, use
   * [soup.server.Server.removeWebsocketExtension] if you want to disable it.
   * Params:
   *   extensionType = a #GType
   */
  void addWebsocketExtension(GType extensionType)
  {
    soup_server_add_websocket_extension(cast(SoupServer*)cPtr, extensionType);
  }

  /**
   * Adds a WebSocket handler to server for requests prefixed by path.
   * If path is %NULL or "/", then this will be the default handler for all
   * requests that don't have a more specific handler.
   * When a path has a WebSocket handler registered, server will check
   * incoming requests for WebSocket handshakes after all other handlers
   * have run $(LPAREN)unless some earlier handler has already set a status code
   * on the message$(RPAREN), and update the request's status, response headers,
   * and response body accordingly.
   * If origin is non-%NULL, then only requests containing a matching
   * "Origin" header will be accepted. If protocols is non-%NULL, then
   * only requests containing a compatible "Sec-WebSocket-Protocols"
   * header will be accepted. More complicated requirements can be
   * handled by adding a normal handler to path, and having it perform
   * whatever checks are needed and
   * setting a failure status code if the handshake should be rejected.
   * Params:
   *   path = the toplevel path for the handler
   *   origin = the origin of the connection
   *   protocols = the protocols
   *     supported by this handler
   *   callback = callback to invoke for
   *     successful WebSocket requests under path
   */
  void addWebsocketHandler(string path, string origin, string[] protocols, ServerWebsocketCallback callback)
  {
    extern(C) void _callbackCallback(SoupServer* server, SoupServerMessage* msg, const(char)* path, SoupWebsocketConnection* connection, void* userData)
    {
      auto _dlg = cast(ServerWebsocketCallback*)userData;
      string _path = path.fromCString(No.Free);

      (*_dlg)(ObjectG.getDObject!Server(cast(void*)server, No.Take), ObjectG.getDObject!ServerMessage(cast(void*)msg, No.Take), _path, ObjectG.getDObject!WebsocketConnection(cast(void*)connection, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    const(char)* _path = path.toCString(No.Alloc);
    const(char)* _origin = origin.toCString(No.Alloc);
    char*[] _tmpprotocols;
    foreach (s; protocols)
      _tmpprotocols ~= s.toCString(No.Alloc);
    _tmpprotocols ~= null;
    char** _protocols = _tmpprotocols.ptr;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    GDestroyNotify _callbackDestroyCB = callback ? &thawDelegate : null;
    soup_server_add_websocket_handler(cast(SoupServer*)cPtr, _path, _origin, _protocols, _callbackCB, _callback, _callbackDestroyCB);
  }

  /**
   * Closes and frees server's listening sockets.
   * Note that if there are currently requests in progress on server, that they
   * will continue to be processed if server's [glib.main_context.MainContext] is still
   * running.
   * You can call [soup.server.Server.listen], etc, after calling this function
   * if you want to start listening again.
   */
  void disconnect()
  {
    soup_server_disconnect(cast(SoupServer*)cPtr);
  }

  /**
   * Gets server's list of listening sockets.
   * You should treat these sockets as read-only; writing to or
   * modifiying any of these sockets may cause server to malfunction.
   * Returns: a
   *   list of listening sockets.
   */
  Socket[] getListeners()
  {
    GSList* _cretval;
    _cretval = soup_server_get_listeners(cast(SoupServer*)cPtr);
    auto _retval = gSListToD!(Socket, GidOwnership.Container)(cast(GSList*)_cretval);
    return _retval;
  }

  /**
   * Gets the server SSL/TLS client authentication mode.
   * Returns: a #GTlsAuthenticationMode
   */
  TlsAuthenticationMode getTlsAuthMode()
  {
    GTlsAuthenticationMode _cretval;
    _cretval = soup_server_get_tls_auth_mode(cast(SoupServer*)cPtr);
    TlsAuthenticationMode _retval = cast(TlsAuthenticationMode)_cretval;
    return _retval;
  }

  /**
   * Gets the server SSL/TLS certificate.
   * Returns: a #GTlsCertificate or %NULL
   */
  TlsCertificate getTlsCertificate()
  {
    GTlsCertificate* _cretval;
    _cretval = soup_server_get_tls_certificate(cast(SoupServer*)cPtr);
    auto _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the server SSL/TLS database.
   * Returns: a #GTlsDatabase
   */
  TlsDatabase getTlsDatabase()
  {
    GTlsDatabase* _cretval;
    _cretval = soup_server_get_tls_database(cast(SoupServer*)cPtr);
    auto _retval = ObjectG.getDObject!TlsDatabase(cast(GTlsDatabase*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets a list of URIs corresponding to the interfaces server is
   * listening on.
   * These will contain IP addresses, not hostnames, and will also indicate
   * whether the given listener is http or https.
   * Note that if you used [soup.server.Server.listenAll] the returned URIs will use
   * the addresses `0.0.0.0` and `::`, rather than actually returning separate
   * URIs for each interface on the system.
   * Returns: a list of #GUris, which you
   *   must free when you are done with it.
   */
  Uri[] getUris()
  {
    GSList* _cretval;
    _cretval = soup_server_get_uris(cast(SoupServer*)cPtr);
    auto _retval = gSListToD!(Uri, GidOwnership.Full)(cast(GSList*)_cretval);
    return _retval;
  }

  /**
   * Checks whether server is capable of https.
   * In order for a server to run https, you must call
   * [soup.server.Server.setTlsCertificate], or set the
   * propertyServer:tls-certificate property, to provide it with a
   * certificate to use.
   * If you are using the deprecated single-listener APIs, then a return value of
   * %TRUE indicates that the #SoupServer serves https exclusively. If you are
   * using [soup.server.Server.listen], etc, then a %TRUE return value merely indicates
   * that the server is *able* to do https, regardless of whether it actually
   * currently is or not. Use [soup.server.Server.getUris] to see if it currently has
   * any https listeners.
   * Returns: %TRUE if server is configured to serve https.
   */
  bool isHttps()
  {
    bool _retval;
    _retval = soup_server_is_https(cast(SoupServer*)cPtr);
    return _retval;
  }

  /**
   * Attempts to set up server to listen for connections on address.
   * If options includes %SOUP_SERVER_LISTEN_HTTPS, and server has
   * been configured for TLS, then server will listen for https
   * connections on this port. Otherwise it will listen for plain http.
   * You may call this method $(LPAREN)along with the other "listen" methods$(RPAREN)
   * any number of times on a server, if you want to listen on multiple
   * ports, or set up both http and https service.
   * After calling this method, server will begin accepting and processing
   * connections as soon as the appropriate [glib.main_context.MainContext] is run.
   * Note that this API does not make use of dual IPv4/IPv6 sockets; if
   * address is an IPv6 address, it will only accept IPv6 connections.
   * You must configure IPv4 listening separately.
   * Params:
   *   address = the address of the interface to listen on
   *   options = listening options for this server
   * Returns: %TRUE on success, %FALSE if address could not be
   *   bound or any other error occurred $(LPAREN)in which case error will be
   *   set$(RPAREN).
   */
  bool listen(SocketAddress address, ServerListenOptions options)
  {
    bool _retval;
    GError *_err;
    _retval = soup_server_listen(cast(SoupServer*)cPtr, address ? cast(GSocketAddress*)address.cPtr(No.Dup) : null, options, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Attempts to set up server to listen for connections on all interfaces
   * on the system.
   * That is, it listens on the addresses `0.0.0.0` and/or `::`, depending on
   * whether options includes %SOUP_SERVER_LISTEN_IPV4_ONLY,
   * %SOUP_SERVER_LISTEN_IPV6_ONLY, or neither.$(RPAREN) If port is specified, server
   * will listen on that port. If it is 0, server will find an unused port to
   * listen on. $(LPAREN)In that case, you can use [soup.server.Server.getUris] to find out
   * what port it ended up choosing.
   * See [soup.server.Server.listen] for more details.
   * Params:
   *   port = the port to listen on, or 0
   *   options = listening options for this server
   * Returns: %TRUE on success, %FALSE if port could not be bound
   *   or any other error occurred $(LPAREN)in which case error will be set$(RPAREN).
   */
  bool listenAll(uint port, ServerListenOptions options)
  {
    bool _retval;
    GError *_err;
    _retval = soup_server_listen_all(cast(SoupServer*)cPtr, port, options, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Attempts to set up server to listen for connections on "localhost".
   * That is, `127.0.0.1` and/or `::1`, depending on whether options includes
   * %SOUP_SERVER_LISTEN_IPV4_ONLY, %SOUP_SERVER_LISTEN_IPV6_ONLY, or neither$(RPAREN). If
   * port is specified, server will listen on that port. If it is 0, server
   * will find an unused port to listen on. $(LPAREN)In that case, you can use
   * [soup.server.Server.getUris] to find out what port it ended up choosing.
   * See [soup.server.Server.listen] for more details.
   * Params:
   *   port = the port to listen on, or 0
   *   options = listening options for this server
   * Returns: %TRUE on success, %FALSE if port could not be bound
   *   or any other error occurred $(LPAREN)in which case error will be set$(RPAREN).
   */
  bool listenLocal(uint port, ServerListenOptions options)
  {
    bool _retval;
    GError *_err;
    _retval = soup_server_listen_local(cast(SoupServer*)cPtr, port, options, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Attempts to set up server to listen for connections on socket.
   * See [soup.server.Server.listen] for more details.
   * Params:
   *   socket = a listening #GSocket
   *   options = listening options for this server
   * Returns: %TRUE on success, %FALSE if an error occurred $(LPAREN)in
   *   which case error will be set$(RPAREN).
   */
  bool listenSocket(Socket socket, ServerListenOptions options)
  {
    bool _retval;
    GError *_err;
    _retval = soup_server_listen_socket(cast(SoupServer*)cPtr, socket ? cast(GSocket*)socket.cPtr(No.Dup) : null, options, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Pauses I/O on msg.
   * This can be used when you need to return from the server handler without
   * having the full response ready yet. Use [soup.server.Server.unpauseMessage] to
   * resume I/O.
   * This must only be called on a classServerMessage which was created by the
   * #SoupServer and are currently doing I/O, such as those passed into a
   * callbackServerCallback or emitted in a signalServer::request-read
   * signal.
   * Params:
   *   msg = a #SoupServerMessage associated with server.

   * Deprecated: Use [soup.server_message.ServerMessage.pause] instead.
   */
  void pauseMessage(ServerMessage msg)
  {
    soup_server_pause_message(cast(SoupServer*)cPtr, msg ? cast(SoupServerMessage*)msg.cPtr(No.Dup) : null);
  }

  /**
   * Removes auth_domain from server.
   * Params:
   *   authDomain = a #SoupAuthDomain
   */
  void removeAuthDomain(AuthDomain authDomain)
  {
    soup_server_remove_auth_domain(cast(SoupServer*)cPtr, authDomain ? cast(SoupAuthDomain*)authDomain.cPtr(No.Dup) : null);
  }

  /**
   * Removes all handlers $(LPAREN)early and normal$(RPAREN) registered at path.
   * Params:
   *   path = the toplevel path for the handler
   */
  void removeHandler(string path)
  {
    const(char)* _path = path.toCString(No.Alloc);
    soup_server_remove_handler(cast(SoupServer*)cPtr, _path);
  }

  /**
   * Removes support for WebSocket extension of type extension_type $(LPAREN)or any subclass of
   * extension_type$(RPAREN) from server.
   * Params:
   *   extensionType = a #GType
   */
  void removeWebsocketExtension(GType extensionType)
  {
    soup_server_remove_websocket_extension(cast(SoupServer*)cPtr, extensionType);
  }

  /**
   * Sets server's #GTlsAuthenticationMode to use for SSL/TLS client authentication.
   * Params:
   *   mode = a #GTlsAuthenticationMode
   */
  void setTlsAuthMode(TlsAuthenticationMode mode)
  {
    soup_server_set_tls_auth_mode(cast(SoupServer*)cPtr, mode);
  }

  /**
   * Sets server up to do https, using the given SSL/TLS certificate.
   * Params:
   *   certificate = a #GTlsCertificate
   */
  void setTlsCertificate(TlsCertificate certificate)
  {
    soup_server_set_tls_certificate(cast(SoupServer*)cPtr, certificate ? cast(GTlsCertificate*)certificate.cPtr(No.Dup) : null);
  }

  /**
   * Sets server's #GTlsDatabase to use for validating SSL/TLS client certificates.
   * Params:
   *   tlsDatabase = a #GTlsDatabase
   */
  void setTlsDatabase(TlsDatabase tlsDatabase)
  {
    soup_server_set_tls_database(cast(SoupServer*)cPtr, tlsDatabase ? cast(GTlsDatabase*)tlsDatabase.cPtr(No.Dup) : null);
  }

  /**
   * Resumes I/O on msg.
   * Use this to resume after calling [soup.server.Server.pauseMessage], or after
   * adding a new chunk to a chunked response.
   * I/O won't actually resume until you return to the main loop.
   * This must only be called on a classServerMessage which was created by the
   * #SoupServer and are currently doing I/O, such as those passed into a
   * callbackServerCallback or emitted in a signalServer::request-read
   * signal.
   * Params:
   *   msg = a #SoupServerMessage associated with server.

   * Deprecated: Use [soup.server_message.ServerMessage.unpause] instead.
   */
  void unpauseMessage(ServerMessage msg)
  {
    soup_server_unpause_message(cast(SoupServer*)cPtr, msg ? cast(SoupServerMessage*)msg.cPtr(No.Dup) : null);
  }

  /**
   * Emitted when processing has failed for a message.
   * This could mean either that it could not be read $(LPAREN)if
   * signalServer::request-read has not been emitted for it yet$(RPAREN), or that
   * the response could not be written back $(LPAREN)if signalServer::request-read
   * has been emitted but signalServer::request-finished has not been$(RPAREN).
   * message is in an undefined state when this signal is
   * emitted; the signal exists primarily to allow the server to
   * free any state that it may have allocated in
   * signalServer::request-started.
   * Params
   *   message = the message
   *   server = the instance the signal is connected to
   */
  alias RequestAbortedCallbackDlg = void delegate(ServerMessage message, Server server);
  alias RequestAbortedCallbackFunc = void function(ServerMessage message, Server server);

  /**
   * Connect to RequestAborted signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRequestAborted(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RequestAbortedCallbackDlg) || is(T : RequestAbortedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto server = getVal!Server(_paramVals);
      auto message = getVal!ServerMessage(&_paramVals[1]);
      _dClosure.dlg(message, server);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("request-aborted", closure, after);
  }

  /**
   * Emitted when the server has finished writing a response to
   * a request.
   * Params
   *   message = the message
   *   server = the instance the signal is connected to
   */
  alias RequestFinishedCallbackDlg = void delegate(ServerMessage message, Server server);
  alias RequestFinishedCallbackFunc = void function(ServerMessage message, Server server);

  /**
   * Connect to RequestFinished signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRequestFinished(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RequestFinishedCallbackDlg) || is(T : RequestFinishedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto server = getVal!Server(_paramVals);
      auto message = getVal!ServerMessage(&_paramVals[1]);
      _dClosure.dlg(message, server);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("request-finished", closure, after);
  }

  /**
   * Emitted when the server has successfully read a request.
   * message will have all of its request-side information
   * filled in, and if the message was authenticated, client
   * will have information about that. This signal is emitted
   * before any $(LPAREN)non-early$(RPAREN) handlers are called for the message,
   * and if it sets the message's #status_code, then normal
   * handler processing will be skipped.
   * Params
   *   message = the message
   *   server = the instance the signal is connected to
   */
  alias RequestReadCallbackDlg = void delegate(ServerMessage message, Server server);
  alias RequestReadCallbackFunc = void function(ServerMessage message, Server server);

  /**
   * Connect to RequestRead signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRequestRead(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RequestReadCallbackDlg) || is(T : RequestReadCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto server = getVal!Server(_paramVals);
      auto message = getVal!ServerMessage(&_paramVals[1]);
      _dClosure.dlg(message, server);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("request-read", closure, after);
  }

  /**
   * Emitted when the server has started reading a new request.
   * message will be completely blank; not even the
   * Request-Line will have been read yet. About the only thing
   * you can usefully do with it is connect to its signals.
   * If the request is read successfully, this will eventually
   * be followed by a signalServer::request_read signal. If a
   * response is then sent, the request processing will end with
   * a signalServer::request-finished signal. If a network error
   * occurs, the processing will instead end with
   * signalServer::request-aborted.
   * Params
   *   message = the new message
   *   server = the instance the signal is connected to
   */
  alias RequestStartedCallbackDlg = void delegate(ServerMessage message, Server server);
  alias RequestStartedCallbackFunc = void function(ServerMessage message, Server server);

  /**
   * Connect to RequestStarted signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRequestStarted(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RequestStartedCallbackDlg) || is(T : RequestStartedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto server = getVal!Server(_paramVals);
      auto message = getVal!ServerMessage(&_paramVals[1]);
      _dClosure.dlg(message, server);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("request-started", closure, after);
  }
}
