module gtk.statusbar;

import gid.gid;
import gobject.dclosure;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.types;
import gtk.widget;

/**
 * A `GtkStatusbar` widget is usually placed along the bottom of an application's
 * main [Gtk.Window].
 * ![An example GtkStatusbar](statusbar.png)
 * A `GtkStatusBar` may provide a regular commentary of the application's
 * status $(LPAREN)as is usually the case in a web browser, for example$(RPAREN), or may be
 * used to simply output a message when the status changes, $(LPAREN)when an upload
 * is complete in an FTP client, for example$(RPAREN).
 * Status bars in GTK maintain a stack of messages. The message at
 * the top of the each bar’s stack is the one that will currently be displayed.
 * Any messages added to a statusbar’s stack must specify a context id that
 * is used to uniquely identify the source of a message. This context id can
 * be generated by [Gtk.Statusbar.getContextId], given a message and
 * the statusbar that it will be added to. Note that messages are stored in a
 * stack, and when choosing which message to display, the stack structure is
 * adhered to, regardless of the context identifier of a message.
 * One could say that a statusbar maintains one stack of messages for
 * display purposes, but allows multiple message producers to maintain
 * sub-stacks of the messages they produced $(LPAREN)via context ids$(RPAREN).
 * Status bars are created using [Gtk.Statusbar.new_].
 * Messages are added to the bar’s stack with [Gtk.Statusbar.push].
 * The message at the top of the stack can be removed using
 * [Gtk.Statusbar.pop]. A message can be removed from anywhere in the
 * stack if its message id was recorded at the time it was added. This is done
 * using [Gtk.Statusbar.remove].
 * ## CSS node
 * `GtkStatusbar` has a single CSS node with name `statusbar`.

 * Deprecated: This widget will be removed in GTK 5
 */
class Statusbar : Widget
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_statusbar_get_type != &gidSymbolNotFound ? gtk_statusbar_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkStatusbar` ready for messages.
   * Returns: the new `GtkStatusbar`

   * Deprecated: This widget will be removed in GTK 5
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_statusbar_new();
    this(_cretval, No.Take);
  }

  /**
   * Returns a new context identifier, given a description
   * of the actual context.
   * Note that the description is not shown in the UI.
   * Params:
   *   contextDescription = textual description of what context
   *     the new message is being used in
   * Returns: an integer id

   * Deprecated: This widget will be removed in GTK 5
   */
  uint getContextId(string contextDescription)
  {
    uint _retval;
    const(char)* _contextDescription = contextDescription.toCString(No.Alloc);
    _retval = gtk_statusbar_get_context_id(cast(GtkStatusbar*)cPtr, _contextDescription);
    return _retval;
  }

  /**
   * Removes the first message in the `GtkStatusbar`’s stack
   * with the given context id.
   * Note that this may not change the displayed message,
   * if the message at the top of the stack has a different
   * context id.
   * Params:
   *   contextId = a context identifier

   * Deprecated: This widget will be removed in GTK 5
   */
  void pop(uint contextId)
  {
    gtk_statusbar_pop(cast(GtkStatusbar*)cPtr, contextId);
  }

  /**
   * Pushes a new message onto a statusbar’s stack.
   * Params:
   *   contextId = the message’s context id, as returned by
   *     [Gtk.Statusbar.getContextId]
   *   text = the message to add to the statusbar
   * Returns: a message id that can be used with
   *   [Gtk.Statusbar.remove].

   * Deprecated: This widget will be removed in GTK 5
   */
  uint push(uint contextId, string text)
  {
    uint _retval;
    const(char)* _text = text.toCString(No.Alloc);
    _retval = gtk_statusbar_push(cast(GtkStatusbar*)cPtr, contextId, _text);
    return _retval;
  }

  /**
   * Forces the removal of a message from a statusbar’s stack.
   * The exact context_id and message_id must be specified.
   * Params:
   *   contextId = a context identifier
   *   messageId = a message identifier, as returned by [Gtk.Statusbar.push]

   * Deprecated: This widget will be removed in GTK 5
   */
  void remove(uint contextId, uint messageId)
  {
    gtk_statusbar_remove(cast(GtkStatusbar*)cPtr, contextId, messageId);
  }

  /**
   * Forces the removal of all messages from a statusbar's
   * stack with the exact context_id.
   * Params:
   *   contextId = a context identifier

   * Deprecated: This widget will be removed in GTK 5
   */
  void removeAll(uint contextId)
  {
    gtk_statusbar_remove_all(cast(GtkStatusbar*)cPtr, contextId);
  }

  /**
   * Emitted whenever a new message is popped off a statusbar's stack.
   * Params
   *   contextId = the context id of the relevant message/statusbar
   *   text = the message that was just popped
   *   statusbar = the instance the signal is connected to

   * Deprecated: This widget will be removed in GTK 5
   */
  alias TextPoppedCallbackDlg = void delegate(uint contextId, string text, Statusbar statusbar);
  alias TextPoppedCallbackFunc = void function(uint contextId, string text, Statusbar statusbar);

  /**
   * Connect to TextPopped signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectTextPopped(T)(T callback, Flag!"After" after = No.After)
  if (is(T : TextPoppedCallbackDlg) || is(T : TextPoppedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto statusbar = getVal!Statusbar(_paramVals);
      auto contextId = getVal!uint(&_paramVals[1]);
      auto text = getVal!string(&_paramVals[2]);
      _dClosure.dlg(contextId, text, statusbar);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("text-popped", closure, after);
  }

  /**
   * Emitted whenever a new message gets pushed onto a statusbar's stack.
   * Params
   *   contextId = the context id of the relevant message/statusbar
   *   text = the message that was pushed
   *   statusbar = the instance the signal is connected to

   * Deprecated: This widget will be removed in GTK 5
   */
  alias TextPushedCallbackDlg = void delegate(uint contextId, string text, Statusbar statusbar);
  alias TextPushedCallbackFunc = void function(uint contextId, string text, Statusbar statusbar);

  /**
   * Connect to TextPushed signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectTextPushed(T)(T callback, Flag!"After" after = No.After)
  if (is(T : TextPushedCallbackDlg) || is(T : TextPushedCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto statusbar = getVal!Statusbar(_paramVals);
      auto contextId = getVal!uint(&_paramVals[1]);
      auto text = getVal!string(&_paramVals[2]);
      _dClosure.dlg(contextId, text, statusbar);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("text-pushed", closure, after);
  }
}
