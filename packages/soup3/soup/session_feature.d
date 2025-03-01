module soup.session_feature;

public import soup.session_feature_iface_proxy;
import gid.global;
import soup.c.functions;
import soup.c.types;
import soup.types;

/**
 * Interface for miscellaneous class@Session features.
 * #SoupSessionFeature is the interface used by classes that extend
 * the functionality of a class@Session. Some features like HTTP
 * authentication handling are implemented internally via
 * `SoupSessionFeature`s. Other features can be added to the session
 * by the application. $(LPAREN)Eg, class@Logger, class@CookieJar.$(RPAREN)
 * See [soup.session.Session.addFeature], etc, to add a feature to a session.
 */
interface SessionFeature
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())soup_session_feature_get_type != &gidSymbolNotFound ? soup_session_feature_get_type() : cast(GType)0;
  }
}
