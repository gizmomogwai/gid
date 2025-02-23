module atk.component_mixin;

public import atk.component_iface_proxy;
public import atk.c.functions;
public import atk.c.types;
public import atk.object;
public import atk.rectangle;
public import atk.types;
public import gid.gid;
public import gobject.dclosure;
public import gobject.object;

/**
 * The ATK interface provided by UI components
 * which occupy a physical area on the screen.
 * which the user can activate/interact with.
 * #AtkComponent should be implemented by most if not all UI elements
 * with an actual on-screen presence, i.e. components which can be
 * said to have a screen-coordinate bounding box.  Virtually all
 * widgets will need to have #AtkComponent implementations provided
 * for their corresponding #AtkObject class.  In short, only UI
 * elements which are *not* GUI elements will omit this ATK interface.
 * A possible exception might be textual information with a
 * transparent background, in which case text glyph bounding box
 * information is provided by #AtkText.
 */
template ComponentT()
{

  /**
   * Checks whether the specified point is within the extent of the component.
   * Toolkit implementor note: ATK provides a default implementation for
   * this virtual method. In general there are little reason to
   * re-implement it.
   * Params:
   *   x = x coordinate
   *   y = y coordinate
   *   coordType = specifies whether the coordinates are relative to the screen
   *     or to the components top level window
   * Returns: %TRUE or %FALSE indicating whether the specified point is within
   *   the extent of the component or not
   */
  override bool contains(int x, int y, CoordType coordType)
  {
    bool _retval;
    _retval = atk_component_contains(cast(AtkComponent*)cPtr, x, y, coordType);
    return _retval;
  }

  /**
   * Returns the alpha value $(LPAREN)i.e. the opacity$(RPAREN) for this
   * component, on a scale from 0 $(LPAREN)fully transparent$(RPAREN) to 1.0
   * $(LPAREN)fully opaque$(RPAREN).
   * Returns: An alpha value from 0 to 1.0, inclusive.
   */
  override double getAlpha()
  {
    double _retval;
    _retval = atk_component_get_alpha(cast(AtkComponent*)cPtr);
    return _retval;
  }

  /**
   * Gets the rectangle which gives the extent of the component.
   * If the extent can not be obtained $(LPAREN)e.g. a non-embedded plug or missing
   * support$(RPAREN), all of x, y, width, height are set to -1.
   * Params:
   *   x = address of #gint to put x coordinate
   *   y = address of #gint to put y coordinate
   *   width = address of #gint to put width
   *   height = address of #gint to put height
   *   coordType = specifies whether the coordinates are relative to the screen
   *     or to the components top level window
   */
  override void getExtents(out int x, out int y, out int width, out int height, CoordType coordType)
  {
    atk_component_get_extents(cast(AtkComponent*)cPtr, cast(int*)&x, cast(int*)&y, cast(int*)&width, cast(int*)&height, coordType);
  }

  /**
   * Gets the layer of the component.
   * Returns: an #AtkLayer which is the layer of the component
   */
  override Layer getLayer()
  {
    AtkLayer _cretval;
    _cretval = atk_component_get_layer(cast(AtkComponent*)cPtr);
    Layer _retval = cast(Layer)_cretval;
    return _retval;
  }

  /**
   * Gets the zorder of the component. The value G_MININT will be returned
   * if the layer of the component is not ATK_LAYER_MDI or ATK_LAYER_WINDOW.
   * Returns: a gint which is the zorder of the component, i.e. the depth at
   *   which the component is shown in relation to other components in the same
   *   container.
   */
  override int getMdiZorder()
  {
    int _retval;
    _retval = atk_component_get_mdi_zorder(cast(AtkComponent*)cPtr);
    return _retval;
  }

  /**
   * Gets the position of component in the form of
   * a point specifying component's top-left corner.
   * If the position can not be obtained $(LPAREN)e.g. a non-embedded plug or missing
   * support$(RPAREN), x and y are set to -1.
   * Params:
   *   x = address of #gint to put x coordinate position
   *   y = address of #gint to put y coordinate position
   *   coordType = specifies whether the coordinates are relative to the screen
   *     or to the components top level window

   * Deprecated: Since 2.12. Use [Atk.Component.getExtents] instead.
   */
  override void getPosition(out int x, out int y, CoordType coordType)
  {
    atk_component_get_position(cast(AtkComponent*)cPtr, cast(int*)&x, cast(int*)&y, coordType);
  }

  /**
   * Gets the size of the component in terms of width and height.
   * If the size can not be obtained $(LPAREN)e.g. a non-embedded plug or missing
   * support$(RPAREN), width and height are set to -1.
   * Params:
   *   width = address of #gint to put width of component
   *   height = address of #gint to put height of component

   * Deprecated: Since 2.12. Use [Atk.Component.getExtents] instead.
   */
  override void getSize(out int width, out int height)
  {
    atk_component_get_size(cast(AtkComponent*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Grabs focus for this component.
   * Returns: %TRUE if successful, %FALSE otherwise.
   */
  override bool grabFocus()
  {
    bool _retval;
    _retval = atk_component_grab_focus(cast(AtkComponent*)cPtr);
    return _retval;
  }

  /**
   * Gets a reference to the accessible child, if one exists, at the
   * coordinate point specified by x and y.
   * Params:
   *   x = x coordinate
   *   y = y coordinate
   *   coordType = specifies whether the coordinates are relative to the screen
   *     or to the components top level window
   * Returns: a reference to the accessible
   *   child, if one exists
   */
  override ObjectAtk refAccessibleAtPoint(int x, int y, CoordType coordType)
  {
    AtkObject* _cretval;
    _cretval = atk_component_ref_accessible_at_point(cast(AtkComponent*)cPtr, x, y, coordType);
    auto _retval = ObjectG.getDObject!ObjectAtk(cast(AtkObject*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Remove the handler specified by handler_id from the list of
   * functions to be executed when this object receives focus events
   * $(LPAREN)in or out$(RPAREN).
   * Params:
   *   handlerId = the handler id of the focus handler to be removed
   *     from component

   * Deprecated: If you need to track when an object gains or
   *   lose the focus, use the #AtkObject::state-change "focused" notification instead.
   */
  override void removeFocusHandler(uint handlerId)
  {
    atk_component_remove_focus_handler(cast(AtkComponent*)cPtr, handlerId);
  }

  /**
   * Makes component visible on the screen by scrolling all necessary parents.
   * Contrary to atk_component_set_position, this does not actually move
   * component in its parent, this only makes the parents scroll so that the
   * object shows up on the screen, given its current position within the parents.
   * Params:
   *   type = specify where the object should be made visible.
   * Returns: whether scrolling was successful.
   */
  override bool scrollTo(ScrollType type)
  {
    bool _retval;
    _retval = atk_component_scroll_to(cast(AtkComponent*)cPtr, type);
    return _retval;
  }

  /**
   * Move the top-left of component to a given position of the screen by
   * scrolling all necessary parents.
   * Params:
   *   coords = specify whether coordinates are relative to the screen or to the
   *     parent object.
   *   x = x-position where to scroll to
   *   y = y-position where to scroll to
   * Returns: whether scrolling was successful.
   */
  override bool scrollToPoint(CoordType coords, int x, int y)
  {
    bool _retval;
    _retval = atk_component_scroll_to_point(cast(AtkComponent*)cPtr, coords, x, y);
    return _retval;
  }

  /**
   * Sets the extents of component.
   * Params:
   *   x = x coordinate
   *   y = y coordinate
   *   width = width to set for component
   *   height = height to set for component
   *   coordType = specifies whether the coordinates are relative to the screen
   *     or to the components top level window
   * Returns: %TRUE or %FALSE whether the extents were set or not
   */
  override bool setExtents(int x, int y, int width, int height, CoordType coordType)
  {
    bool _retval;
    _retval = atk_component_set_extents(cast(AtkComponent*)cPtr, x, y, width, height, coordType);
    return _retval;
  }

  /**
   * Sets the position of component.
   * Contrary to atk_component_scroll_to, this does not trigger any scrolling,
   * this just moves component in its parent.
   * Params:
   *   x = x coordinate
   *   y = y coordinate
   *   coordType = specifies whether the coordinates are relative to the screen
   *     or to the component's top level window
   * Returns: %TRUE or %FALSE whether or not the position was set or not
   */
  override bool setPosition(int x, int y, CoordType coordType)
  {
    bool _retval;
    _retval = atk_component_set_position(cast(AtkComponent*)cPtr, x, y, coordType);
    return _retval;
  }

  /**
   * Set the size of the component in terms of width and height.
   * Params:
   *   width = width to set for component
   *   height = height to set for component
   * Returns: %TRUE or %FALSE whether the size was set or not
   */
  override bool setSize(int width, int height)
  {
    bool _retval;
    _retval = atk_component_set_size(cast(AtkComponent*)cPtr, width, height);
    return _retval;
  }

  /**
   * The 'bounds-changed" signal is emitted when the position or
   * size of the component changes.
   * Params
   *   arg1 = The AtkRectangle giving the new position and size.
   *   component = the instance the signal is connected to
   */
  alias BoundsChangedCallbackDlg = void delegate(Rectangle arg1, Component component);
  alias BoundsChangedCallbackFunc = void function(Rectangle arg1, Component component);

  /**
   * Connect to BoundsChanged signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectBoundsChanged(T)(T callback, Flag!"After" after = No.After)
  if (is(T : BoundsChangedCallbackDlg) || is(T : BoundsChangedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto component = getVal!Component(_paramVals);
      auto arg1 = getVal!Rectangle(&_paramVals[1]);
      _dClosure.dlg(arg1, component);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("bounds-changed", closure, after);
  }
}
