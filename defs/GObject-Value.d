import std.traits : isPointer;

import gobject.object;
import gobject.types;

class Value : Boxed
{

  /**
   * Template to create a new Value from a D type.
   * Params:
   *   T = The D type to initialize the value to
   *   val = The value to assign
   */
  this(T)(T val)
    if (!is(T == void*))
  {
    this();
    init_!T();
    set!T(val);
  }

  /**
   * Template to initialize a Value to a D type.
   * Params:
   *   T = The D type to initialize the Value to
   */
  void init_(T)()
  {
    initVal!T(cast(GValue*)cPtr);
  }

  /**
   * Template to get a Value of a specific type.
   * Params:
   *   T = The D type of the value to get (must match the type of the Value)
   * Returns: The value
   */
  T get(T)()
  {
    return getVal!T(cast(GValue*)cPtr);
  }

  /**
   * Template to set a Value of a specific type.
   * Params:
   *   T = The D type of the value to set (must match the type of the Value)
   *   val = The value to assign
   */
  void set(T)(T val)
  {
    setVal!T(cast(GValue*)cPtr, val);
  }
}

void initVal(T)(GValue* gval)
{
  static if (is(T == bool))
    g_value_init(gval, GTypeEnum.Boolean);
  else static if (is(T == byte))
    g_value_init(gval, GTypeEnum.Char);
  else static if (is(T == ubyte))
    g_value_init(gval, GTypeEnum.Uchar);
  else static if (is(T == int))
    g_value_init(gval, GTypeEnum.Int);
  else static if (is(T == uint))
    g_value_init(gval, GTypeEnum.Uint);
  else static if (is(T == long))
    g_value_init(gval, GTypeEnum.Int64);
  else static if (is(T == ulong))
    g_value_init(gval, GTypeEnum.Uint64);
  else static if (is(T == float))
    g_value_init(gval, GTypeEnum.Float);
  else static if (is(T == double))
    g_value_init(gval, GTypeEnum.Double);
  else static if (is(T == enum)) // FIXME enum or flags
    g_value_init(gval, GTypeEnum.Enum);
  else static if (is(T == string))
    g_value_init(gval, GTypeEnum.String);
  else static if (is(T == VariantG))
    g_value_init(gval, GTypeEnum.Variant);
  else static if (is(T : ParamSpec))
    g_value_init(gval, GTypeEnum.Param);
  else static if (is(T : Boxed))
  { // Cannot initialize a plain boxed type, it is done in setVal()
  }
  else static if (is(T : ObjectG) || is(T == interface))
    g_value_init(gval, GTypeEnum.Object);
  else static if (is(T : Object) || isPointer!T)
    g_value_init(gval, GTypeEnum.Pointer);
  else
    assert(0, "Unsupported type " ~ T.stringof ~ " in Value.initVal");
}

/// Template to get a value from a GValue of a given D type (must contain the correct type)
T getVal(T)(const(GValue)* gval)
{
  static if (is(T == bool))
    return g_value_get_boolean(gval);
  else static if (is(T == byte))
    return g_value_get_schar(gval);
  else static if (is(T == ubyte))
    return g_value_get_uchar(gval);
  else static if (is(T == int))
    return g_value_get_int(gval);
  else static if (is(T == uint))
    return g_value_get_uint(gval);
  else static if (is(T == long))
    return g_value_get_int64(gval);
  else static if (is(T == ulong))
    return g_value_get_uint64(gval);
  else static if (is(T == float))
    return g_value_get_float(gval);
  else static if (is(T == double))
    return g_value_get_double(gval);
  else static if (is(T == enum)) // enum or flags
    return g_type_is_a(gval.gType, GTypeEnum.Flags) ? cast(T)g_value_get_flags(gval) : cast(T)g_value_get_enum(gval);
  else static if (is(T == string))
    return g_value_get_string(gval).fromCString(No.Free);
  else static if (is(T == VariantG))
  {
    auto v = g_value_get_variant(gval);
    return v ? new VariantG(v, No.Take) : null;
  }
  else static if (is(T : ParamSpec))
  {
    auto v = g_value_get_param(gval);
    return v ? new T(v, No.Take) : null;
  }
  else static if (is(T : Boxed))
  {
    auto v = g_value_get_boxed(gval);
    return v ? new T(v, No.Take) : null;
  }
  else static if (is(T : ObjectG) || is(T == interface))
  {
    auto v = g_value_get_object(gval);
    return ObjectG.getDObject!T(v, No.Take);
  }
  else static if (is(T : Object) || isPointer!T)
    return cast(T)g_value_get_pointer(gval);
  else
    assert(0, "Unsupported type " ~ T.stringof ~ " in Value.getVal");
}

/// Template to set a GValue to a given D type (must have been initialized to the proper type)
void setVal(T)(GValue* gval, T v)
{
  static if (is(T == bool))
    g_value_set_boolean(gval, v);
  else static if (is(T == byte))
    g_value_set_schar(gval, v);
  else static if (is(T == ubyte))
    g_value_set_uchar(gval, v);
  else static if (is(T == int))
    g_value_set_int(gval, v);
  else static if (is(T == uint))
    g_value_set_uint(gval, v);
  else static if (is(T == long))
    g_value_set_int64(gval, v);
  else static if (is(T == ulong))
    g_value_set_uint64(gval, v);
  else static if (is(T == float))
    g_value_set_float(gval, v);
  else static if (is(T == double))
    g_value_set_double(gval, v);
  else static if (is(T == enum))
  {
    if (g_type_is_a(gval.gType, GTypeEnum.Flags))
      g_value_set_flags(gval, v);
    else
      g_value_set_enum(gval, v);
  }
  else static if (is(T == string))
    g_value_take_string(gval, v.toCString(Yes.Alloc));
  else static if (is(T == VariantG))
    g_value_set_variant(gval, cast(VariantC*)v.cPtr);
  else static if (is(T : ParamSpec))
    g_value_set_param(gval, cast(GParamSpec*)v.cPtr);
  else static if (is(T : Boxed))
  {
    g_value_init(gval, v.gType); // Have to initialize the specific boxed type here rather than in initVal
    g_value_set_boxed(gval, v.cInstancePtr);
  }
  else static if (is(T : ObjectG))
    g_value_set_object(gval, cast(ObjectC*)v.cPtr(No.Dup));
  else static if (is(T == interface))
  {
    if (auto objG = cast(ObjectG)v)
      g_value_set_object(gval, cast(ObjectC*)objG.cPtr(No.Dup));
    else
      assert(0, "Object type " ~ typeid(v).toString ~ " is not an ObjectG in Value.setVal");
  }
  else static if (is(T : Object) || isPointer!T)
    g_value_set_pointer(gval, cast(void*)v);
  else
    assert(0, "Unsupported type " ~ T.stringof ~ " in Value.setVal");
}
