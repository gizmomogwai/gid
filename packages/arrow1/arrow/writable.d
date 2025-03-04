module arrow.writable;

public import arrow.writable_iface_proxy;
import arrow.c.functions;
import arrow.c.types;
import arrow.types;
import gid.global;
import glib.error;

interface Writable
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_writable_get_type != &gidSymbolNotFound ? garrow_writable_get_type() : cast(GType)0;
  }

  /**
   * It ensures writing all data on memory to storage.
   * Returns: %TRUE on success, %FALSE if there was an error.
   */
  bool flush();

  bool write(ubyte[] data);
}
