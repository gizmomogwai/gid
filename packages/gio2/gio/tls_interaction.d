module gio.tls_interaction;

import gid.global;
import gio.async_result;
import gio.async_result_mixin;
import gio.c.functions;
import gio.c.types;
import gio.cancellable;
import gio.tls_connection;
import gio.tls_password;
import gio.types;
import glib.error;
import gobject.object;

/**
 * `GTlsInteraction` provides a mechanism for the TLS connection and database
 * code to interact with the user. It can be used to ask the user for passwords.
 * To use a `GTlsInteraction` with a TLS connection use
 * [gio.tls_connection.TlsConnection.setInteraction].
 * Callers should instantiate a derived class that implements the various
 * interaction methods to show the required dialogs.
 * Callers should use the 'invoke' functions like
 * [gio.tls_interaction.TlsInteraction.invokeAskPassword] to run interaction methods.
 * These functions make sure that the interaction is invoked in the main loop
 * and not in the current thread, if the current thread is not running the
 * main loop.
 * Derived classes can choose to implement whichever interactions methods they’d
 * like to support by overriding those virtual methods in their class
 * initialization function. Any interactions not implemented will return
 * `G_TLS_INTERACTION_UNHANDLED`. If a derived class implements an async method,
 * it must also implement the corresponding finish method.
 */
class TlsInteraction : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_tls_interaction_get_type != &gidSymbolNotFound ? g_tls_interaction_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Run synchronous interaction to ask the user for a password. In general,
   * [gio.tls_interaction.TlsInteraction.invokeAskPassword] should be used instead of this
   * function.
   * Derived subclasses usually implement a password prompt, although they may
   * also choose to provide a password from elsewhere. The password value will
   * be filled in and then callback will be called. Alternatively the user may
   * abort this password request, which will usually abort the TLS connection.
   * If the interaction is cancelled by the cancellation object, or by the
   * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
   * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
   * not support immediate cancellation.
   * Params:
   *   password = a #GTlsPassword object
   *   cancellable = an optional #GCancellable cancellation object
   * Returns: The status of the ask password interaction.
   */
  TlsInteractionResult askPassword(TlsPassword password, Cancellable cancellable)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_ask_password(cast(GTlsInteraction*)cPtr, password ? cast(GTlsPassword*)password.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * Run asynchronous interaction to ask the user for a password. In general,
   * [gio.tls_interaction.TlsInteraction.invokeAskPassword] should be used instead of this
   * function.
   * Derived subclasses usually implement a password prompt, although they may
   * also choose to provide a password from elsewhere. The password value will
   * be filled in and then callback will be called. Alternatively the user may
   * abort this password request, which will usually abort the TLS connection.
   * If the interaction is cancelled by the cancellation object, or by the
   * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
   * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
   * not support immediate cancellation.
   * Certain implementations may not support immediate cancellation.
   * Params:
   *   password = a #GTlsPassword object
   *   cancellable = an optional #GCancellable cancellation object
   *   callback = will be called when the interaction completes
   */
  void askPasswordAsync(TlsPassword password, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_tls_interaction_ask_password_async(cast(GTlsInteraction*)cPtr, password ? cast(GTlsPassword*)password.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Complete an ask password user interaction request. This should be once
   * the [gio.tls_interaction.TlsInteraction.askPasswordAsync] completion callback is called.
   * If %G_TLS_INTERACTION_HANDLED is returned, then the #GTlsPassword passed
   * to [gio.tls_interaction.TlsInteraction.askPassword] will have its password filled in.
   * If the interaction is cancelled by the cancellation object, or by the
   * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
   * contains a %G_IO_ERROR_CANCELLED error code.
   * Params:
   *   result = the result passed to the callback
   * Returns: The status of the ask password interaction.
   */
  TlsInteractionResult askPasswordFinish(AsyncResult result)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_ask_password_finish(cast(GTlsInteraction*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * Invoke the interaction to ask the user for a password. It invokes this
   * interaction in the main loop, specifically the #GMainContext returned by
   * [glib.main_context.MainContext.getThreadDefault] when the interaction is created. This
   * is called by called by #GTlsConnection or #GTlsDatabase to ask the user
   * for a password.
   * Derived subclasses usually implement a password prompt, although they may
   * also choose to provide a password from elsewhere. The password value will
   * be filled in and then callback will be called. Alternatively the user may
   * abort this password request, which will usually abort the TLS connection.
   * The implementation can either be a synchronous $(LPAREN)eg: modal dialog$(RPAREN) or an
   * asynchronous one $(LPAREN)eg: modeless dialog$(RPAREN). This function will take care of
   * calling which ever one correctly.
   * If the interaction is cancelled by the cancellation object, or by the
   * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
   * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
   * not support immediate cancellation.
   * Params:
   *   password = a #GTlsPassword object
   *   cancellable = an optional #GCancellable cancellation object
   * Returns: The status of the ask password interaction.
   */
  TlsInteractionResult invokeAskPassword(TlsPassword password, Cancellable cancellable)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_invoke_ask_password(cast(GTlsInteraction*)cPtr, password ? cast(GTlsPassword*)password.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * Invoke the interaction to ask the user to choose a certificate to
   * use with the connection. It invokes this interaction in the main
   * loop, specifically the #GMainContext returned by
   * [glib.main_context.MainContext.getThreadDefault] when the interaction is
   * created. This is called by called by #GTlsConnection when the peer
   * requests a certificate during the handshake.
   * Derived subclasses usually implement a certificate selector,
   * although they may also choose to provide a certificate from
   * elsewhere. Alternatively the user may abort this certificate
   * request, which may or may not abort the TLS connection.
   * The implementation can either be a synchronous $(LPAREN)eg: modal dialog$(RPAREN) or an
   * asynchronous one $(LPAREN)eg: modeless dialog$(RPAREN). This function will take care of
   * calling which ever one correctly.
   * If the interaction is cancelled by the cancellation object, or by the
   * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
   * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
   * not support immediate cancellation.
   * Params:
   *   connection = a #GTlsConnection object
   *   flags = flags providing more information about the request
   *   cancellable = an optional #GCancellable cancellation object
   * Returns: The status of the certificate request interaction.
   */
  TlsInteractionResult invokeRequestCertificate(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_invoke_request_certificate(cast(GTlsInteraction*)cPtr, connection ? cast(GTlsConnection*)connection.cPtr(No.Dup) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * Run synchronous interaction to ask the user to choose a certificate to use
   * with the connection. In general, [gio.tls_interaction.TlsInteraction.invokeRequestCertificate]
   * should be used instead of this function.
   * Derived subclasses usually implement a certificate selector, although they may
   * also choose to provide a certificate from elsewhere. Alternatively the user may
   * abort this certificate request, which will usually abort the TLS connection.
   * If %G_TLS_INTERACTION_HANDLED is returned, then the #GTlsConnection
   * passed to [gio.tls_interaction.TlsInteraction.requestCertificate] will have had its
   * #GTlsConnection:certificate filled in.
   * If the interaction is cancelled by the cancellation object, or by the
   * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
   * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
   * not support immediate cancellation.
   * Params:
   *   connection = a #GTlsConnection object
   *   flags = flags providing more information about the request
   *   cancellable = an optional #GCancellable cancellation object
   * Returns: The status of the request certificate interaction.
   */
  TlsInteractionResult requestCertificate(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_request_certificate(cast(GTlsInteraction*)cPtr, connection ? cast(GTlsConnection*)connection.cPtr(No.Dup) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }

  /**
   * Run asynchronous interaction to ask the user for a certificate to use with
   * the connection. In general, [gio.tls_interaction.TlsInteraction.invokeRequestCertificate] should
   * be used instead of this function.
   * Derived subclasses usually implement a certificate selector, although they may
   * also choose to provide a certificate from elsewhere. callback will be called
   * when the operation completes. Alternatively the user may abort this certificate
   * request, which will usually abort the TLS connection.
   * Params:
   *   connection = a #GTlsConnection object
   *   flags = flags providing more information about the request
   *   cancellable = an optional #GCancellable cancellation object
   *   callback = will be called when the interaction completes
   */
  void requestCertificateAsync(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_tls_interaction_request_certificate_async(cast(GTlsInteraction*)cPtr, connection ? cast(GTlsConnection*)connection.cPtr(No.Dup) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Complete a request certificate user interaction request. This should be once
   * the [gio.tls_interaction.TlsInteraction.requestCertificateAsync] completion callback is called.
   * If %G_TLS_INTERACTION_HANDLED is returned, then the #GTlsConnection
   * passed to [gio.tls_interaction.TlsInteraction.requestCertificateAsync] will have had its
   * #GTlsConnection:certificate filled in.
   * If the interaction is cancelled by the cancellation object, or by the
   * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
   * contains a %G_IO_ERROR_CANCELLED error code.
   * Params:
   *   result = the result passed to the callback
   * Returns: The status of the request certificate interaction.
   */
  TlsInteractionResult requestCertificateFinish(AsyncResult result)
  {
    GTlsInteractionResult _cretval;
    GError *_err;
    _cretval = g_tls_interaction_request_certificate_finish(cast(GTlsInteraction*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsInteractionResult _retval = cast(TlsInteractionResult)_cretval;
    return _retval;
  }
}
