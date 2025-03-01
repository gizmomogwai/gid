module gtk.assistant;

import gid.global;
import gio.list_model;
import gio.list_model_mixin;
import gobject.dclosure;
import gobject.object;
import gtk.accessible;
import gtk.accessible_mixin;
import gtk.assistant_page;
import gtk.buildable;
import gtk.buildable_mixin;
import gtk.c.functions;
import gtk.c.types;
import gtk.constraint_target;
import gtk.constraint_target_mixin;
import gtk.native;
import gtk.native_mixin;
import gtk.root;
import gtk.root_mixin;
import gtk.shortcut_manager;
import gtk.shortcut_manager_mixin;
import gtk.types;
import gtk.widget;
import gtk.window;

/**
 * `GtkAssistant` is used to represent a complex as a series of steps.
 * ![An example GtkAssistant](assistant.png)
 * Each step consists of one or more pages. `GtkAssistant` guides the user
 * through the pages, and controls the page flow to collect the data needed
 * for the operation.
 * `GtkAssistant` handles which buttons to show and to make sensitive based
 * on page sequence knowledge and the [gtk.AssistantPageType] of each
 * page in addition to state information like the *completed* and *committed*
 * page statuses.
 * If you have a case that doesn’t quite fit in `GtkAssistant`s way of
 * handling buttons, you can use the %GTK_ASSISTANT_PAGE_CUSTOM page
 * type and handle buttons yourself.
 * `GtkAssistant` maintains a `GtkAssistantPage` object for each added
 * child, which holds additional per-child properties. You
 * obtain the `GtkAssistantPage` for a child with [gtk.assistant.Assistant.getPage].
 * # GtkAssistant as GtkBuildable
 * The `GtkAssistant` implementation of the `GtkBuildable` interface
 * exposes the @action_area as internal children with the name
 * “action_area”.
 * To add pages to an assistant in `GtkBuilder`, simply add it as a
 * child to the `GtkAssistant` object. If you need to set per-object
 * properties, create a `GtkAssistantPage` object explicitly, and
 * set the child widget as a property on it.
 * # CSS nodes
 * `GtkAssistant` has a single CSS node with the name window and style
 * class .assistant.

 * Deprecated: This widget will be removed in GTK 5
 */
class Assistant : Window
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_assistant_get_type != &gidSymbolNotFound ? gtk_assistant_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkAssistant`.
   * Returns: a newly created `GtkAssistant`

   * Deprecated: This widget will be removed in GTK 5
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_assistant_new();
    this(_cretval, No.Take);
  }

  /**
   * Adds a widget to the action area of a `GtkAssistant`.
   * Params:
   *   child = a `GtkWidget`

   * Deprecated: This widget will be removed in GTK 5
   */
  void addActionWidget(Widget child)
  {
    gtk_assistant_add_action_widget(cast(GtkAssistant*)cPtr, child ? cast(GtkWidget*)child.cPtr(No.Dup) : null);
  }

  /**
   * Appends a page to the assistant.
   * Params:
   *   page = a `GtkWidget`
   * Returns: the index $(LPAREN)starting at 0$(RPAREN) of the inserted page

   * Deprecated: This widget will be removed in GTK 5
   */
  int appendPage(Widget page)
  {
    int _retval;
    _retval = gtk_assistant_append_page(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null);
    return _retval;
  }

  /**
   * Erases the visited page history.
   * GTK will then hide the back button on the current page,
   * and removes the cancel button from subsequent pages.
   * Use this when the information provided up to the current
   * page is hereafter deemed permanent and cannot be modified
   * or undone. For example, showing a progress page to track
   * a long-running, unreversible operation after the user has
   * clicked apply on a confirmation page.

   * Deprecated: This widget will be removed in GTK 5
   */
  void commit()
  {
    gtk_assistant_commit(cast(GtkAssistant*)cPtr);
  }

  /**
   * Returns the page number of the current page.
   * Returns: The index $(LPAREN)starting from 0$(RPAREN) of the current
   *   page in the assistant, or -1 if the assistant has no pages,
   *   or no current page

   * Deprecated: This widget will be removed in GTK 5
   */
  int getCurrentPage()
  {
    int _retval;
    _retval = gtk_assistant_get_current_page(cast(GtkAssistant*)cPtr);
    return _retval;
  }

  /**
   * Returns the number of pages in the assistant
   * Returns: the number of pages in the assistant

   * Deprecated: This widget will be removed in GTK 5
   */
  int getNPages()
  {
    int _retval;
    _retval = gtk_assistant_get_n_pages(cast(GtkAssistant*)cPtr);
    return _retval;
  }

  /**
   * Returns the child widget contained in page number page_num.
   * Params:
   *   pageNum = the index of a page in the assistant,
   *     or -1 to get the last page
   * Returns: the child widget, or %NULL
   *   if page_num is out of bounds

   * Deprecated: This widget will be removed in GTK 5
   */
  Widget getNthPage(int pageNum)
  {
    GtkWidget* _cretval;
    _cretval = gtk_assistant_get_nth_page(cast(GtkAssistant*)cPtr, pageNum);
    auto _retval = ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns the `GtkAssistantPage` object for child.
   * Params:
   *   child = a child of assistant
   * Returns: the `GtkAssistantPage` for child

   * Deprecated: This widget will be removed in GTK 5
   */
  AssistantPage getPage(Widget child)
  {
    GtkAssistantPage* _cretval;
    _cretval = gtk_assistant_get_page(cast(GtkAssistant*)cPtr, child ? cast(GtkWidget*)child.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!AssistantPage(cast(GtkAssistantPage*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Gets whether page is complete.
   * Params:
   *   page = a page of assistant
   * Returns: %TRUE if page is complete.

   * Deprecated: This widget will be removed in GTK 5
   */
  bool getPageComplete(Widget page)
  {
    bool _retval;
    _retval = gtk_assistant_get_page_complete(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null);
    return _retval;
  }

  /**
   * Gets the title for page.
   * Params:
   *   page = a page of assistant
   * Returns: the title for page

   * Deprecated: This widget will be removed in GTK 5
   */
  string getPageTitle(Widget page)
  {
    const(char)* _cretval;
    _cretval = gtk_assistant_get_page_title(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null);
    string _retval = _cretval.fromCString(No.Free);
    return _retval;
  }

  /**
   * Gets the page type of page.
   * Params:
   *   page = a page of assistant
   * Returns: the page type of page

   * Deprecated: This widget will be removed in GTK 5
   */
  AssistantPageType getPageType(Widget page)
  {
    GtkAssistantPageType _cretval;
    _cretval = gtk_assistant_get_page_type(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null);
    AssistantPageType _retval = cast(AssistantPageType)_cretval;
    return _retval;
  }

  /**
   * Gets a list model of the assistant pages.
   * Returns: A list model of the pages.

   * Deprecated: This widget will be removed in GTK 5
   */
  ListModel getPages()
  {
    GListModel* _cretval;
    _cretval = gtk_assistant_get_pages(cast(GtkAssistant*)cPtr);
    auto _retval = ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Inserts a page in the assistant at a given position.
   * Params:
   *   page = a `GtkWidget`
   *   position = the index $(LPAREN)starting at 0$(RPAREN) at which to insert the page,
   *     or -1 to append the page to the assistant
   * Returns: the index $(LPAREN)starting from 0$(RPAREN) of the inserted page

   * Deprecated: This widget will be removed in GTK 5
   */
  int insertPage(Widget page, int position)
  {
    int _retval;
    _retval = gtk_assistant_insert_page(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null, position);
    return _retval;
  }

  /**
   * Navigate to the next page.
   * It is a programming error to call this function when
   * there is no next page.
   * This function is for use when creating pages of the
   * %GTK_ASSISTANT_PAGE_CUSTOM type.

   * Deprecated: This widget will be removed in GTK 5
   */
  void nextPage()
  {
    gtk_assistant_next_page(cast(GtkAssistant*)cPtr);
  }

  /**
   * Prepends a page to the assistant.
   * Params:
   *   page = a `GtkWidget`
   * Returns: the index $(LPAREN)starting at 0$(RPAREN) of the inserted page

   * Deprecated: This widget will be removed in GTK 5
   */
  int prependPage(Widget page)
  {
    int _retval;
    _retval = gtk_assistant_prepend_page(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null);
    return _retval;
  }

  /**
   * Navigate to the previous visited page.
   * It is a programming error to call this function when
   * no previous page is available.
   * This function is for use when creating pages of the
   * %GTK_ASSISTANT_PAGE_CUSTOM type.

   * Deprecated: This widget will be removed in GTK 5
   */
  void previousPage()
  {
    gtk_assistant_previous_page(cast(GtkAssistant*)cPtr);
  }

  /**
   * Removes a widget from the action area of a `GtkAssistant`.
   * Params:
   *   child = a `GtkWidget`

   * Deprecated: This widget will be removed in GTK 5
   */
  void removeActionWidget(Widget child)
  {
    gtk_assistant_remove_action_widget(cast(GtkAssistant*)cPtr, child ? cast(GtkWidget*)child.cPtr(No.Dup) : null);
  }

  /**
   * Removes the page_num’s page from assistant.
   * Params:
   *   pageNum = the index of a page in the assistant,
   *     or -1 to remove the last page

   * Deprecated: This widget will be removed in GTK 5
   */
  void removePage(int pageNum)
  {
    gtk_assistant_remove_page(cast(GtkAssistant*)cPtr, pageNum);
  }

  /**
   * Switches the page to page_num.
   * Note that this will only be necessary in custom buttons,
   * as the assistant flow can be set with
   * [gtk.assistant.Assistant.setForwardPageFunc].
   * Params:
   *   pageNum = index of the page to switch to, starting from 0.
   *     If negative, the last page will be used. If greater
   *     than the number of pages in the assistant, nothing
   *     will be done.

   * Deprecated: This widget will be removed in GTK 5
   */
  void setCurrentPage(int pageNum)
  {
    gtk_assistant_set_current_page(cast(GtkAssistant*)cPtr, pageNum);
  }

  /**
   * Sets the page forwarding function to be page_func.
   * This function will be used to determine what will be
   * the next page when the user presses the forward button.
   * Setting page_func to %NULL will make the assistant to
   * use the default forward function, which just goes to the
   * next visible page.
   * Params:
   *   pageFunc = the `GtkAssistantPageFunc`, or %NULL
   *     to use the default one

   * Deprecated: This widget will be removed in GTK 5
   */
  void setForwardPageFunc(AssistantPageFunc pageFunc)
  {
    extern(C) int _pageFuncCallback(int currentPage, void* data)
    {
      auto _dlg = cast(AssistantPageFunc*)data;

      int _retval = (*_dlg)(currentPage);
      return _retval;
    }
    auto _pageFuncCB = pageFunc ? &_pageFuncCallback : null;

    auto _pageFunc = pageFunc ? freezeDelegate(cast(void*)&pageFunc) : null;
    GDestroyNotify _pageFuncDestroyCB = pageFunc ? &thawDelegate : null;
    gtk_assistant_set_forward_page_func(cast(GtkAssistant*)cPtr, _pageFuncCB, _pageFunc, _pageFuncDestroyCB);
  }

  /**
   * Sets whether page contents are complete.
   * This will make assistant update the buttons state
   * to be able to continue the task.
   * Params:
   *   page = a page of assistant
   *   complete = the completeness status of the page

   * Deprecated: This widget will be removed in GTK 5
   */
  void setPageComplete(Widget page, bool complete)
  {
    gtk_assistant_set_page_complete(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null, complete);
  }

  /**
   * Sets a title for page.
   * The title is displayed in the header area of the assistant
   * when page is the current page.
   * Params:
   *   page = a page of assistant
   *   title = the new title for page

   * Deprecated: This widget will be removed in GTK 5
   */
  void setPageTitle(Widget page, string title)
  {
    const(char)* _title = title.toCString(No.Alloc);
    gtk_assistant_set_page_title(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null, _title);
  }

  /**
   * Sets the page type for page.
   * The page type determines the page behavior in the assistant.
   * Params:
   *   page = a page of assistant
   *   type = the new type for page

   * Deprecated: This widget will be removed in GTK 5
   */
  void setPageType(Widget page, AssistantPageType type)
  {
    gtk_assistant_set_page_type(cast(GtkAssistant*)cPtr, page ? cast(GtkWidget*)page.cPtr(No.Dup) : null, type);
  }

  /**
   * Forces assistant to recompute the buttons state.
   * GTK automatically takes care of this in most situations,
   * e.g. when the user goes to a different page, or when the
   * visibility or completeness of a page changes.
   * One situation where it can be necessary to call this
   * function is when changing a value on the current page
   * affects the future page flow of the assistant.

   * Deprecated: This widget will be removed in GTK 5
   */
  void updateButtonsState()
  {
    gtk_assistant_update_buttons_state(cast(GtkAssistant*)cPtr);
  }

  /**
   * Emitted when the apply button is clicked.
   * The default behavior of the `GtkAssistant` is to switch to the page
   * after the current page, unless the current page is the last one.
   * A handler for the ::apply signal should carry out the actions for
   * which the wizard has collected data. If the action takes a long time
   * to complete, you might consider putting a page of type
   * %GTK_ASSISTANT_PAGE_PROGRESS after the confirmation page and handle
   * this operation within the [gtk.assistant.Assistant.prepare] signal of
   * the progress page.
   *   assistant = the instance the signal is connected to

   * Deprecated: This widget will be removed in GTK 5
   */
  alias ApplyCallbackDlg = void delegate(Assistant assistant);
  alias ApplyCallbackFunc = void function(Assistant assistant);

  /**
   * Connect to Apply signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectApply(T)(T callback, Flag!"After" after = No.After)
  if (is(T : ApplyCallbackDlg) || is(T : ApplyCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto assistant = getVal!Assistant(_paramVals);
      _dClosure.dlg(assistant);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("apply", closure, after);
  }

  /**
   * Emitted when then the cancel button is clicked.
   *   assistant = the instance the signal is connected to

   * Deprecated: This widget will be removed in GTK 5
   */
  alias CancelCallbackDlg = void delegate(Assistant assistant);
  alias CancelCallbackFunc = void function(Assistant assistant);

  /**
   * Connect to Cancel signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCancel(T)(T callback, Flag!"After" after = No.After)
  if (is(T : CancelCallbackDlg) || is(T : CancelCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto assistant = getVal!Assistant(_paramVals);
      _dClosure.dlg(assistant);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("cancel", closure, after);
  }

  /**
   * Emitted either when the close button of a summary page is clicked,
   * or when the apply button in the last page in the flow $(LPAREN)of type
   * %GTK_ASSISTANT_PAGE_CONFIRM$(RPAREN) is clicked.
   *   assistant = the instance the signal is connected to

   * Deprecated: This widget will be removed in GTK 5
   */
  alias CloseCallbackDlg = void delegate(Assistant assistant);
  alias CloseCallbackFunc = void function(Assistant assistant);

  /**
   * Connect to Close signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectClose(T)(T callback, Flag!"After" after = No.After)
  if (is(T : CloseCallbackDlg) || is(T : CloseCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto assistant = getVal!Assistant(_paramVals);
      _dClosure.dlg(assistant);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("close", closure, after);
  }

  /**
   * The action signal for the Escape binding.
   *   assistant = the instance the signal is connected to

   * Deprecated: This widget will be removed in GTK 5
   */
  alias EscapeCallbackDlg = void delegate(Assistant assistant);
  alias EscapeCallbackFunc = void function(Assistant assistant);

  /**
   * Connect to Escape signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEscape(T)(T callback, Flag!"After" after = No.After)
  if (is(T : EscapeCallbackDlg) || is(T : EscapeCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto assistant = getVal!Assistant(_paramVals);
      _dClosure.dlg(assistant);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("escape", closure, after);
  }

  /**
   * Emitted when a new page is set as the assistant's current page,
   * before making the new page visible.
   * A handler for this signal can do any preparations which are
   * necessary before showing page.
   * Params
   *   page = the current page
   *   assistant = the instance the signal is connected to

   * Deprecated: This widget will be removed in GTK 5
   */
  alias PrepareCallbackDlg = void delegate(Widget page, Assistant assistant);
  alias PrepareCallbackFunc = void function(Widget page, Assistant assistant);

  /**
   * Connect to Prepare signal.
   * Params:
   *   callback = signal callback delegate or function to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPrepare(T)(T callback, Flag!"After" after = No.After)
  if (is(T : PrepareCallbackDlg) || is(T : PrepareCallbackFunc))
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dClosure = cast(DGClosure!T*)_closure;
      auto assistant = getVal!Assistant(_paramVals);
      auto page = getVal!Widget(&_paramVals[1]);
      _dClosure.dlg(page, assistant);
    }

    auto closure = new DClosure(callback, &_cmarshal);
    return connectSignalClosure("prepare", closure, after);
  }
}
