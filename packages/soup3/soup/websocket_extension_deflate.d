module soup.websocket_extension_deflate;

import gid.global;
import soup.c.functions;
import soup.c.types;
import soup.types;
import soup.websocket_extension;

/**
 * A SoupWebsocketExtensionDeflate is a class@WebsocketExtension
 * implementing permessage-deflate $(LPAREN)RFC 7692$(RPAREN).
 * This extension is used by default in a class@Session when class@WebsocketExtensionManager
 * feature is present, and always used by class@Server.
 */
class WebsocketExtensionDeflate : WebsocketExtension
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())soup_websocket_extension_deflate_get_type != &gidSymbolNotFound ? soup_websocket_extension_deflate_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }
}
