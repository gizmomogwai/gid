module gio.action_mixin;

public import gio.action_iface_proxy;
public import gid.global;
public import gio.c.functions;
public import gio.c.types;
public import gio.types;
public import glib.error;
public import glib.variant;
public import glib.variant_type;

/**
 * `GAction` represents a single named action.
 * The main interface to an action is that it can be activated with
 * [gio.action.Action.activate]. This results in the 'activate' signal being
 * emitted. An activation has a `GVariant` parameter $(LPAREN)which may be
 * `NULL`$(RPAREN). The correct type for the parameter is determined by a static
 * parameter type $(LPAREN)which is given at construction time$(RPAREN).
 * An action may optionally have a state, in which case the state may be
 * set with [gio.action.Action.changeState]. This call takes a #GVariant. The
 * correct type for the state is determined by a static state type
 * $(LPAREN)which is given at construction time$(RPAREN).
 * The state may have a hint associated with it, specifying its valid
 * range.
 * `GAction` is merely the interface to the concept of an action, as
 * described above.  Various implementations of actions exist, including
 * [gio.simple_action.SimpleAction].
 * In all cases, the implementing class is responsible for storing the
 * name of the action, the parameter type, the enabled state, the optional
 * state type and the state and emitting the appropriate signals when these
 * change. The implementor is responsible for filtering calls to
 * [gio.action.Action.activate] and [gio.action.Action.changeState]
 * for type safety and for the state being enabled.
 * Probably the only useful thing to do with a `GAction` is to put it
 * inside of a [gio.simple_action_group.SimpleActionGroup].
 */
template ActionT()
{




  /**
   * Activates the action.
   * parameter must be the correct type of parameter for the action $(LPAREN)ie:
   * the parameter type given at construction time$(RPAREN).  If the parameter
   * type was %NULL then parameter must also be %NULL.
   * If the parameter GVariant is floating, it is consumed.
   * Params:
   *   parameter = the parameter to the activation
   */
  override void activate(VariantG parameter)
  {
    g_action_activate(cast(GAction*)cPtr, parameter ? cast(VariantC*)parameter.cPtr(No.Dup) : null);
  }

  /**
   * Request for the state of action to be changed to value.
   * The action must be stateful and value must be of the correct type.
   * See [gio.action.Action.getStateType].
   * This call merely requests a change.  The action may refuse to change
   * its state or may change its state to something other than value.
   * See [gio.action.Action.getStateHint].
   * If the value GVariant is floating, it is consumed.
   * Params:
   *   value = the new state
   */
  override void changeState(VariantG value)
  {
    g_action_change_state(cast(GAction*)cPtr, value ? cast(VariantC*)value.cPtr(No.Dup) : null);
  }

  /**
   * Checks if action is currently enabled.
   * An action must be enabled in order to be activated or in order to
   * have its state changed from outside callers.
   * Returns: whether the action is enabled
   */
  override bool getEnabled()
  {
    bool _retval;
    _retval = g_action_get_enabled(cast(GAction*)cPtr);
    return _retval;
  }

  /**
   * Queries the name of action.
   * Returns: the name of the action
   */
  override string getName()
  {
    const(char)* _cretval;
    _cretval = g_action_get_name(cast(GAction*)cPtr);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Queries the type of the parameter that must be given when activating
   * action.
   * When activating the action using [gio.action.Action.activate], the #GVariant
   * given to that function must be of the type returned by this function.
   * In the case that this function returns %NULL, you must not give any
   * #GVariant, but %NULL instead.
   * Returns: the parameter type
   */
  override VariantType getParameterType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_action_get_parameter_type(cast(GAction*)cPtr);
    auto _retval = _cretval ? new VariantType(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }

  /**
   * Queries the current state of action.
   * If the action is not stateful then %NULL will be returned.  If the
   * action is stateful then the type of the return value is the type
   * given by [gio.action.Action.getStateType].
   * The return value $(LPAREN)if non-%NULL$(RPAREN) should be freed with
   * [glib.variant.VariantG.unref] when it is no longer required.
   * Returns: the current state of the action
   */
  override VariantG getState()
  {
    VariantC* _cretval;
    _cretval = g_action_get_state(cast(GAction*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Requests a hint about the valid range of values for the state of
   * action.
   * If %NULL is returned it either means that the action is not stateful
   * or that there is no hint about the valid range of values for the
   * state of the action.
   * If a #GVariant array is returned then each item in the array is a
   * possible value for the state.  If a #GVariant pair $(LPAREN)ie: two-tuple$(RPAREN) is
   * returned then the tuple specifies the inclusive lower and upper bound
   * of valid values for the state.
   * In any case, the information is merely a hint.  It may be possible to
   * have a state value outside of the hinted range and setting a value
   * within the range may fail.
   * The return value $(LPAREN)if non-%NULL$(RPAREN) should be freed with
   * [glib.variant.VariantG.unref] when it is no longer required.
   * Returns: the state range hint
   */
  override VariantG getStateHint()
  {
    VariantC* _cretval;
    _cretval = g_action_get_state_hint(cast(GAction*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Queries the type of the state of action.
   * If the action is stateful $(LPAREN)e.g. created with
   * [gio.simple_action.SimpleAction.newStateful]$(RPAREN) then this function returns the
   * #GVariantType of the state.  This is the type of the initial value
   * given as the state. All calls to [gio.action.Action.changeState] must give a
   * #GVariant of this type and [gio.action.Action.getState] will return a
   * #GVariant of the same type.
   * If the action is not stateful $(LPAREN)e.g. created with [gio.simple_action.SimpleAction.new_]$(RPAREN)
   * then this function will return %NULL. In that case, [gio.action.Action.getState]
   * will return %NULL and you must not call [gio.action.Action.changeState].
   * Returns: the state type, if the action is stateful
   */
  override VariantType getStateType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_action_get_state_type(cast(GAction*)cPtr);
    auto _retval = _cretval ? new VariantType(cast(void*)_cretval, No.Take) : null;
    return _retval;
  }
}
