module gtk.accessible_text;

public import gtk.accessible_text_iface_proxy;
import gid.global;
import gtk.c.functions;
import gtk.c.types;
import gtk.types;

/**
 * An interface for accessible objects containing formatted text.
 * The `GtkAccessibleText` interfaces is meant to be implemented by accessible
 * objects that have text formatted with attributes, or non-trivial text contents.
 * You should use the enum@Gtk.AccessibleProperty.LABEL or the
 * enum@Gtk.AccessibleProperty.DESCRIPTION properties for accessible
 * objects containing simple, unformatted text.
 */
interface AccessibleText
{

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_accessible_text_get_type != &gidSymbolNotFound ? gtk_accessible_text_get_type() : cast(GType)0;
  }

  /**
   * Updates the position of the caret.
   * Implementations of the `GtkAccessibleText` interface should call this
   * function every time the caret has moved, in order to notify assistive
   * technologies.
   */
  void updateCaretPosition();

  /**
   * Notifies assistive technologies of a change in contents.
   * Implementations of the `GtkAccessibleText` interface should call this
   * function every time their contents change as the result of an operation,
   * like an insertion or a removal.
   * Note: If the change is a deletion, this function must be called *before*
   * removing the contents, if it is an insertion, it must be called *after*
   * inserting the new contents.
   * Params:
   *   change = the type of change in the contents
   *   start = the starting offset of the change, in characters
   *   end = the end offset of the change, in characters
   */
  void updateContents(AccessibleTextContentChange change, uint start, uint end);

  /**
   * Updates the boundary of the selection.
   * Implementations of the `GtkAccessibleText` interface should call this
   * function every time the selection has moved, in order to notify assistive
   * technologies.
   */
  void updateSelectionBound();
}
