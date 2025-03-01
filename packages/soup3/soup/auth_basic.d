module soup.auth_basic;

import gid.global;
import soup.auth;
import soup.c.functions;
import soup.c.types;
import soup.types;

/**
 * HTTP "Basic" authentication.
 * class@Sessions support this by default; if you want to disable
 * support for it, call [soup.session.Session.removeFeatureByType],
 * passing %SOUP_TYPE_AUTH_BASIC.
 */
class AuthBasic : Auth
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())soup_auth_basic_get_type != &gidSymbolNotFound ? soup_auth_basic_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }
}
