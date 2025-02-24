module gtksource.style_scheme_preview;

import gid.gid;
import gobject.dclosure;
import gobject.object;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.actionable;
import gtk.actionable_mixin;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.widget;
import gtksource.c.functions;
import gtksource.c.types;
import gtksource.style_scheme;
import gtksource.types;

/**
 * A preview widget for class@StyleScheme.
 * This widget provides a convenient [Gtk.Widget] to preview a class@StyleScheme.
 * The property@StyleSchemePreview:selected property can be used to manage
 * the selection state of a single preview widget.
 */
class StyleSchemePreview : Widget, Actionable
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_source_style_scheme_preview_get_type != &gidSymbolNotFound ? gtk_source_style_scheme_preview_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionableT!();

  /**
   * Gets the #GtkSourceStyleScheme previewed by the widget.
   * Returns: a #GtkSourceStyleScheme
   */
  StyleScheme getScheme()
  {
    GtkSourceStyleScheme* _cretval;
    _cretval = gtk_source_style_scheme_preview_get_scheme(cast(GtkSourceStyleSchemePreview*)cPtr);
    auto _retval = ObjectG.getDObject!StyleScheme(cast(GtkSourceStyleScheme*)_cretval, No.Take);
    return _retval;
  }

  bool getSelected()
  {
    bool _retval;
    _retval = gtk_source_style_scheme_preview_get_selected(cast(GtkSourceStyleSchemePreview*)cPtr);
    return _retval;
  }

  void setSelected(bool selected)
  {
    gtk_source_style_scheme_preview_set_selected(cast(GtkSourceStyleSchemePreview*)cPtr, selected);
  }

  alias ActivateCallbackDlg = void delegate(StyleSchemePreview styleSchemePreview);
  alias ActivateCallbackFunc = void function(StyleSchemePreview styleSchemePreview);

  /**
   * Connect to Activate signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivate(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ActivateCallbackDlg) || is(T : ActivateCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto styleSchemePreview = getVal!StyleSchemePreview(_paramVals);
      _dClosure.dlg(styleSchemePreview);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }
}
