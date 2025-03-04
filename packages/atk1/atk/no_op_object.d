module atk.no_op_object;

import atk.action;
import atk.action_mixin;
import atk.c.functions;
import atk.c.types;
import atk.component;
import atk.component_mixin;
import atk.document;
import atk.document_mixin;
import atk.editable_text;
import atk.editable_text_mixin;
import atk.hypertext;
import atk.hypertext_mixin;
import atk.image;
import atk.image_mixin;
import atk.object;
import atk.selection;
import atk.selection_mixin;
import atk.table;
import atk.table_cell;
import atk.table_cell_mixin;
import atk.table_mixin;
import atk.text;
import atk.text_mixin;
import atk.types;
import atk.value;
import atk.value_mixin;
import atk.window;
import atk.window_mixin;
import gid.global;
import gobject.object;

/**
 * An AtkObject which purports to implement all ATK interfaces.
 * An AtkNoOpObject is an AtkObject which purports to implement all
 * ATK interfaces. It is the type of AtkObject which is created if an
 * accessible object is requested for an object type for which no
 * factory type is specified.
 */
class NoOpObject : ObjectAtk, Action, Component, Document, EditableText, Hypertext, Image, Selection, Table, TableCell, Text, ValueAtk, Window
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())atk_no_op_object_get_type != &gidSymbolNotFound ? atk_no_op_object_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionT!();
  mixin ComponentT!();
  mixin DocumentT!();
  mixin EditableTextT!();
  mixin HypertextT!();
  mixin ImageT!();
  mixin SelectionT!();
  mixin TableT!();
  mixin TableCellT!();
  mixin TextT!();
  mixin ValueAtkT!();
  mixin WindowT!();
  alias getDescription = ObjectAtk.getDescription;

  alias getName = ObjectAtk.getName;

  alias setDescription = ObjectAtk.setDescription;


  /**
   * Provides a default $(LPAREN)non-functioning stub$(RPAREN) #AtkObject.
   * Application maintainers should not use this method.
   * Params:
   *   obj = a #GObject
   * Returns: a default $(LPAREN)non-functioning stub$(RPAREN) #AtkObject
   */
  this(ObjectG obj)
  {
    AtkObject* _cretval;
    _cretval = atk_no_op_object_new(obj ? cast(ObjectC*)obj.cPtr(No.Dup) : null);
    this(_cretval, Yes.Take);
  }
}
