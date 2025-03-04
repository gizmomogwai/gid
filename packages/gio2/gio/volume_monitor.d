module gio.volume_monitor;

import gid.global;
import gio.c.functions;
import gio.c.types;
import gio.drive;
import gio.drive_mixin;
import gio.mount;
import gio.mount_mixin;
import gio.types;
import gio.volume;
import gio.volume_mixin;
import gobject.dclosure;
import gobject.object;

/**
 * `GVolumeMonitor` is for listing the user interesting devices and volumes
 * on the computer. In other words, what a file selector or file manager
 * would show in a sidebar.
 * `GVolumeMonitor` is not
 * thread-default-context aware $(LPAREN)see
 * [glib.main_context.MainContext.pushThreadDefault]$(RPAREN), and so should not be used
 * other than from the main thread, with no thread-default-context active.
 * In order to receive updates about volumes and mounts monitored through GVFS,
 * a main loop must be running.
 */
class VolumeMonitor : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())g_volume_monitor_get_type != &gidSymbolNotFound ? g_volume_monitor_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * This function should be called by any #GVolumeMonitor
   * implementation when a new #GMount object is created that is not
   * associated with a #GVolume object. It must be called just before
   * emitting the mount_added signal.
   * If the return value is not %NULL, the caller must associate the
   * returned #GVolume object with the #GMount. This involves returning
   * it in its [gio.mount.Mount.getVolume] implementation. The caller must
   * also listen for the "removed" signal on the returned object
   * and give up its reference when handling that signal
   * Similarly, if implementing [gio.volume_monitor.VolumeMonitor.adoptOrphanMount],
   * the implementor must take a reference to mount and return it in
   * its [gio.volume.Volume.getMount] implemented. Also, the implementor must
   * listen for the "unmounted" signal on mount and give up its
   * reference upon handling that signal.
   * There are two main use cases for this function.
   * One is when implementing a user space file system driver that reads
   * blocks of a block device that is already represented by the native
   * volume monitor $(LPAREN)for example a CD Audio file system driver$(RPAREN). Such
   * a driver will generate its own #GMount object that needs to be
   * associated with the #GVolume object that represents the volume.
   * The other is for implementing a #GVolumeMonitor whose sole purpose
   * is to return #GVolume objects representing entries in the users
   * "favorite servers" list or similar.
   * Params:
   *   mount = a #GMount object to find a parent for
   * Returns: the #GVolume object that is the parent for mount or %NULL
   *   if no wants to adopt the #GMount.

   * Deprecated: Instead of using this function, #GVolumeMonitor
   *   implementations should instead create shadow mounts with the URI of
   *   the mount they intend to adopt. See the proxy volume monitor in
   *   gvfs for an example of this. Also see [gio.mount.Mount.isShadowed],
   *   [gio.mount.Mount.shadow] and [gio.mount.Mount.unshadow] functions.
   */
  static Volume adoptOrphanMount(Mount mount)
  {
    GVolume* _cretval;
    _cretval = g_volume_monitor_adopt_orphan_mount(mount ? cast(GMount*)(cast(ObjectG)mount).cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!Volume(cast(GVolume*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the volume monitor used by gio.
   * Returns: a reference to the #GVolumeMonitor used by gio. Call
   *   [gobject.object.ObjectG.unref] when done with it.
   */
  static VolumeMonitor get()
  {
    GVolumeMonitor* _cretval;
    _cretval = g_volume_monitor_get();
    auto _retval = ObjectG.getDObject!VolumeMonitor(cast(GVolumeMonitor*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets a list of drives connected to the system.
   * The returned list should be freed with [glib.list.List.free], after
   * its elements have been unreffed with [gobject.object.ObjectG.unref].
   * Returns: a #GList of connected #GDrive objects.
   */
  Drive[] getConnectedDrives()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_connected_drives(cast(GVolumeMonitor*)cPtr);
    auto _retval = gListToD!(Drive, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Finds a #GMount object by its UUID $(LPAREN)see [gio.mount.Mount.getUuid]$(RPAREN)
   * Params:
   *   uuid = the UUID to look for
   * Returns: a #GMount or %NULL if no such mount is available.
   *   Free the returned object with [gobject.object.ObjectG.unref].
   */
  Mount getMountForUuid(string uuid)
  {
    GMount* _cretval;
    const(char)* _uuid = uuid.toCString(No.Alloc);
    _cretval = g_volume_monitor_get_mount_for_uuid(cast(GVolumeMonitor*)cPtr, _uuid);
    auto _retval = ObjectG.getDObject!Mount(cast(GMount*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets a list of the mounts on the system.
   * The returned list should be freed with [glib.list.List.free], after
   * its elements have been unreffed with [gobject.object.ObjectG.unref].
   * Returns: a #GList of #GMount objects.
   */
  Mount[] getMounts()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_mounts(cast(GVolumeMonitor*)cPtr);
    auto _retval = gListToD!(Mount, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Finds a #GVolume object by its UUID $(LPAREN)see [gio.volume.Volume.getUuid]$(RPAREN)
   * Params:
   *   uuid = the UUID to look for
   * Returns: a #GVolume or %NULL if no such volume is available.
   *   Free the returned object with [gobject.object.ObjectG.unref].
   */
  Volume getVolumeForUuid(string uuid)
  {
    GVolume* _cretval;
    const(char)* _uuid = uuid.toCString(No.Alloc);
    _cretval = g_volume_monitor_get_volume_for_uuid(cast(GVolumeMonitor*)cPtr, _uuid);
    auto _retval = ObjectG.getDObject!Volume(cast(GVolume*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets a list of the volumes on the system.
   * The returned list should be freed with [glib.list.List.free], after
   * its elements have been unreffed with [gobject.object.ObjectG.unref].
   * Returns: a #GList of #GVolume objects.
   */
  Volume[] getVolumes()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_volumes(cast(GVolumeMonitor*)cPtr);
    auto _retval = gListToD!(Volume, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Emitted when a drive changes.
   * Params
   *   drive = the drive that changed
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveChangedCallbackDlg = void delegate(Drive drive, VolumeMonitor volumeMonitor);
  alias DriveChangedCallbackFunc = void function(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveChanged signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : DriveChangedCallbackDlg) || is(T : DriveChangedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("drive-changed", closure, after);
  }

  /**
   * Emitted when a drive is connected to the system.
   * Params
   *   drive = a #GDrive that was connected.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveConnectedCallbackDlg = void delegate(Drive drive, VolumeMonitor volumeMonitor);
  alias DriveConnectedCallbackFunc = void function(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveConnected signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveConnected(T)(T callback, Flag!"After" after = No.After)
  if (is(T : DriveConnectedCallbackDlg) || is(T : DriveConnectedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("drive-connected", closure, after);
  }

  /**
   * Emitted when a drive is disconnected from the system.
   * Params
   *   drive = a #GDrive that was disconnected.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveDisconnectedCallbackDlg = void delegate(Drive drive, VolumeMonitor volumeMonitor);
  alias DriveDisconnectedCallbackFunc = void function(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveDisconnected signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveDisconnected(T)(T callback, Flag!"After" after = No.After)
  if (is(T : DriveDisconnectedCallbackDlg) || is(T : DriveDisconnectedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("drive-disconnected", closure, after);
  }

  /**
   * Emitted when the eject button is pressed on drive.
   * Params
   *   drive = the drive where the eject button was pressed
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveEjectButtonCallbackDlg = void delegate(Drive drive, VolumeMonitor volumeMonitor);
  alias DriveEjectButtonCallbackFunc = void function(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveEjectButton signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveEjectButton(T)(T callback, Flag!"After" after = No.After)
  if (is(T : DriveEjectButtonCallbackDlg) || is(T : DriveEjectButtonCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("drive-eject-button", closure, after);
  }

  /**
   * Emitted when the stop button is pressed on drive.
   * Params
   *   drive = the drive where the stop button was pressed
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveStopButtonCallbackDlg = void delegate(Drive drive, VolumeMonitor volumeMonitor);
  alias DriveStopButtonCallbackFunc = void function(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveStopButton signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveStopButton(T)(T callback, Flag!"After" after = No.After)
  if (is(T : DriveStopButtonCallbackDlg) || is(T : DriveStopButtonCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("drive-stop-button", closure, after);
  }

  /**
   * Emitted when a mount is added.
   * Params
   *   mount = a #GMount that was added.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias MountAddedCallbackDlg = void delegate(Mount mount, VolumeMonitor volumeMonitor);
  alias MountAddedCallbackFunc = void function(Mount mount, VolumeMonitor volumeMonitor);

  /**
   * Connect to MountAdded signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountAdded(T)(T callback, Flag!"After" after = No.After)
  if (is(T : MountAddedCallbackDlg) || is(T : MountAddedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto mount = getVal!Mount(&_paramVals[1]);
      _dClosure.dlg(mount, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("mount-added", closure, after);
  }

  /**
   * Emitted when a mount changes.
   * Params
   *   mount = a #GMount that changed.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias MountChangedCallbackDlg = void delegate(Mount mount, VolumeMonitor volumeMonitor);
  alias MountChangedCallbackFunc = void function(Mount mount, VolumeMonitor volumeMonitor);

  /**
   * Connect to MountChanged signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : MountChangedCallbackDlg) || is(T : MountChangedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto mount = getVal!Mount(&_paramVals[1]);
      _dClosure.dlg(mount, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("mount-changed", closure, after);
  }

  /**
   * May be emitted when a mount is about to be removed.
   * This signal depends on the backend and is only emitted if
   * GIO was used to unmount.
   * Params
   *   mount = a #GMount that is being unmounted.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias MountPreUnmountCallbackDlg = void delegate(Mount mount, VolumeMonitor volumeMonitor);
  alias MountPreUnmountCallbackFunc = void function(Mount mount, VolumeMonitor volumeMonitor);

  /**
   * Connect to MountPreUnmount signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountPreUnmount(T)(T callback, Flag!"After" after = No.After)
  if (is(T : MountPreUnmountCallbackDlg) || is(T : MountPreUnmountCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto mount = getVal!Mount(&_paramVals[1]);
      _dClosure.dlg(mount, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("mount-pre-unmount", closure, after);
  }

  /**
   * Emitted when a mount is removed.
   * Params
   *   mount = a #GMount that was removed.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias MountRemovedCallbackDlg = void delegate(Mount mount, VolumeMonitor volumeMonitor);
  alias MountRemovedCallbackFunc = void function(Mount mount, VolumeMonitor volumeMonitor);

  /**
   * Connect to MountRemoved signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountRemoved(T)(T callback, Flag!"After" after = No.After)
  if (is(T : MountRemovedCallbackDlg) || is(T : MountRemovedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto mount = getVal!Mount(&_paramVals[1]);
      _dClosure.dlg(mount, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("mount-removed", closure, after);
  }

  /**
   * Emitted when a mountable volume is added to the system.
   * Params
   *   volume = a #GVolume that was added.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias VolumeAddedCallbackDlg = void delegate(Volume volume, VolumeMonitor volumeMonitor);
  alias VolumeAddedCallbackFunc = void function(Volume volume, VolumeMonitor volumeMonitor);

  /**
   * Connect to VolumeAdded signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectVolumeAdded(T)(T callback, Flag!"After" after = No.After)
  if (is(T : VolumeAddedCallbackDlg) || is(T : VolumeAddedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto volume = getVal!Volume(&_paramVals[1]);
      _dClosure.dlg(volume, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("volume-added", closure, after);
  }

  /**
   * Emitted when mountable volume is changed.
   * Params
   *   volume = a #GVolume that changed.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias VolumeChangedCallbackDlg = void delegate(Volume volume, VolumeMonitor volumeMonitor);
  alias VolumeChangedCallbackFunc = void function(Volume volume, VolumeMonitor volumeMonitor);

  /**
   * Connect to VolumeChanged signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectVolumeChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : VolumeChangedCallbackDlg) || is(T : VolumeChangedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto volume = getVal!Volume(&_paramVals[1]);
      _dClosure.dlg(volume, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("volume-changed", closure, after);
  }

  /**
   * Emitted when a mountable volume is removed from the system.
   * Params
   *   volume = a #GVolume that was removed.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias VolumeRemovedCallbackDlg = void delegate(Volume volume, VolumeMonitor volumeMonitor);
  alias VolumeRemovedCallbackFunc = void function(Volume volume, VolumeMonitor volumeMonitor);

  /**
   * Connect to VolumeRemoved signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectVolumeRemoved(T)(T callback, Flag!"After" after = No.After)
  if (is(T : VolumeRemovedCallbackDlg) || is(T : VolumeRemovedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto volume = getVal!Volume(&_paramVals[1]);
      _dClosure.dlg(volume, volumeMonitor);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("volume-removed", closure, after);
  }
}
