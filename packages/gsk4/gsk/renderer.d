module gsk.renderer;

import cairo.region;
import gdk.display;
import gdk.surface;
import gdk.texture;
import gid.global;
import glib.error;
import gobject.object;
import graphene.rect;
import gsk.c.functions;
import gsk.c.types;
import gsk.render_node;
import gsk.types;

/**
 * `GskRenderer` is a class that renders a scene graph defined via a
 * tree of [gsk.render_node.RenderNode] instances.
 * Typically you will use a `GskRenderer` instance to repeatedly call
 * [gsk.renderer.Renderer.render] to update the contents of its associated
 * [gdk.surface.Surface].
 * It is necessary to realize a `GskRenderer` instance using
 * [gsk.renderer.Renderer.realize] before calling [gsk.renderer.Renderer.render],
 * in order to create the appropriate windowing system resources needed
 * to render the scene.
 */
class Renderer : ObjectG
{

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    super(cast(void*)ptr, take);
  }

  static GType getType()
  {
    import gid.loader : gidSymbolNotFound;
    return cast(void function())gsk_renderer_get_type != &gidSymbolNotFound ? gsk_renderer_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates an appropriate `GskRenderer` instance for the given surface.
   * If the `GSK_RENDERER` environment variable is set, GSK will
   * try that renderer first, before trying the backend-specific
   * default. The ultimate fallback is the cairo renderer.
   * The renderer will be realized before it is returned.
   * Params:
   *   surface = a `GdkSurface`
   * Returns: a `GskRenderer`
   */
  static Renderer newForSurface(Surface surface)
  {
    GskRenderer* _cretval;
    _cretval = gsk_renderer_new_for_surface(surface ? cast(GdkSurface*)surface.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!Renderer(cast(GskRenderer*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Retrieves the `GdkSurface` set using gsk_enderer_realize$(LPAREN)$(RPAREN).
   * If the renderer has not been realized yet, %NULL will be returned.
   * Returns: a `GdkSurface`
   */
  Surface getSurface()
  {
    GdkSurface* _cretval;
    _cretval = gsk_renderer_get_surface(cast(GskRenderer*)cPtr);
    auto _retval = ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, No.Take);
    return _retval;
  }

  /**
   * Checks whether the renderer is realized or not.
   * Returns: %TRUE if the `GskRenderer` was realized, and %FALSE otherwise
   */
  bool isRealized()
  {
    bool _retval;
    _retval = gsk_renderer_is_realized(cast(GskRenderer*)cPtr);
    return _retval;
  }

  /**
   * Creates the resources needed by the renderer to render the scene
   * graph.
   * Since GTK 4.6, the surface may be `NULL`, which allows using
   * renderers without having to create a surface.
   * Since GTK 4.14, it is recommended to use [gsk.renderer.Renderer.realizeForDisplay]
   * instead.
   * Note that it is mandatory to call [gsk.renderer.Renderer.unrealize] before
   * destroying the renderer.
   * Params:
   *   surface = the `GdkSurface` renderer will be used on
   * Returns: Whether the renderer was successfully realized
   */
  bool realize(Surface surface)
  {
    bool _retval;
    GError *_err;
    _retval = gsk_renderer_realize(cast(GskRenderer*)cPtr, surface ? cast(GdkSurface*)surface.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Creates the resources needed by the renderer to render the scene
   * graph.
   * Note that it is mandatory to call [gsk.renderer.Renderer.unrealize] before
   * destroying the renderer.
   * Params:
   *   display = the `GdkDisplay` renderer will be used on
   * Returns: Whether the renderer was successfully realized
   */
  bool realizeForDisplay(Display display)
  {
    bool _retval;
    GError *_err;
    _retval = gsk_renderer_realize_for_display(cast(GskRenderer*)cPtr, display ? cast(GdkDisplay*)display.cPtr(No.Dup) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Renders the scene graph, described by a tree of `GskRenderNode` instances
   * to the renderer's surface,  ensuring that the given region gets redrawn.
   * If the renderer has no associated surface, this function does nothing.
   * Renderers must ensure that changes of the contents given by the root
   * node as well as the area given by region are redrawn. They are however
   * free to not redraw any pixel outside of region if they can guarantee that
   * it didn't change.
   * The renderer will acquire a reference on the `GskRenderNode` tree while
   * the rendering is in progress.
   * Params:
   *   root = a `GskRenderNode`
   *   region = the `cairo_region_t` that must be redrawn or %NULL
   *     for the whole window
   */
  void render(RenderNode root, Region region)
  {
    gsk_renderer_render(cast(GskRenderer*)cPtr, root ? cast(GskRenderNode*)root.cPtr(No.Dup) : null, region ? cast(cairo_region_t*)region.cPtr(No.Dup) : null);
  }

  /**
   * Renders the scene graph, described by a tree of `GskRenderNode` instances,
   * to a `GdkTexture`.
   * The renderer will acquire a reference on the `GskRenderNode` tree while
   * the rendering is in progress.
   * If you want to apply any transformations to root, you should put it into a
   * transform node and pass that node instead.
   * Params:
   *   root = a `GskRenderNode`
   *   viewport = the section to draw or %NULL to use root's bounds
   * Returns: a `GdkTexture` with the rendered contents of root.
   */
  Texture renderTexture(RenderNode root, Rect viewport)
  {
    GdkTexture* _cretval;
    _cretval = gsk_renderer_render_texture(cast(GskRenderer*)cPtr, root ? cast(GskRenderNode*)root.cPtr(No.Dup) : null, viewport ? cast(graphene_rect_t*)viewport.cPtr(No.Dup) : null);
    auto _retval = ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, Yes.Take);
    return _retval;
  }

  /**
   * Releases all the resources created by [gsk.renderer.Renderer.realize].
   */
  void unrealize()
  {
    gsk_renderer_unrealize(cast(GskRenderer*)cPtr);
  }
}
