module arrow.writable_file;

public import arrow.writable_file_iface_proxy;
import arrow.c.functions;
import arrow.c.types;
import arrow.types;
import gid.global;
import glib.error;

interface WritableFile
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())garrow_writable_file_get_type != &gidSymbolNotFound ? garrow_writable_file_get_type() : cast(GType)0;
  }

  bool writeAt(long position, ubyte[] data);
}
