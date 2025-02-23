module gio.pollable_output_stream_iface_proxy;

import gobject.object;
import gio.pollable_output_stream;
import gio.pollable_output_stream_mixin;

/// Proxy object for Gio.PollableOutputStream interface when a GObject has no applicable D binding
class PollableOutputStreamIfaceProxy : IfaceProxy, PollableOutputStream
{
  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(PollableOutputStream);
  }

  mixin PollableOutputStreamT!();
}
