module gtk.snapshot;

import cairo.context;
import gdk.paintable;
import gdk.paintable_mixin;
import gdk.rgba;
import gdk.snapshot : DGdkSnapshot = Snapshot;
import gdk.texture;
import gid.global;
import glib.bytes;
import gobject.object;
import graphene.matrix;
import graphene.point;
import graphene.point3_d;
import graphene.rect;
import graphene.size;
import graphene.vec3;
import graphene.vec4;
import gsk.glshader;
import gsk.path;
import gsk.render_node;
import gsk.rounded_rect;
import gsk.stroke;
import gsk.transform;
import gsk.types;
import gtk.c.functions;
import gtk.c.types;
import gtk.style_context;
import gtk.types;
import pango.layout;
import pango.types;

/**
 * `GtkSnapshot` assists in creating [gsk.render_node.RenderNode]s for widgets.
 * It functions in a similar way to a cairo context, and maintains a stack
 * of render nodes and their associated transformations.
 * The node at the top of the stack is the one that `gtk_snapshot_append_…$(LPAREN)$(RPAREN)`
 * functions operate on. Use the `gtk_snapshot_push_…$(LPAREN)$(RPAREN)` functions and
 * [gtk.snapshot.Snapshot.pop] to change the current node.
 * The typical way to obtain a `GtkSnapshot` object is as an argument to
 * the vfunc@Gtk.Widget.snapshot vfunc. If you need to create your own
 * `GtkSnapshot`, use [gtk.snapshot.Snapshot.new_].
 */
class Snapshot : DGdkSnapshot
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gtk_snapshot_get_type != &gidSymbolNotFound ? gtk_snapshot_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkSnapshot`.
   * Returns: a newly-allocated `GtkSnapshot`
   */
  this()
  {
    GtkSnapshot* _cretval;
    _cretval = gtk_snapshot_new();
    this(_cretval, Yes.Take);
  }

  /**
   * Appends a stroked border rectangle inside the given outline.
   * The four sides of the border can have different widths and colors.
   * Params:
   *   outline = the outline of the border
   *   borderWidth = the stroke width of the border on
   *     the top, right, bottom and left side respectively.
   *   borderColor = the color used on the top, right,
   *     bottom and left side.
   */
  void appendBorder(RoundedRect outline, float[] borderWidth, RGBA[] borderColor)
  {
    assert(!borderWidth || borderWidth.length == 4);
    auto _borderWidth = cast(const(float)*)borderWidth.ptr;
    assert(!borderColor || borderColor.length == 4);
    GdkRGBA[] _tmpborderColor;
    foreach (obj; borderColor)
      _tmpborderColor ~= *cast(GdkRGBA*)obj.cPtr;
    const(GdkRGBA)* _borderColor = _tmpborderColor.ptr;
    gtk_snapshot_append_border(cast(GtkSnapshot*)cPtr, outline ? cast(GskRoundedRect*)outline.cPtr : null, _borderWidth, _borderColor);
  }

  /**
   * Creates a new [gsk.cairo_node.CairoNode] and appends it to the current
   * render node of snapshot, without changing the current node.
   * Params:
   *   bounds = the bounds for the new node
   * Returns: a `cairo_t` suitable for drawing the contents of
   *   the newly created render node
   */
  Context appendCairo(Rect bounds)
  {
    cairo_t* _cretval;
    _cretval = gtk_snapshot_append_cairo(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null);
    auto _retval = _cretval ? new Context(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Creates a new render node drawing the color into the
   * given bounds and appends it to the current render node
   * of snapshot.
   * You should try to avoid calling this function if
   * color is transparent.
   * Params:
   *   color = the color to draw
   *   bounds = the bounds for the new node
   */
  void appendColor(RGBA color, Rect bounds)
  {
    gtk_snapshot_append_color(cast(GtkSnapshot*)cPtr, color ? cast(GdkRGBA*)color.cPtr(No.Dup) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null);
  }

  /**
   * A convenience method to fill a path with a color.
   * See [gtk.snapshot.Snapshot.pushFill] if you need
   * to fill a path with more complex content than
   * a color.
   * Params:
   *   path = The path describing the area to fill
   *   fillRule = The fill rule to use
   *   color = the color to fill the path with
   */
  void appendFill(Path path, FillRule fillRule, RGBA color)
  {
    gtk_snapshot_append_fill(cast(GtkSnapshot*)cPtr, path ? cast(GskPath*)path.cPtr(No.Dup) : null, fillRule, color ? cast(GdkRGBA*)color.cPtr(No.Dup) : null);
  }

  /**
   * Appends an inset shadow into the box given by outline.
   * Params:
   *   outline = outline of the region surrounded by shadow
   *   color = color of the shadow
   *   dx = horizontal offset of shadow
   *   dy = vertical offset of shadow
   *   spread = how far the shadow spreads towards the inside
   *   blurRadius = how much blur to apply to the shadow
   */
  void appendInsetShadow(RoundedRect outline, RGBA color, float dx, float dy, float spread, float blurRadius)
  {
    gtk_snapshot_append_inset_shadow(cast(GtkSnapshot*)cPtr, outline ? cast(GskRoundedRect*)outline.cPtr : null, color ? cast(GdkRGBA*)color.cPtr(No.Dup) : null, dx, dy, spread, blurRadius);
  }

  void appendLayout(Layout layout, RGBA color)
  {
    gtk_snapshot_append_layout(cast(GtkSnapshot*)cPtr, layout ? cast(PangoLayout*)layout.cPtr(No.Dup) : null, color ? cast(GdkRGBA*)color.cPtr(No.Dup) : null);
  }

  /**
   * Appends node to the current render node of snapshot,
   * without changing the current node.
   * If snapshot does not have a current node yet, node
   * will become the initial node.
   * Params:
   *   node = a `GskRenderNode`
   */
  void appendNode(RenderNode node)
  {
    gtk_snapshot_append_node(cast(GtkSnapshot*)cPtr, node ? cast(GskRenderNode*)node.cPtr(No.Dup) : null);
  }

  /**
   * Appends an outset shadow node around the box given by outline.
   * Params:
   *   outline = outline of the region surrounded by shadow
   *   color = color of the shadow
   *   dx = horizontal offset of shadow
   *   dy = vertical offset of shadow
   *   spread = how far the shadow spreads towards the outside
   *   blurRadius = how much blur to apply to the shadow
   */
  void appendOutsetShadow(RoundedRect outline, RGBA color, float dx, float dy, float spread, float blurRadius)
  {
    gtk_snapshot_append_outset_shadow(cast(GtkSnapshot*)cPtr, outline ? cast(GskRoundedRect*)outline.cPtr : null, color ? cast(GdkRGBA*)color.cPtr(No.Dup) : null, dx, dy, spread, blurRadius);
  }

  /**
   * Creates a new render node drawing the texture
   * into the given bounds and appends it to the
   * current render node of snapshot.
   * In contrast to [gtk.snapshot.Snapshot.appendTexture],
   * this function provides control about how the filter
   * that is used when scaling.
   * Params:
   *   texture = the texture to render
   *   filter = the filter to use
   *   bounds = the bounds for the new node
   */
  void appendScaledTexture(Texture texture, ScalingFilter filter, Rect bounds)
  {
    gtk_snapshot_append_scaled_texture(cast(GtkSnapshot*)cPtr, texture ? cast(GdkTexture*)texture.cPtr(No.Dup) : null, filter, bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null);
  }

  /**
   * A convenience method to stroke a path with a color.
   * See [gtk.snapshot.Snapshot.pushStroke] if you need
   * to stroke a path with more complex content than
   * a color.
   * Params:
   *   path = The path describing the area to fill
   *   stroke = The stroke attributes
   *   color = the color to fill the path with
   */
  void appendStroke(Path path, Stroke stroke, RGBA color)
  {
    gtk_snapshot_append_stroke(cast(GtkSnapshot*)cPtr, path ? cast(GskPath*)path.cPtr(No.Dup) : null, stroke ? cast(GskStroke*)stroke.cPtr(No.Dup) : null, color ? cast(GdkRGBA*)color.cPtr(No.Dup) : null);
  }

  /**
   * Creates a new render node drawing the texture
   * into the given bounds and appends it to the
   * current render node of snapshot.
   * If the texture needs to be scaled to fill bounds,
   * linear filtering is used. See [gtk.snapshot.Snapshot.appendScaledTexture]
   * if you need other filtering, such as nearest-neighbour.
   * Params:
   *   texture = the texture to render
   *   bounds = the bounds for the new node
   */
  void appendTexture(Texture texture, Rect bounds)
  {
    gtk_snapshot_append_texture(cast(GtkSnapshot*)cPtr, texture ? cast(GdkTexture*)texture.cPtr(No.Dup) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null);
  }

  /**
   * Removes the top element from the stack of render nodes and
   * adds it to the nearest [gsk.glshader_node.GLShaderNode] below it.
   * This must be called the same number of times as the number
   * of textures is needed for the shader in
   * [gtk.snapshot.Snapshot.pushGlShader].
   */
  void glShaderPopTexture()
  {
    gtk_snapshot_gl_shader_pop_texture(cast(GtkSnapshot*)cPtr);
  }

  /**
   * Applies a perspective projection transform.
   * See [gsk.transform.Transform.perspective] for a discussion on the details.
   * Params:
   *   depth = distance of the z\=0 plane
   */
  void perspective(float depth)
  {
    gtk_snapshot_perspective(cast(GtkSnapshot*)cPtr, depth);
  }

  /**
   * Removes the top element from the stack of render nodes,
   * and appends it to the node underneath it.
   */
  void pop()
  {
    gtk_snapshot_pop(cast(GtkSnapshot*)cPtr);
  }

  /**
   * Blends together two images with the given blend mode.
   * Until the first call to [gtk.snapshot.Snapshot.pop], the
   * bottom image for the blend operation will be recorded.
   * After that call, the top image to be blended will be
   * recorded until the second call to [gtk.snapshot.Snapshot.pop].
   * Calling this function requires two subsequent calls
   * to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   blendMode = blend mode to use
   */
  void pushBlend(BlendMode blendMode)
  {
    gtk_snapshot_push_blend(cast(GtkSnapshot*)cPtr, blendMode);
  }

  /**
   * Blurs an image.
   * The image is recorded until the next call to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   radius = the blur radius to use. Must be positive
   */
  void pushBlur(double radius)
  {
    gtk_snapshot_push_blur(cast(GtkSnapshot*)cPtr, radius);
  }

  /**
   * Clips an image to a rectangle.
   * The image is recorded until the next call to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   bounds = the rectangle to clip to
   */
  void pushClip(Rect bounds)
  {
    gtk_snapshot_push_clip(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null);
  }

  /**
   * Modifies the colors of an image by applying an affine transformation
   * in RGB space.
   * In particular, the colors will be transformed by applying
   * pixel \= transpose$(LPAREN)color_matrix$(RPAREN) * pixel + color_offset
   * for every pixel. The transformation operates on unpremultiplied
   * colors, with color components ordered R, G, B, A.
   * The image is recorded until the next call to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   colorMatrix = the color matrix to use
   *   colorOffset = the color offset to use
   */
  void pushColorMatrix(Matrix colorMatrix, Vec4 colorOffset)
  {
    gtk_snapshot_push_color_matrix(cast(GtkSnapshot*)cPtr, colorMatrix ? cast(graphene_matrix_t*)colorMatrix.cPtr(No.Dup) : null, colorOffset ? cast(graphene_vec4_t*)colorOffset.cPtr(No.Dup) : null);
  }

  /**
   * Snapshots a cross-fade operation between two images with the
   * given progress.
   * Until the first call to [gtk.snapshot.Snapshot.pop], the start image
   * will be snapshot. After that call, the end image will be recorded
   * until the second call to [gtk.snapshot.Snapshot.pop].
   * Calling this function requires two subsequent calls
   * to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   progress = progress between 0.0 and 1.0
   */
  void pushCrossFade(double progress)
  {
    gtk_snapshot_push_cross_fade(cast(GtkSnapshot*)cPtr, progress);
  }

  /**
   * Fills the area given by path and fill_rule with an image and discards everything
   * outside of it.
   * The image is recorded until the next call to [gtk.snapshot.Snapshot.pop].
   * If you want to fill the path with a color, [gtk.snapshot.Snapshot.appendFill]
   * may be more convenient.
   * Params:
   *   path = The path describing the area to fill
   *   fillRule = The fill rule to use
   */
  void pushFill(Path path, FillRule fillRule)
  {
    gtk_snapshot_push_fill(cast(GtkSnapshot*)cPtr, path ? cast(GskPath*)path.cPtr(No.Dup) : null, fillRule);
  }

  /**
   * Push a [gsk.glshader_node.GLShaderNode].
   * The node uses the given [gsk.glshader.GLShader] and uniform values
   * Additionally this takes a list of n_children other nodes
   * which will be passed to the [gsk.glshader_node.GLShaderNode].
   * The take_args argument is a block of data to use for uniform
   * arguments, as per types and offsets defined by the shader.
   * Normally this is generated by [gsk.glshader.GLShader.formatArgs]
   * or [gsk.shader_args_builder.ShaderArgsBuilder].
   * The snapshotter takes ownership of take_args, so the caller should
   * not free it after this.
   * If the renderer doesn't support GL shaders, or if there is any
   * problem when compiling the shader, then the node will draw pink.
   * You should use [gsk.glshader.GLShader.compile] to ensure the shader
   * will work for the renderer before using it.
   * If the shader requires textures $(LPAREN)see [gsk.glshader.GLShader.getNTextures]$(RPAREN),
   * then it is expected that you call [gtk.snapshot.Snapshot.glShaderPopTexture]
   * the number of times that are required. Each of these calls will generate
   * a node that is added as a child to the `GskGLShaderNode`, which in turn
   * will render these offscreen and pass as a texture to the shader.
   * Once all textures $(LPAREN)if any$(RPAREN) are pop:ed, you must call the regular
   * [gtk.snapshot.Snapshot.pop].
   * If you want to use pre-existing textures as input to the shader rather
   * than rendering new ones, use [gtk.snapshot.Snapshot.appendTexture] to
   * push a texture node. These will be used directly rather than being
   * re-rendered.
   * For details on how to write shaders, see [gsk.glshader.GLShader].
   * Params:
   *   shader = The code to run
   *   bounds = the rectangle to render into
   *   takeArgs = Data block with arguments for the shader.
   */
  void pushGlShader(GLShader shader, Rect bounds, Bytes takeArgs)
  {
    gtk_snapshot_push_gl_shader(cast(GtkSnapshot*)cPtr, shader ? cast(GskGLShader*)shader.cPtr(No.Dup) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null, takeArgs ? cast(GBytes*)takeArgs.cPtr(Yes.Dup) : null);
  }

  /**
   * Until the first call to [gtk.snapshot.Snapshot.pop], the
   * mask image for the mask operation will be recorded.
   * After that call, the source image will be recorded until
   * the second call to [gtk.snapshot.Snapshot.pop].
   * Calling this function requires 2 subsequent calls to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   maskMode = mask mode to use
   */
  void pushMask(MaskMode maskMode)
  {
    gtk_snapshot_push_mask(cast(GtkSnapshot*)cPtr, maskMode);
  }

  /**
   * Modifies the opacity of an image.
   * The image is recorded until the next call to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   opacity = the opacity to use
   */
  void pushOpacity(double opacity)
  {
    gtk_snapshot_push_opacity(cast(GtkSnapshot*)cPtr, opacity);
  }

  /**
   * Creates a node that repeats the child node.
   * The child is recorded until the next call to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   bounds = the bounds within which to repeat
   *   childBounds = the bounds of the child or %NULL
   *     to use the full size of the collected child node
   */
  void pushRepeat(Rect bounds, Rect childBounds)
  {
    gtk_snapshot_push_repeat(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(No.Dup) : null, childBounds ? cast(graphene_rect_t*)childBounds.cPtr(No.Dup) : null);
  }

  /**
   * Clips an image to a rounded rectangle.
   * The image is recorded until the next call to [gtk.snapshot.Snapshot.pop].
   * Params:
   *   bounds = the rounded rectangle to clip to
   */
  void pushRoundedClip(RoundedRect bounds)
  {
    gtk_snapshot_push_rounded_clip(cast(GtkSnapshot*)cPtr, bounds ? cast(GskRoundedRect*)bounds.cPtr : null);
  }

  /**
   * Strokes the given path with the attributes given by stroke and
   * an image.
   * The image is recorded until the next call to [gtk.snapshot.Snapshot.pop].
   * Note that the strokes are subject to the same transformation as
   * everything else, so uneven scaling will cause horizontal and vertical
   * strokes to have different widths.
   * If you want to stroke the path with a color, [gtk.snapshot.Snapshot.appendStroke]
   * may be more convenient.
   * Params:
   *   path = The path to stroke
   *   stroke = The stroke attributes
   */
  void pushStroke(Path path, Stroke stroke)
  {
    gtk_snapshot_push_stroke(cast(GtkSnapshot*)cPtr, path ? cast(GskPath*)path.cPtr(No.Dup) : null, stroke ? cast(GskStroke*)stroke.cPtr(No.Dup) : null);
  }

  /**
   * Creates a render node for the CSS background according to context,
   * and appends it to the current node of snapshot, without changing
   * the current node.
   * Params:
   *   context = the style context that defines the background
   *   x = X origin of the rectangle
   *   y = Y origin of the rectangle
   *   width = rectangle width
   *   height = rectangle height
   */
  void renderBackground(StyleContext context, double x, double y, double width, double height)
  {
    gtk_snapshot_render_background(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(No.Dup) : null, x, y, width, height);
  }

  /**
   * Creates a render node for the focus outline according to context,
   * and appends it to the current node of snapshot, without changing
   * the current node.
   * Params:
   *   context = the style context that defines the focus ring
   *   x = X origin of the rectangle
   *   y = Y origin of the rectangle
   *   width = rectangle width
   *   height = rectangle height
   */
  void renderFocus(StyleContext context, double x, double y, double width, double height)
  {
    gtk_snapshot_render_focus(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(No.Dup) : null, x, y, width, height);
  }

  /**
   * Creates a render node for the CSS border according to context,
   * and appends it to the current node of snapshot, without changing
   * the current node.
   * Params:
   *   context = the style context that defines the frame
   *   x = X origin of the rectangle
   *   y = Y origin of the rectangle
   *   width = rectangle width
   *   height = rectangle height
   */
  void renderFrame(StyleContext context, double x, double y, double width, double height)
  {
    gtk_snapshot_render_frame(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(No.Dup) : null, x, y, width, height);
  }

  /**
   * Draws a text caret using snapshot at the specified index of layout.
   * Params:
   *   context = a `GtkStyleContext`
   *   x = X origin
   *   y = Y origin
   *   layout = the `PangoLayout` of the text
   *   index = the index in the `PangoLayout`
   *   direction = the `PangoDirection` of the text
   */
  void renderInsertionCursor(StyleContext context, double x, double y, Layout layout, int index, Direction direction)
  {
    gtk_snapshot_render_insertion_cursor(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(No.Dup) : null, x, y, layout ? cast(PangoLayout*)layout.cPtr(No.Dup) : null, index, direction);
  }

  /**
   * Creates a render node for rendering layout according to the style
   * information in context, and appends it to the current node of snapshot,
   * without changing the current node.
   * Params:
   *   context = the style context that defines the text
   *   x = X origin of the rectangle
   *   y = Y origin of the rectangle
   *   layout = the `PangoLayout` to render
   */
  void renderLayout(StyleContext context, double x, double y, Layout layout)
  {
    gtk_snapshot_render_layout(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(No.Dup) : null, x, y, layout ? cast(PangoLayout*)layout.cPtr(No.Dup) : null);
  }

  /**
   * Restores snapshot to the state saved by a preceding call to
   * [gtk.snapshot.Snapshot.save] and removes that state from the stack of
   * saved states.
   */
  void restore()
  {
    gtk_snapshot_restore(cast(GtkSnapshot*)cPtr);
  }

  /**
   * Rotates @snapshot's coordinate system by angle degrees in 2D space -
   * or in 3D speak, rotates around the Z axis. The rotation happens around
   * the origin point of $(LPAREN)0, 0$(RPAREN) in the snapshot's current coordinate system.
   * To rotate around axes other than the Z axis, use [gsk.transform.Transform.rotate3d].
   * Params:
   *   angle = the rotation angle, in degrees $(LPAREN)clockwise$(RPAREN)
   */
  void rotate(float angle)
  {
    gtk_snapshot_rotate(cast(GtkSnapshot*)cPtr, angle);
  }

  /**
   * Rotates snapshot's coordinate system by angle degrees around axis.
   * For a rotation in 2D space, use [gsk.transform.Transform.rotate].
   * Params:
   *   angle = the rotation angle, in degrees $(LPAREN)clockwise$(RPAREN)
   *   axis = The rotation axis
   */
  void rotate3d(float angle, Vec3 axis)
  {
    gtk_snapshot_rotate_3d(cast(GtkSnapshot*)cPtr, angle, axis ? cast(graphene_vec3_t*)axis.cPtr(No.Dup) : null);
  }

  /**
   * Makes a copy of the current state of snapshot and saves it
   * on an internal stack.
   * When [gtk.snapshot.Snapshot.restore] is called, snapshot will
   * be restored to the saved state.
   * Multiple calls to [gtk.snapshot.Snapshot.save] and [gtk.snapshot.Snapshot.restore]
   * can be nested; each call to `[gtk.snapshot.Snapshot.restore]` restores the state from
   * the matching paired `[gtk.snapshot.Snapshot.save]`.
   * It is necessary to clear all saved states with corresponding
   * calls to `[gtk.snapshot.Snapshot.restore]`.
   */
  void save()
  {
    gtk_snapshot_save(cast(GtkSnapshot*)cPtr);
  }

  /**
   * Scales snapshot's coordinate system in 2-dimensional space by
   * the given factors.
   * Use [gtk.snapshot.Snapshot.scale3d] to scale in all 3 dimensions.
   * Params:
   *   factorX = scaling factor on the X axis
   *   factorY = scaling factor on the Y axis
   */
  void scale(float factorX, float factorY)
  {
    gtk_snapshot_scale(cast(GtkSnapshot*)cPtr, factorX, factorY);
  }

  /**
   * Scales snapshot's coordinate system by the given factors.
   * Params:
   *   factorX = scaling factor on the X axis
   *   factorY = scaling factor on the Y axis
   *   factorZ = scaling factor on the Z axis
   */
  void scale3d(float factorX, float factorY, float factorZ)
  {
    gtk_snapshot_scale_3d(cast(GtkSnapshot*)cPtr, factorX, factorY, factorZ);
  }

  /**
   * Returns the render node that was constructed
   * by snapshot.
   * Note that this function may return %NULL if nothing has been
   * added to the snapshot or if its content does not produce pixels
   * to be rendered.
   * After calling this function, it is no longer possible to
   * add more nodes to snapshot. The only function that should
   * be called after this is [gobject.object.ObjectG.unref].
   * Returns: the constructed `GskRenderNode` or
   *   %NULL if there are no nodes to render.
   */
  RenderNode toNode()
  {
    GskRenderNode* _cretval;
    _cretval = gtk_snapshot_to_node(cast(GtkSnapshot*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Returns a paintable encapsulating the render node
   * that was constructed by snapshot.
   * After calling this function, it is no longer possible to
   * add more nodes to snapshot. The only function that should
   * be called after this is [gobject.object.ObjectG.unref].
   * Params:
   *   size = The size of the resulting paintable
   *     or %NULL to use the bounds of the snapshot
   * Returns: a new `GdkPaintable`
   */
  Paintable toPaintable(Size size)
  {
    GdkPaintable* _cretval;
    _cretval = gtk_snapshot_to_paintable(cast(GtkSnapshot*)cPtr, size ? cast(graphene_size_t*)size.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!Paintable(cast(GdkPaintable*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Transforms snapshot's coordinate system with the given transform.
   * Params:
   *   transform = the transform to apply
   */
  void transform(Transform transform)
  {
    gtk_snapshot_transform(cast(GtkSnapshot*)cPtr, transform ? cast(GskTransform*)transform.cPtr(No.Dup) : null);
  }

  /**
   * Transforms snapshot's coordinate system with the given matrix.
   * Params:
   *   matrix = the matrix to multiply the transform with
   */
  void transformMatrix(Matrix matrix)
  {
    gtk_snapshot_transform_matrix(cast(GtkSnapshot*)cPtr, matrix ? cast(graphene_matrix_t*)matrix.cPtr(No.Dup) : null);
  }

  /**
   * Translates snapshot's coordinate system by point in 2-dimensional space.
   * Params:
   *   point = the point to translate the snapshot by
   */
  void translate(Point point)
  {
    gtk_snapshot_translate(cast(GtkSnapshot*)cPtr, point ? cast(graphene_point_t*)point.cPtr(No.Dup) : null);
  }

  /**
   * Translates snapshot's coordinate system by point.
   * Params:
   *   point = the point to translate the snapshot by
   */
  void translate3d(Point3D point)
  {
    gtk_snapshot_translate_3d(cast(GtkSnapshot*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(No.Dup) : null);
  }
}
