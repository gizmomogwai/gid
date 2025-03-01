module soup.auth_manager;

import gid.global;
import glib.uri;
import gobject.object;
import soup.auth;
import soup.c.functions;
import soup.c.types;
import soup.session_feature;
import soup.session_feature_mixin;
import soup.types;

/**
 * HTTP client-side authentication handler.
 * #SoupAuthManager is the iface@SessionFeature that handles HTTP
 * authentication for a class@Session.
 * A #SoupAuthManager is added to the session by default, and normally
 * you don't need to worry about it at all. However, if you want to
 * disable HTTP authentication, you can remove the feature from the
 * session with [soup.session.Session.removeFeatureByType] or disable it on
 * individual requests with [soup.message.Message.disableFeature].
 * You can use this with [soup.session.Session.removeFeatureByType] or
 * [soup.message.Message.disableFeature].
 * $(LPAREN)Although this type has only been publicly visible since libsoup 2.42, it has
 * always existed in the background, and you can use `g_type_from_name
 * $(LPAREN)"SoupAuthManager"$(RPAREN)` to get its alias@GLib.Type in earlier releases.$(RPAREN)
 */
class AuthManager : ObjectG, SessionFeature
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())soup_auth_manager_get_type != &gidSymbolNotFound ? soup_auth_manager_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SessionFeatureT!();

  /**
   * Clear all credentials cached by manager.
   */
  void clearCachedCredentials()
  {
    soup_auth_manager_clear_cached_credentials(cast(SoupAuthManager*)cPtr);
  }

  /**
   * Records that auth is to be used under uri, as though a
   * WWW-Authenticate header had been received at that URI.
   * This can be used to "preload" manager's auth cache, to avoid an extra HTTP
   * round trip in the case where you know ahead of time that a 401 response will
   * be returned.
   * This is only useful for authentication types where the initial
   * Authorization header does not depend on any additional information
   * from the server. $(LPAREN)Eg, Basic or NTLM, but not Digest.$(RPAREN)
   * Params:
   *   uri = the #GUri under which auth is to be used
   *   auth = the #SoupAuth to use
   */
  void useAuth(Uri uri, Auth auth)
  {
    soup_auth_manager_use_auth(cast(SoupAuthManager*)cPtr, uri ? cast(GUri*)uri.cPtr(No.Dup) : null, auth ? cast(SoupAuth*)auth.cPtr(No.Dup) : null);
  }
}
