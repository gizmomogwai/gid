module gtk.tree_row_reference;

import gid.global;
import gobject.boxed;
import gobject.object;
import gtk.c.functions;
import gtk.c.types;
import gtk.tree_model;
import gtk.tree_model_mixin;
import gtk.tree_path;
import gtk.types;

/**
 * A GtkTreeRowReference tracks model changes so that it always refers to the
 * same row $(LPAREN)a `GtkTreePath` refers to a position, not a fixed row$(RPAREN). Create a
 * new GtkTreeRowReference with [gtk.tree_row_reference.TreeRowReference.new_].

 * Deprecated: Use [gio.list_model.ListModel] instead
 */
class TreeRowReference : Boxed
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  void* cPtr(Flag!"Dup" dup = No.Dup)
  {
    return dup ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_tree_row_reference_get_type != &gidSymbolNotFound ? gtk_tree_row_reference_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a row reference based on path.
   * This reference will keep pointing to the node pointed to
   * by path, so long as it exists. Any changes that occur on model are
   * propagated, and the path is updated appropriately. If
   * path isn’t a valid path in model, then %NULL is returned.
   * Params:
   *   model = a `GtkTreeModel`
   *   path = a valid `GtkTreePath` to monitor
   * Returns: a newly allocated `GtkTreeRowReference`
   */
  this(TreeModel model, TreePath path)
  {
    GtkTreeRowReference* _cretval;
    _cretval = gtk_tree_row_reference_new(model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(No.Dup) : null, path ? cast(GtkTreePath*)path.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }

  /**
   * You do not need to use this function.
   * Creates a row reference based on path.
   * This reference will keep pointing to the node pointed to
   * by path, so long as it exists. If path isn’t a valid
   * path in model, then %NULL is returned. However, unlike
   * references created with [gtk.tree_row_reference.TreeRowReference.new_], it
   * does not listen to the model for changes. The creator of
   * the row reference must do this explicitly using
   * [gtk.tree_row_reference.TreeRowReference.inserted], [gtk.tree_row_reference.TreeRowReference.deleted],
   * [gtk.tree_row_reference.TreeRowReference.reordered].
   * These functions must be called exactly once per proxy when the
   * corresponding signal on the model is emitted. This single call
   * updates all row references for that proxy. Since built-in GTK
   * objects like `GtkTreeView` already use this mechanism internally,
   * using them as the proxy object will produce unpredictable results.
   * Further more, passing the same object as model and proxy
   * doesn’t work for reasons of internal implementation.
   * This type of row reference is primarily meant by structures that
   * need to carefully monitor exactly when a row reference updates
   * itself, and is not generally needed by most applications.
   * Params:
   *   proxy = a proxy `GObject`
   *   model = a `GtkTreeModel`
   *   path = a valid `GtkTreePath` to monitor
   * Returns: a newly allocated `GtkTreeRowReference`
   */
  static TreeRowReference newProxy(ObjectG proxy, TreeModel model, TreePath path)
  {
    GtkTreeRowReference* _cretval;
    _cretval = gtk_tree_row_reference_new_proxy(proxy ? cast(ObjectC*)proxy.cPtr(No.Dup) : null, model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(No.Dup) : null, path ? cast(GtkTreePath*)path.cPtr(No.Dup) : null);
    auto _retval = _cretval ? new TreeRowReference(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Copies a `GtkTreeRowReference`.
   * Returns: a copy of reference
   */
  TreeRowReference copy()
  {
    GtkTreeRowReference* _cretval;
    _cretval = gtk_tree_row_reference_copy(cast(GtkTreeRowReference*)cPtr);
    auto _retval = _cretval ? new TreeRowReference(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Returns the model that the row reference is monitoring.
   * Returns: the model
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_tree_row_reference_get_model(cast(GtkTreeRowReference*)cPtr);
    auto _retval = ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Returns a path that the row reference currently points to,
   * or %NULL if the path pointed to is no longer valid.
   * Returns: a current path
   */
  TreePath getPath()
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_row_reference_get_path(cast(GtkTreeRowReference*)cPtr);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if the reference is non-%NULL and refers to
   * a current valid path.
   * Returns: %TRUE if reference points to a valid path
   */
  bool valid()
  {
    bool _retval;
    _retval = gtk_tree_row_reference_valid(cast(GtkTreeRowReference*)cPtr);
    return _retval;
  }

  /**
   * Lets a set of row reference created by
   * [gtk.tree_row_reference.TreeRowReference.newProxy] know that the
   * model emitted the ::row-deleted signal.
   * Params:
   *   proxy = a `GObject`
   *   path = the path position that was deleted
   */
  static void deleted(ObjectG proxy, TreePath path)
  {
    gtk_tree_row_reference_deleted(proxy ? cast(ObjectC*)proxy.cPtr(No.Dup) : null, path ? cast(GtkTreePath*)path.cPtr(No.Dup) : null);
  }

  /**
   * Lets a set of row reference created by
   * [gtk.tree_row_reference.TreeRowReference.newProxy] know that the
   * model emitted the ::row-inserted signal.
   * Params:
   *   proxy = a `GObject`
   *   path = the row position that was inserted
   */
  static void inserted(ObjectG proxy, TreePath path)
  {
    gtk_tree_row_reference_inserted(proxy ? cast(ObjectC*)proxy.cPtr(No.Dup) : null, path ? cast(GtkTreePath*)path.cPtr(No.Dup) : null);
  }
}
