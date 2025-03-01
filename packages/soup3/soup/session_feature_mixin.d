module soup.session_feature_mixin;

public import soup.session_feature_iface_proxy;
public import gid.global;
public import soup.c.functions;
public import soup.c.types;
public import soup.types;

/**
 * Interface for miscellaneous class@Session features.
 * #SoupSessionFeature is the interface used by classes that extend
 * the functionality of a class@Session. Some features like HTTP
 * authentication handling are implemented internally via
 * `SoupSessionFeature`s. Other features can be added to the session
 * by the application. $(LPAREN)Eg, class@Logger, class@CookieJar.$(RPAREN)
 * See [soup.session.Session.addFeature], etc, to add a feature to a session.
 */
template SessionFeatureT()
{
}
