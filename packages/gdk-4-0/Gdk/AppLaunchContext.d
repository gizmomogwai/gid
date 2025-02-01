module Gdk.AppLaunchContext;

import GObject.ObjectG;
import Gdk.Display;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.AppLaunchContext : DGioAppLaunchContext = AppLaunchContext;
import Gio.Icon;
import Gio.IconT;

/**
 * `GdkAppLaunchContext` handles launching an application in a graphical context.
 * It is an implementation of `GAppLaunchContext` that provides startup
 * notification and allows to launch applications on a specific workspace.
 * ## Launching an application
 * ```c
 * GdkAppLaunchContext *context;
 * context \= gdk_display_get_app_launch_context $(LPAREN)display$(RPAREN);
 * gdk_app_launch_context_set_timestamp $(LPAREN)gdk_event_get_time $(LPAREN)event$(RPAREN)$(RPAREN);
 * if $(LPAREN)!g_app_info_launch_default_for_uri $(LPAREN)"http://www.gtk.org", context, &error$(RPAREN)$(RPAREN)
 * g_warning $(LPAREN)"Launching failed: %s\n", error->message$(RPAREN);
 * g_object_unref $(LPAREN)context$(RPAREN);
 * ```
 */
class AppLaunchContext : DGioAppLaunchContext
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    return gdk_app_launch_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the `GdkDisplay` that context is for.
   * Returns: the display of context
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_app_launch_context_get_display(cast(GdkAppLaunchContext*)cPtr);
    auto _retval = ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Sets the workspace on which applications will be launched.
   * This only works when running under a window manager that
   * supports multiple workspaces, as described in the
   * [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec).
   * Specifically this sets the `_NET_WM_DESKTOP` property described
   * in that spec.
   * This only works when using the X11 backend.
   * When the workspace is not specified or desktop is set to -1,
   * it is up to the window manager to pick one, typically it will
   * be the current workspace.
   * Params:
   *   desktop = the number of a workspace, or -1
   */
  void setDesktop(int desktop)
  {
    gdk_app_launch_context_set_desktop(cast(GdkAppLaunchContext*)cPtr, desktop);
  }

  /**
   * Sets the icon for applications that are launched with this
   * context.
   * Window Managers can use this information when displaying startup
   * notification.
   * See also [Gdk.AppLaunchContext.setIconName].
   * Params:
   *   icon = a `GIcon`
   */
  void setIcon(Icon icon)
  {
    gdk_app_launch_context_set_icon(cast(GdkAppLaunchContext*)cPtr, icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(No.Dup) : null);
  }

  /**
   * Sets the icon for applications that are launched with this context.
   * The icon_name will be interpreted in the same way as the Icon field
   * in desktop files. See also [Gdk.AppLaunchContext.setIcon].
   * If both icon and icon_name are set, the icon_name takes priority.
   * If neither icon or icon_name is set, the icon is taken from either
   * the file that is passed to launched application or from the `GAppInfo`
   * for the launched application itself.
   * Params:
   *   iconName = an icon name
   */
  void setIconName(string iconName)
  {
    const(char)* _iconName = iconName.toCString(No.Alloc);
    gdk_app_launch_context_set_icon_name(cast(GdkAppLaunchContext*)cPtr, _iconName);
  }

  /**
   * Sets the timestamp of context.
   * The timestamp should ideally be taken from the event that
   * triggered the launch.
   * Window managers can use this information to avoid moving the
   * focus to the newly launched application when the user is busy
   * typing in another window. This is also known as 'focus stealing
   * prevention'.
   * Params:
   *   timestamp = a timestamp
   */
  void setTimestamp(uint timestamp)
  {
    gdk_app_launch_context_set_timestamp(cast(GdkAppLaunchContext*)cPtr, timestamp);
  }
}
