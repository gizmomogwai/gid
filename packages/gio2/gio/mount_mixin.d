module gio.mount_mixin;

public import gio.mount_iface_proxy;
public import gid.global;
public import gio.async_result;
public import gio.async_result_mixin;
public import gio.c.functions;
public import gio.c.types;
public import gio.cancellable;
public import gio.drive;
public import gio.drive_mixin;
public import gio.file;
public import gio.file_mixin;
public import gio.icon;
public import gio.icon_mixin;
public import gio.mount_operation;
public import gio.types;
public import gio.volume;
public import gio.volume_mixin;
public import glib.error;
public import gobject.dclosure;
public import gobject.object;

/**
 * The `GMount` interface represents user-visible mounts. Note, when
 * [porting from GnomeVFS](migrating-gnome-vfs.html), `GMount` is the moral
 * equivalent of `GnomeVFSVolume`.
 * `GMount` is a ‘mounted’ filesystem that you can access. Mounted is in
 * quotes because it’s not the same as a UNIX mount, it might be a GVFS
 * mount, but you can still access the files on it if you use GIO. Might or
 * might not be related to a volume object.
 * Unmounting a `GMount` instance is an asynchronous operation. For
 * more information about asynchronous operations, see [gio.async_result.AsyncResult]
 * and [gio.task.Task]. To unmount a `GMount` instance, first call
 * [gio.mount.Mount.unmountWithOperation] with (at least) the `GMount`
 * instance and a [gio.AsyncReadyCallback].  The callback will be fired
 * when the operation has resolved $(LPAREN)either with success or failure$(RPAREN), and a
 * [gio.async_result.AsyncResult] structure will be passed to the callback.  That
 * callback should then call [gio.mount.Mount.unmountWithOperationFinish]
 * with the `GMount` and the [gio.async_result.AsyncResult] data to see if the
 * operation was completed successfully.  If an `error` is present when
 * [gio.mount.Mount.unmountWithOperationFinish] is called, then it will be
 * filled with any error information.
 */
template MountT()
{

  /**
   * Checks if mount can be ejected.
   * Returns: %TRUE if the mount can be ejected.
   */
  override bool canEject()
  {
    bool _retval;
    _retval = g_mount_can_eject(cast(GMount*)cPtr);
    return _retval;
  }

  /**
   * Checks if mount can be unmounted.
   * Returns: %TRUE if the mount can be unmounted.
   */
  override bool canUnmount()
  {
    bool _retval;
    _retval = g_mount_can_unmount(cast(GMount*)cPtr);
    return _retval;
  }

  /**
   * Ejects a mount. This is an asynchronous operation, and is
   * finished by calling [gio.mount.Mount.ejectFinish] with the mount
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the unmount if required for eject
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.

   * Deprecated: Use [gio.mount.Mount.ejectWithOperation] instead.
   */
  override void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_mount_eject(cast(GMount*)cPtr, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Finishes ejecting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully ejected. %FALSE otherwise.

   * Deprecated: Use [gio.mount.Mount.ejectWithOperationFinish] instead.
   */
  override bool ejectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_eject_finish(cast(GMount*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Ejects a mount. This is an asynchronous operation, and is
   * finished by calling [gio.mount.Mount.ejectWithOperationFinish] with the mount
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the unmount if required for eject
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  override void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_mount_eject_with_operation(cast(GMount*)cPtr, flags, mountOperation ? cast(GMountOperation*)mountOperation.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Finishes ejecting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully ejected. %FALSE otherwise.
   */
  override bool ejectWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_eject_with_operation_finish(cast(GMount*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the default location of mount. The default location of the given
   * mount is a path that reflects the main entry point for the user $(LPAREN)e.g.
   * the home directory, or the root of the volume$(RPAREN).
   * Returns: a #GFile.
   *   The returned object should be unreffed with
   *   [gobject.object.ObjectG.unref] when no longer needed.
   */
  override File getDefaultLocation()
  {
    GFile* _cretval;
    _cretval = g_mount_get_default_location(cast(GMount*)cPtr);
    auto _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the drive for the mount.
   * This is a convenience method for getting the #GVolume and then
   * using that object to get the #GDrive.
   * Returns: a #GDrive or %NULL if mount is not
   *   associated with a volume or a drive.
   *   The returned object should be unreffed with
   *   [gobject.object.ObjectG.unref] when no longer needed.
   */
  override Drive getDrive()
  {
    GDrive* _cretval;
    _cretval = g_mount_get_drive(cast(GMount*)cPtr);
    auto _retval = ObjectG.getDObject!Drive(cast(GDrive*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the icon for mount.
   * Returns: a #GIcon.
   *   The returned object should be unreffed with
   *   [gobject.object.ObjectG.unref] when no longer needed.
   */
  override Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_mount_get_icon(cast(GMount*)cPtr);
    auto _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the name of mount.
   * Returns: the name for the given mount.
   *   The returned string should be freed with [glib.global.gfree]
   *   when no longer needed.
   */
  override string getName()
  {
    char* _cretval;
    _cretval = g_mount_get_name(cast(GMount*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Gets the root directory on mount.
   * Returns: a #GFile.
   *   The returned object should be unreffed with
   *   [gobject.object.ObjectG.unref] when no longer needed.
   */
  override File getRoot()
  {
    GFile* _cretval;
    _cretval = g_mount_get_root(cast(GMount*)cPtr);
    auto _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the sort key for mount, if any.
   * Returns: Sorting key for mount or %NULL if no such key is available.
   */
  override string getSortKey()
  {
    const(char)* _cretval;
    _cretval = g_mount_get_sort_key(cast(GMount*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets the symbolic icon for mount.
   * Returns: a #GIcon.
   *   The returned object should be unreffed with
   *   [gobject.object.ObjectG.unref] when no longer needed.
   */
  override Icon getSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_mount_get_symbolic_icon(cast(GMount*)cPtr);
    auto _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Gets the UUID for the mount. The reference is typically based on
   * the file system UUID for the mount in question and should be
   * considered an opaque string. Returns %NULL if there is no UUID
   * available.
   * Returns: the UUID for mount or %NULL if no UUID
   *   can be computed.
   *   The returned string should be freed with [glib.global.gfree]
   *   when no longer needed.
   */
  override string getUuid()
  {
    char* _cretval;
    _cretval = g_mount_get_uuid(cast(GMount*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Gets the volume for the mount.
   * Returns: a #GVolume or %NULL if mount is not
   *   associated with a volume.
   *   The returned object should be unreffed with
   *   [gobject.object.ObjectG.unref] when no longer needed.
   */
  override Volume getVolume()
  {
    GVolume* _cretval;
    _cretval = g_mount_get_volume(cast(GMount*)cPtr);
    auto _retval = ObjectG.getDObject!Volume(cast(GVolume*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Tries to guess the type of content stored on mount. Returns one or
   * more textual identifiers of well-known content types $(LPAREN)typically
   * prefixed with "x-content/"$(RPAREN), e.g. x-content/image-dcf for camera
   * memory cards. See the
   * [shared-mime-info](http://www.freedesktop.org/wiki/Specifications/shared-mime-info-spec)
   * specification for more on x-content types.
   * This is an asynchronous operation $(LPAREN)see
   * [gio.mount.Mount.guessContentTypeSync] for the synchronous version$(RPAREN), and
   * is finished by calling [gio.mount.Mount.guessContentTypeFinish] with the
   * mount and #GAsyncResult data returned in the callback.
   * Params:
   *   forceRescan = Whether to force a rescan of the content.
   *     Otherwise a cached result will be used if available
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback
   */
  override void guessContentType(bool forceRescan, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_mount_guess_content_type(cast(GMount*)cPtr, forceRescan, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Finishes guessing content types of mount. If any errors occurred
   * during the operation, error will be set to contain the errors and
   * %FALSE will be returned. In particular, you may get an
   * %G_IO_ERROR_NOT_SUPPORTED if the mount does not support content
   * guessing.
   * Params:
   *   result = a #GAsyncResult
   * Returns: a %NULL-terminated array of content types or %NULL on error.
   *   Caller should free this array with [glib.global.strfreev] when done with it.
   */
  override string[] guessContentTypeFinish(AsyncResult result)
  {
    char** _cretval;
    GError *_err;
    _cretval = g_mount_guess_content_type_finish(cast(GMount*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(Yes.Free);
    }
    return _retval;
  }

  /**
   * Tries to guess the type of content stored on mount. Returns one or
   * more textual identifiers of well-known content types $(LPAREN)typically
   * prefixed with "x-content/"$(RPAREN), e.g. x-content/image-dcf for camera
   * memory cards. See the
   * [shared-mime-info](http://www.freedesktop.org/wiki/Specifications/shared-mime-info-spec)
   * specification for more on x-content types.
   * This is a synchronous operation and as such may block doing IO;
   * see [gio.mount.Mount.guessContentType] for the asynchronous version.
   * Params:
   *   forceRescan = Whether to force a rescan of the content.
   *     Otherwise a cached result will be used if available
   *   cancellable = optional #GCancellable object, %NULL to ignore
   * Returns: a %NULL-terminated array of content types or %NULL on error.
   *   Caller should free this array with [glib.global.strfreev] when done with it.
   */
  override string[] guessContentTypeSync(bool forceRescan, Cancellable cancellable)
  {
    char** _cretval;
    GError *_err;
    _cretval = g_mount_guess_content_type_sync(cast(GMount*)cPtr, forceRescan, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(Yes.Free);
    }
    return _retval;
  }

  /**
   * Determines if mount is shadowed. Applications or libraries should
   * avoid displaying mount in the user interface if it is shadowed.
   * A mount is said to be shadowed if there exists one or more user
   * visible objects $(LPAREN)currently #GMount objects$(RPAREN) with a root that is
   * inside the root of mount.
   * One application of shadow mounts is when exposing a single file
   * system that is used to address several logical volumes. In this
   * situation, a #GVolumeMonitor implementation would create two
   * #GVolume objects $(LPAREN)for example, one for the camera functionality of
   * the device and one for a SD card reader on the device$(RPAREN) with
   * activation URIs `gphoto2://[usb:001,002]/store1/`
   * and `gphoto2://[usb:001,002]/store2/`. When the
   * underlying mount $(LPAREN)with root
   * `gphoto2://[usb:001,002]/`$(RPAREN) is mounted, said
   * #GVolumeMonitor implementation would create two #GMount objects
   * $(LPAREN)each with their root matching the corresponding volume activation
   * root$(RPAREN) that would shadow the original mount.
   * The proxy monitor in GVfs 2.26 and later, automatically creates and
   * manage shadow mounts $(LPAREN)and shadows the underlying mount$(RPAREN) if the
   * activation root on a #GVolume is set.
   * Returns: %TRUE if mount is shadowed.
   */
  override bool isShadowed()
  {
    bool _retval;
    _retval = g_mount_is_shadowed(cast(GMount*)cPtr);
    return _retval;
  }

  /**
   * Remounts a mount. This is an asynchronous operation, and is
   * finished by calling [gio.mount.Mount.remountFinish] with the mount
   * and #GAsyncResults data returned in the callback.
   * Remounting is useful when some setting affecting the operation
   * of the volume has been changed, as these may need a remount to
   * take affect. While this is semantically equivalent with unmounting
   * and then remounting not all backends might need to actually be
   * unmounted.
   * Params:
   *   flags = flags affecting the operation
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  override void remount(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_mount_remount(cast(GMount*)cPtr, flags, mountOperation ? cast(GMountOperation*)mountOperation.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Finishes remounting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully remounted. %FALSE otherwise.
   */
  override bool remountFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_remount_finish(cast(GMount*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Increments the shadow count on mount. Usually used by
   * #GVolumeMonitor implementations when creating a shadow mount for
   * mount, see [gio.mount.Mount.isShadowed] for more information. The caller
   * will need to emit the #GMount::changed signal on mount manually.
   */
  override void shadow()
  {
    g_mount_shadow(cast(GMount*)cPtr);
  }

  /**
   * Unmounts a mount. This is an asynchronous operation, and is
   * finished by calling [gio.mount.Mount.unmountFinish] with the mount
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the operation
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.

   * Deprecated: Use [gio.mount.Mount.unmountWithOperation] instead.
   */
  override void unmount(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_mount_unmount(cast(GMount*)cPtr, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Finishes unmounting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully unmounted. %FALSE otherwise.

   * Deprecated: Use [gio.mount.Mount.unmountWithOperationFinish] instead.
   */
  override bool unmountFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_unmount_finish(cast(GMount*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Unmounts a mount. This is an asynchronous operation, and is
   * finished by calling [gio.mount.Mount.unmountWithOperationFinish] with the mount
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the operation
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  override void unmountWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(ObjectG.getDObject!ObjectG(cast(void*)sourceObject, No.Take), ObjectG.getDObject!AsyncResult(cast(void*)res, No.Take));
    }
    auto _callbackCB = callback ? &_callbackCallback : null;

    auto _callback = callback ? freezeDelegate(cast(void*)&callback) : null;
    g_mount_unmount_with_operation(cast(GMount*)cPtr, flags, mountOperation ? cast(GMountOperation*)mountOperation.cPtr(No.Dup) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(No.Dup) : null, _callbackCB, _callback);
  }

  /**
   * Finishes unmounting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully unmounted. %FALSE otherwise.
   */
  override bool unmountWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_unmount_with_operation_finish(cast(GMount*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Decrements the shadow count on mount. Usually used by
   * #GVolumeMonitor implementations when destroying a shadow mount for
   * mount, see [gio.mount.Mount.isShadowed] for more information. The caller
   * will need to emit the #GMount::changed signal on mount manually.
   */
  override void unshadow()
  {
    g_mount_unshadow(cast(GMount*)cPtr);
  }

  /**
   * Emitted when the mount has been changed.
   *   mount = the instance the signal is connected to
   */
  alias ChangedCallbackDlg = void delegate(Mount mount);
  alias ChangedCallbackFunc = void function(Mount mount);

  /**
   * Connect to Changed signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ChangedCallbackDlg) || is(T : ChangedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto mount = getVal!Mount(_paramVals);
      _dClosure.dlg(mount);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }

  /**
   * This signal may be emitted when the #GMount is about to be
   * unmounted.
   * This signal depends on the backend and is only emitted if
   * GIO was used to unmount.
   *   mount = the instance the signal is connected to
   */
  alias PreUnmountCallbackDlg = void delegate(Mount mount);
  alias PreUnmountCallbackFunc = void function(Mount mount);

  /**
   * Connect to PreUnmount signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPreUnmount(T)(T callback, Flag!"After" after = No.After)
  if (is(T : PreUnmountCallbackDlg) || is(T : PreUnmountCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto mount = getVal!Mount(_paramVals);
      _dClosure.dlg(mount);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("pre-unmount", closure, after);
  }

  /**
   * This signal is emitted when the #GMount have been
   * unmounted. If the recipient is holding references to the
   * object they should release them so the object can be
   * finalized.
   *   mount = the instance the signal is connected to
   */
  alias UnmountedCallbackDlg = void delegate(Mount mount);
  alias UnmountedCallbackFunc = void function(Mount mount);

  /**
   * Connect to Unmounted signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUnmounted(T)(T callback, Flag!"After" after = No.After)
  if (is(T : UnmountedCallbackDlg) || is(T : UnmountedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto mount = getVal!Mount(_paramVals);
      _dClosure.dlg(mount);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("unmounted", closure, after);
  }
}
