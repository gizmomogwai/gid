module soup.session;

import gid.global;
import gio.async_result;
import gio.async_result_mixin;
import gio.cancellable;
import gio.inet_socket_address;
import gio.input_stream;
import gio.output_stream;
import gio.proxy_resolver;
import gio.proxy_resolver_mixin;
import gio.socket_connectable;
import gio.socket_connectable_mixin;
import gio.tls_database;
import gio.tls_interaction;
import gio.types;
import glib.bytes;
import glib.error;
import gobject.dclosure;
import gobject.object;
import gobject.types;
import soup.c.functions;
import soup.c.types;
import soup.message;
import soup.session_feature;
import soup.session_feature_mixin;
import soup.types;
import soup.websocket_connection;

/**
 * Soup session state object.
 * #SoupSession is the object that controls client-side HTTP. A
 * #SoupSession encapsulates all of the state that libsoup is keeping
 * on behalf of your program; cached HTTP connections, authentication
 * information, etc. It also keeps track of various global options
 * and features that you are using.
 * Most applications will only need a single #SoupSession; the primary
 * reason you might need multiple sessions is if you need to have
 * multiple independent authentication contexts. $(LPAREN)Eg, you are
 * connecting to a server and authenticating as two different users at
 * different times; the easiest way to ensure that each class@Message
 * is sent with the authentication information you intended is to use
 * one session for the first user, and a second session for the other
 * user.$(RPAREN)
 * Additional #SoupSession functionality is provided by
 * iface@SessionFeature objects, which can be added to a session with
 * [soup.session.Session.addFeature] or [soup.session.Session.addFeatureByType]
 * For example, class@Logger provides support for
 * logging HTTP traffic, class@ContentDecoder provides support for
 * compressed response handling, and class@ContentSniffer provides
 * support for HTML5-style response body content sniffing.
 * Additionally, subtypes of class@Auth can be added
 * as features, to add support for additional authentication types.
 * All `SoupSession`s are created with a class@AuthManager, and support
 * for %SOUP_TYPE_AUTH_BASIC and %SOUP_TYPE_AUTH_DIGEST. Additionally,
 * sessions using the plain #SoupSession class $(LPAREN)rather than one of its deprecated
 * subtypes$(RPAREN) have a class@ContentDecoder by default.
 * Note that all async methods will invoke their callbacks on the thread-default
 * context at the time of the function call.
 */
class Session : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())soup_session_get_type != &gidSymbolNotFound ? soup_session_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a #SoupSession with the default options.
   * Returns: the new session.
   */
  this()
  {
    SoupSession* _cretval;
    _cretval = soup_session_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Cancels all pending requests in session and closes all idle
   * persistent connections.
   */
  void abort()
  {
    soup_session_abort(cast(SoupSession*)cPtr);
  }

  /**
   * Adds feature's functionality to session. You cannot add multiple
   * features of the same aliasGLib.Type to a session.
   * See the main #SoupSession documentation for information on what
   * features are present in sessions by default.
   * Params:
   *   feature = an object that implements #SoupSessionFeature
   */
  void addFeature(SessionFeature feature)
  {
    soup_session_add_feature(cast(SoupSession*)cPtr, feature ? cast(SoupSessionFeature*)(cast(ObjectG)feature).cPtr(No.Dup) : null);
  }

  /**
   * If feature_type is the type of a class that implements
   * ifaceSessionFeature, this creates a new feature of that type and
   * adds it to session as with [soup.session.Session.addFeature]. You can use
   * this when you don't need to customize the new feature in any way.
   * Adding multiple features of the same feature_type is not allowed.
   * If feature_type is not a ifaceSessionFeature type, this gives each
   * existing feature on session the chance to accept feature_type as
   * a "subfeature". This can be used to add new classAuth types, for instance.
   * See the main #SoupSession documentation for information on what
   * features are present in sessions by default.
   * Params:
   *   featureType = a #GType
   */
  void addFeatureByType(GType featureType)
  {
    soup_session_add_feature_by_type(cast(SoupSession*)cPtr, featureType);
  }

  /**
   * Get the value used by session for the "Accept-Language" header on new
   * requests.
   * Returns: the accept language string
   */
  string getAcceptLanguage()
  {
    const(char)* _cretval;
    _cretval = soup_session_get_accept_language(cast(SoupSession*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets whether session automatically sets the "Accept-Language" header on new
   * requests.
   * Returns: %TRUE if session sets "Accept-Language" header automatically, or
   *   %FALSE otherwise.
   */
  bool getAcceptLanguageAuto()
  {
    bool _retval;
    _retval = soup_session_get_accept_language_auto(cast(SoupSession*)cPtr);
    return _retval;
  }

  /**
   * Gets the classMessage of the result asynchronous operation This is useful
   * to get the classMessage of an asynchronous operation started by session
   * from its [gio.AsyncReadyCallback].
   * Params:
   *   result = the #GAsyncResult passed to your callback
   * Returns: a #SoupMessage or
   *   %NULL if result is not a valid session async operation result.
   */
  Message getAsyncResultMessage(AsyncResult result)
  {
    SoupMessage* _cretval;
    _cretval = soup_session_get_async_result_message(cast(SoupSession*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!Message(cast(SoupMessage*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the feature in session of type feature_type.
   * Params:
   *   featureType = the #GType of the feature to get
   * Returns: a #SoupSessionFeature, or %NULL. The
   *   feature is owned by session.
   */
  SessionFeature getFeature(GType featureType)
  {
    SoupSessionFeature* _cretval;
    _cretval = soup_session_get_feature(cast(SoupSession*)cPtr, featureType);
    auto _retval = ObjectG.getDObject!SessionFeature(cast(SoupSessionFeature*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the feature in session of type feature_type, provided
   * that it is not disabled for msg.
   * Params:
   *   featureType = the #GType of the feature to get
   *   msg = a #SoupMessage
   * Returns: a #SoupSessionFeature. The feature is
   *   owned by session.
   */
  SessionFeature getFeatureForMessage(GType featureType, Message msg)
  {
    SoupSessionFeature* _cretval;
    _cretval = soup_session_get_feature_for_message(cast(SoupSession*)cPtr, featureType, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!SessionFeature(cast(SoupSessionFeature*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Get the timeout in seconds for idle connection lifetime currently used by
   * session.
   * Returns: the timeout in seconds
   */
  uint getIdleTimeout()
  {
    uint _retval;
    _retval = soup_session_get_idle_timeout(cast(SoupSession*)cPtr);
    return _retval;
  }

  /**
   * Get the [gio.inet_socket_address.InetSocketAddress] to use for the client side of
   * connections in session.
   * Returns: a #GInetSocketAddress
   */
  InetSocketAddress getLocalAddress()
  {
    GInetSocketAddress* _cretval;
    _cretval = soup_session_get_local_address(cast(SoupSession*)cPtr);
    auto _retval = ObjectG.getDObject!InetSocketAddress(cast(GInetSocketAddress*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Get the maximum number of connections that session can open at once.
   * Returns: the maximum number of connections
   */
  uint getMaxConns()
  {
    uint _retval;
    _retval = soup_session_get_max_conns(cast(SoupSession*)cPtr);
    return _retval;
  }

  /**
   * Get the maximum number of connections that session can open at once to a
   * given host.
   * Returns: the maximum number of connections per host
   */
  uint getMaxConnsPerHost()
  {
    uint _retval;
    _retval = soup_session_get_max_conns_per_host(cast(SoupSession*)cPtr);
    return _retval;
  }

  /**
   * Get the [gio.proxy_resolver.ProxyResolver] currently used by session.
   * Returns: a #GProxyResolver or %NULL if proxies
   *   are disabled in session
   */
  ProxyResolver getProxyResolver()
  {
    GProxyResolver* _cretval;
    _cretval = soup_session_get_proxy_resolver(cast(SoupSession*)cPtr);
    auto _retval = ObjectG.getDObject!ProxyResolver(cast(GProxyResolver*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets the remote connectable if one set.
   * Returns: the #GSocketConnectable
   */
  SocketConnectable getRemoteConnectable()
  {
    GSocketConnectable* _cretval;
    _cretval = soup_session_get_remote_connectable(cast(SoupSession*)cPtr);
    auto _retval = ObjectG.getDObject!SocketConnectable(cast(GSocketConnectable*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Get the timeout in seconds for socket I/O operations currently used by
   * session.
   * Returns: the timeout in seconds
   */
  uint getTimeout()
  {
    uint _retval;
    _retval = soup_session_get_timeout(cast(SoupSession*)cPtr);
    return _retval;
  }

  /**
   * Get the [gio.tls_database.TlsDatabase] currently used by session.
   * Returns: a #GTlsDatabase
   */
  TlsDatabase getTlsDatabase()
  {
    GTlsDatabase* _cretval;
    _cretval = soup_session_get_tls_database(cast(SoupSession*)cPtr);
    auto _retval = ObjectG.getDObject!TlsDatabase(cast(GTlsDatabase*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Get the [gio.tls_interaction.TlsInteraction] currently used by session.
   * Returns: a #GTlsInteraction
   */
  TlsInteraction getTlsInteraction()
  {
    GTlsInteraction* _cretval;
    _cretval = soup_session_get_tls_interaction(cast(SoupSession*)cPtr);
    auto _retval = ObjectG.getDObject!TlsInteraction(cast(GTlsInteraction*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Get the value used by session for the "User-Agent" header on new requests.
   * Returns: the user agent string
   */
  string getUserAgent()
  {
    const(char)* _cretval;
    _cretval = soup_session_get_user_agent(cast(SoupSession*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Tests if session has at a feature of type feature_type $(LPAREN)which can
   * be the type of either a ifaceSessionFeature, or else a subtype of
   * some class managed by another feature, such as classAuth$(RPAREN).
   * Params:
   *   featureType = the #GType of the class of features to check for
   * Returns: %TRUE or %FALSE
   */
  bool hasFeature(GType featureType)
  {
    bool _retval;
    _retval = soup_session_has_feature(cast(SoupSession*)cPtr, featureType);
    return _retval;
  }

  /**
   * Start a preconnection to msg.
   * Once the connection is done, it will remain in idle state so that it can be
   * reused by future requests. If there's already an idle connection for the
   * given msg host, the operation finishes successfully without creating a new
   * connection. If a new request for the given msg host is made while the
   * preconnect is still ongoing, the request will take the ownership of the
   * connection and the preconnect operation will finish successfully $(LPAREN)if there's
   * a connection error it will be handled by the request$(RPAREN).
   * The operation finishes when the connection is done or an error occurred.
   * Params:
   *   msg = a #SoupMessage
   *   ioPriority = the I/O priority of the request
   *   cancellable = a #GCancellable
   *   callback = the callback to invoke when the operation finishes
   */
  void preconnectAsync(Message msg, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    soup_session_preconnect_async(cast(SoupSession*)cPtr, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Complete a preconnect async operation started with [soup.session.Session.preconnectAsync].
   * Params:
   *   result = the #GAsyncResult passed to your callback
   * Returns: %TRUE if the preconnect succeeded, or %FALSE in case of error.
   */
  bool preconnectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = soup_session_preconnect_finish(cast(SoupSession*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Removes feature's functionality from session.
   * Params:
   *   feature = a feature that has previously been added to session
   */
  void removeFeature(SessionFeature feature)
  {
    soup_session_remove_feature(cast(SoupSession*)cPtr, feature ? cast(SoupSessionFeature*)(cast(ObjectG)feature).cPtr(No.Dup) : null);
  }

  /**
   * Removes all features of type feature_type $(LPAREN)or any subclass of
   * feature_type$(RPAREN) from session.
   * Params:
   *   featureType = a #GType
   */
  void removeFeatureByType(GType featureType)
  {
    soup_session_remove_feature_by_type(cast(SoupSession*)cPtr, featureType);
  }

  /**
   * Synchronously sends msg and waits for the beginning of a response.
   * On success, a [gio.input_stream.InputStream] will be returned which you can use to
   * read the response body. $(LPAREN)"Success" here means only that an HTTP
   * response was received and understood; it does not necessarily mean
   * that a 2xx class status code was received.$(RPAREN)
   * If non-%NULL, cancellable can be used to cancel the request;
   * [soup.session.Session.send] will return a %G_IO_ERROR_CANCELLED error. Note that
   * with requests that have side effects $(LPAREN)eg, `POST`, `PUT`, `DELETE`$(RPAREN) it is
   * possible that you might cancel the request after the server acts on it, but
   * before it returns a response, leaving the remote resource in an unknown
   * state.
   * If msg is requeued due to a redirect or authentication, the
   * initial $(LPAREN)`3xx/401/407`$(RPAREN) response body will be suppressed, and
   * [soup.session.Session.send] will only return once a final response has been
   * received.
   * Params:
   *   msg = a #SoupMessage
   *   cancellable = a #GCancellable
   * Returns: a #GInputStream for reading the
   *   response body, or %NULL on error.
   */
  InputStream send(Message msg, Cancellable cancellable)
  {
    GInputStream* _cretval;
    GError *_err;
    _cretval = soup_session_send(cast(SoupSession*)cPtr, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Synchronously sends msg and reads the response body.
   * On success, a [glib.bytes.Bytes] will be returned with the response body.
   * This function should only be used when the resource to be retrieved
   * is not too long and can be stored in memory.
   * See [soup.session.Session.send] for more details on the general semantics.
   * Params:
   *   msg = a #SoupMessage
   *   cancellable = a #GCancellable
   * Returns: a #GBytes, or %NULL on error.
   */
  Bytes sendAndRead(Message msg, Cancellable cancellable)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = soup_session_send_and_read(cast(SoupSession*)cPtr, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Asynchronously sends msg and reads the response body.
   * When callback is called, then either msg has been sent, and its response
   * body read, or else an error has occurred. This function should only be used
   * when the resource to be retrieved is not too long and can be stored in
   * memory. Call [soup.session.Session.sendAndReadFinish] to get a
   * [glib.bytes.Bytes] with the response body.
   * See [soup.session.Session.send] for more details on the general semantics.
   * Params:
   *   msg = a #SoupMessage
   *   ioPriority = the I/O priority of the request
   *   cancellable = a #GCancellable
   *   callback = the callback to invoke
   */
  void sendAndReadAsync(Message msg, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    soup_session_send_and_read_async(cast(SoupSession*)cPtr, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Gets the response to a [soup.session.Session.sendAndReadAsync].
   * If successful, returns a [glib.bytes.Bytes] with the response body.
   * Params:
   *   result = the #GAsyncResult passed to your callback
   * Returns: a #GBytes, or %NULL on error.
   */
  Bytes sendAndReadFinish(AsyncResult result)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = soup_session_send_and_read_finish(cast(SoupSession*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Synchronously sends msg and splices the response body stream into out_stream.
   * See [soup.session.Session.send] for more details on the general semantics.
   * Params:
   *   msg = a #SoupMessage
   *   outStream = a #GOutputStream
   *   flags = a set of #GOutputStreamSpliceFlags
   *   cancellable = a #GCancellable
   * Returns: a #gssize containing the size of the data spliced, or -1 if an error occurred.
   */
  ptrdiff_t sendAndSplice(Message msg, OutputStream outStream, OutputStreamSpliceFlags flags, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = soup_session_send_and_splice(cast(SoupSession*)cPtr, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null, outStream ? cast(GOutputStream*)outStream.cPtr(No.Dup) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously sends msg and splices the response body stream into out_stream.
   * When callback is called, then either msg has been sent and its response body
   * spliced, or else an error has occurred.
   * See [soup.session.Session.send] for more details on the general semantics.
   * Params:
   *   msg = a #SoupMessage
   *   outStream = a #GOutputStream
   *   flags = a set of #GOutputStreamSpliceFlags
   *   ioPriority = the I/O priority of the request
   *   cancellable = a #GCancellable
   *   callback = the callback to invoke
   */
  void sendAndSpliceAsync(Message msg, OutputStream outStream, OutputStreamSpliceFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    soup_session_send_and_splice_async(cast(SoupSession*)cPtr, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null, outStream ? cast(GOutputStream*)outStream.cPtr(No.Dup) : null, flags, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Gets the response to a [soup.session.Session.sendAndSpliceAsync].
   * Params:
   *   result = the #GAsyncResult passed to your callback
   * Returns: a #gssize containing the size of the data spliced, or -1 if an error occurred.
   */
  ptrdiff_t sendAndSpliceFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = soup_session_send_and_splice_finish(cast(SoupSession*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously sends msg and waits for the beginning of a response.
   * When callback is called, then either msg has been sent, and its response
   * headers received, or else an error has occurred. Call
   * [soup.session.Session.sendFinish] to get a [gio.input_stream.InputStream] for reading the
   * response body.
   * See [soup.session.Session.send] for more details on the general semantics.
   * Params:
   *   msg = a #SoupMessage
   *   ioPriority = the I/O priority of the request
   *   cancellable = a #GCancellable
   *   callback = the callback to invoke
   */
  void sendAsync(Message msg, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    soup_session_send_async(cast(SoupSession*)cPtr, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Gets the response to a [soup.session.Session.sendAsync] call.
   * If successful returns a [gio.input_stream.InputStream] that can be used to read the
   * response body.
   * Params:
   *   result = the #GAsyncResult passed to your callback
   * Returns: a #GInputStream for reading the
   *   response body, or %NULL on error.
   */
  InputStream sendFinish(AsyncResult result)
  {
    GInputStream* _cretval;
    GError *_err;
    _cretval = soup_session_send_finish(cast(SoupSession*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Set the value to use for the "Accept-Language" header on classMessages
   * sent from session.
   * If accept_language is %NULL then no "Accept-Language" will be included in
   * requests. See propertySession:accept-language for more information.
   * Params:
   *   acceptLanguage = the languages string
   */
  void setAcceptLanguage(string acceptLanguage)
  {
    const(char)* _acceptLanguage = acceptLanguage.toCString(No.Alloc);
    soup_session_set_accept_language(cast(SoupSession*)cPtr, _acceptLanguage);
  }

  /**
   * Set whether session will automatically set the "Accept-Language" header on
   * requests using a value generated from system languages based on
   * funcGLib.get_language_names.
   * See propertySession:accept-language-auto for more information.
   * Params:
   *   acceptLanguageAuto = the value to set
   */
  void setAcceptLanguageAuto(bool acceptLanguageAuto)
  {
    soup_session_set_accept_language_auto(cast(SoupSession*)cPtr, acceptLanguageAuto);
  }

  /**
   * Set a timeout in seconds for idle connection lifetime to be used by session
   * on new connections.
   * See propertySession:idle-timeout for more information.
   * Params:
   *   timeout = a timeout in seconds
   */
  void setIdleTimeout(uint timeout)
  {
    soup_session_set_idle_timeout(cast(SoupSession*)cPtr, timeout);
  }

  /**
   * Set a [gio.proxy_resolver.ProxyResolver] to be used by session on new connections.
   * If proxy_resolver is %NULL then no proxies will be used. See
   * propertySession:proxy-resolver for more information.
   * Params:
   *   proxyResolver = a #GProxyResolver or %NULL
   */
  void setProxyResolver(ProxyResolver proxyResolver)
  {
    soup_session_set_proxy_resolver(cast(SoupSession*)cPtr, proxyResolver ? cast(GProxyResolver*)(cast(ObjectG)proxyResolver).cPtr(No.Dup) : null);
  }

  /**
   * Set a timeout in seconds for socket I/O operations to be used by session
   * on new connections.
   * See propertySession:timeout for more information.
   * Params:
   *   timeout = a timeout in seconds
   */
  void setTimeout(uint timeout)
  {
    soup_session_set_timeout(cast(SoupSession*)cPtr, timeout);
  }

  /**
   * Set a classGIo.TlsDatabase to be used by session on new connections.
   * If tls_database is %NULL then certificate validation will always fail. See
   * propertySession:tls-database for more information.
   * Params:
   *   tlsDatabase = a #GTlsDatabase
   */
  void setTlsDatabase(TlsDatabase tlsDatabase)
  {
    soup_session_set_tls_database(cast(SoupSession*)cPtr, tlsDatabase ? cast(GTlsDatabase*)tlsDatabase.cPtr(No.Dup) : null);
  }

  /**
   * Set a [gio.tls_interaction.TlsInteraction] to be used by session on new connections.
   * If tls_interaction is %NULL then client certificate validation will always
   * fail.
   * See propertySession:tls-interaction for more information.
   * Params:
   *   tlsInteraction = a #GTlsInteraction
   */
  void setTlsInteraction(TlsInteraction tlsInteraction)
  {
    soup_session_set_tls_interaction(cast(SoupSession*)cPtr, tlsInteraction ? cast(GTlsInteraction*)tlsInteraction.cPtr(No.Dup) : null);
  }

  /**
   * Set the value to use for the "User-Agent" header on classMessages sent
   * from session.
   * If user_agent has trailing whitespace, session will append its own product
   * token $(LPAREN)eg, `libsoup/3.0.0`$(RPAREN) to the end of the header for you. If user_agent
   * is %NULL then no "User-Agent" will be included in requests. See
   * propertySession:user-agent for more information.
   * Params:
   *   userAgent = the user agent string
   */
  void setUserAgent(string userAgent)
  {
    const(char)* _userAgent = userAgent.toCString(No.Alloc);
    soup_session_set_user_agent(cast(SoupSession*)cPtr, _userAgent);
  }

  /**
   * Asynchronously creates a classWebsocketConnection to communicate with a
   * remote server.
   * All necessary WebSocket-related headers will be added to msg, and
   * it will then be sent and asynchronously processed normally
   * $(LPAREN)including handling of redirection and HTTP authentication$(RPAREN).
   * If the server returns "101 Switching Protocols", then msg's status
   * code and response headers will be updated, and then the WebSocket
   * handshake will be completed. On success,
   * [soup.session.Session.websocketConnectFinish] will return a new
   * classWebsocketConnection. On failure it will return a #GError.
   * If the server returns a status other than "101 Switching Protocols", then
   * msg will contain the complete response headers and body from the server's
   * response, and [soup.session.Session.websocketConnectFinish] will return
   * %SOUP_WEBSOCKET_ERROR_NOT_WEBSOCKET.
   * Params:
   *   msg = #SoupMessage indicating the WebSocket server to connect to
   *   origin = origin of the connection
   *   protocols = a
   *     %NULL-terminated array of protocols supported
   *   ioPriority = the I/O priority of the request
   *   cancellable = a #GCancellable
   *   callback = the callback to invoke
   */
  void websocketConnectAsync(Message msg, string origin, string[] protocols, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    const(char)* _origin = origin.toCString(No.Alloc);
    char*[] _tmpprotocols;
    foreach (s; protocols)
      _tmpprotocols ~= s.toCString(No.Alloc);
    _tmpprotocols ~= null;
    char** _protocols = _tmpprotocols.ptr;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    soup_session_websocket_connect_async(cast(SoupSession*)cPtr, msg ? cast(SoupMessage*)msg.cPtr(No.Dup) : null, _origin, _protocols, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Gets the classWebsocketConnection response to a
   * [soup.session.Session.websocketConnectAsync] call.
   * If successful, returns a classWebsocketConnection that can be used to
   * communicate with the server.
   * Params:
   *   result = the #GAsyncResult passed to your callback
   * Returns: a new #SoupWebsocketConnection, or
   *   %NULL on error.
   */
  WebsocketConnection websocketConnectFinish(AsyncResult result)
  {
    SoupWebsocketConnection* _cretval;
    GError *_err;
    _cretval = soup_session_websocket_connect_finish(cast(SoupSession*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = ObjectG.getDObject!WebsocketConnection(cast(SoupWebsocketConnection*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Emitted when a request is queued on session.
   * When sending a request, first signalSession::request-queued
   * is emitted, indicating that the session has become aware of
   * the request.
   * After a connection is available to send the request various
   * classMessage signals are emitted as the message is
   * processed. If the message is requeued, it will emit
   * signalMessage::restarted, which will then be followed by other
   * classMessage signals when the message is re-sent.
   * Eventually, the message will emit signalMessage::finished.
   * Normally, this signals the completion of message
   * processing. However, it is possible that the application
   * will requeue the message from the "finished" handler.
   * In that case the process will loop back.
   * Eventually, a message will reach "finished" and not be
   * requeued. At that point, the session will emit
   * signalSession::request-unqueued to indicate that it is done
   * with the message.
   * To sum up: signalSession::request-queued and
   * signalSession::request-unqueued are guaranteed to be emitted
   * exactly once, but signalMessage::finished $(LPAREN)and all of the other
   * classMessage signals$(RPAREN) may be invoked multiple times for a given
   * message.
   * Params
   *   msg = the request that was queued
   *   session = the instance the signal is connected to
   */
  alias RequestQueuedCallbackDlg = void delegate(Message msg, Session session);
  alias RequestQueuedCallbackFunc = void function(Message msg, Session session);

  /**
   * Connect to RequestQueued signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRequestQueued(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RequestQueuedCallbackDlg) || is(T : RequestQueuedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto session = getVal!Session(_paramVals);
      auto msg = getVal!Message(&_paramVals[1]);
      _dClosure.dlg(msg, session);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("request-queued", closure, after);
  }

  /**
   * Emitted when a request is removed from session's queue,
   * indicating that session is done with it.
   * See signalSession::request-queued for a detailed description of
   * the message lifecycle within a session.
   * Params
   *   msg = the request that was unqueued
   *   session = the instance the signal is connected to
   */
  alias RequestUnqueuedCallbackDlg = void delegate(Message msg, Session session);
  alias RequestUnqueuedCallbackFunc = void function(Message msg, Session session);

  /**
   * Connect to RequestUnqueued signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRequestUnqueued(T)(T callback, Flag!"After" after = No.After)
  if (is(T : RequestUnqueuedCallbackDlg) || is(T : RequestUnqueuedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto session = getVal!Session(_paramVals);
      auto msg = getVal!Message(&_paramVals[1]);
      _dClosure.dlg(msg, session);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("request-unqueued", closure, after);
  }
}
