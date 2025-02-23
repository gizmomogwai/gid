module gtk.tree_drag_dest;

public import gtk.tree_drag_dest_iface_proxy;
import gid.gid;
import gobject.value;
import gtk.c.functions;
import gtk.c.types;
import gtk.tree_path;
import gtk.types;

/**
 * Interface for Drag-and-Drop destinations in `GtkTreeView`.

 * Deprecated: List views use widgets to display their contents.
 *   You can use [Gtk.DropTarget] to implement a drop destination
 */
interface TreeDragDest
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_tree_drag_dest_get_type != &gidSymbolNotFound ? gtk_tree_drag_dest_get_type() : cast(GType)0;
  }

  /**
   * Asks the `GtkTreeDragDest` to insert a row before the path dest,
   * deriving the contents of the row from value. If dest is
   * outside the tree so that inserting before it is impossible, %FALSE
   * will be returned. Also, %FALSE may be returned if the new row is
   * not created for some model-specific reason.  Should robustly handle
   * a dest no longer found in the model!
   * Params:
   *   dest = row to drop in front of
   *   value = data to drop
   * Returns: whether a new row was created before position dest

   * Deprecated: Use list models instead
   */
  bool dragDataReceived(TreePath dest, Value value);

  /**
   * Determines whether a drop is possible before the given dest_path,
   * at the same depth as dest_path. i.e., can we drop the data in
   * value at that location. dest_path does not have to
   * exist; the return value will almost certainly be %FALSE if the
   * parent of dest_path doesn’t exist, though.
   * Params:
   *   destPath = destination row
   *   value = the data being dropped
   * Returns: %TRUE if a drop is possible before dest_path

   * Deprecated: Use list models instead
   */
  bool rowDropPossible(TreePath destPath, Value value);
}
