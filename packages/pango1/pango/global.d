module pango.global;

import gid.global;
import glib.error;
import glib.markup_parse_context;
import glib.string_;
import gobject.types;
import pango.analysis;
import pango.attr_iterator;
import pango.attr_list;
import pango.attribute;
import pango.c.functions;
import pango.c.types;
import pango.context;
import pango.glyph_string;
import pango.item;
import pango.language;
import pango.types;


/**
 * Create a new allow-breaks attribute.
 * If breaks are disabled, the range will be kept in a
 * single run, as far as possible.
 * Params:
 *   allowBreaks = %TRUE if we line breaks are allowed
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrAllowBreaksNew(bool allowBreaks)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_allow_breaks_new(allowBreaks);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new background alpha attribute.
 * Params:
 *   alpha = the alpha value, between 1 and 65536
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrBackgroundAlphaNew(ushort alpha)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_background_alpha_new(alpha);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new background color attribute.
 * Params:
 *   red = the red value $(LPAREN)ranging from 0 to 65535$(RPAREN)
 *   green = the green value
 *   blue = the blue value
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrBackgroundNew(ushort red, ushort green, ushort blue)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_background_new(red, green, blue);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new baseline displacement attribute.
 * The effect of this attribute is to shift the baseline of a run,
 * relative to the run of preceding run.
 * <picture>
 * <source srcset\="baseline-shift-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
 * <img alt\="Baseline Shift" src\="baseline-shift-light.png">
 * </picture>
 * Params:
 *   shift = either a `PangoBaselineShift` enumeration value or an absolute value $(LPAREN)> 1024$(RPAREN)
 *     in Pango units, relative to the baseline of the previous run.
 *     Positive values displace the text upwards.
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrBaselineShiftNew(int shift)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_baseline_shift_new(shift);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Apply customization from attributes to the breaks in attrs.
 * The line breaks are assumed to have been produced
 * by funcPango.default_break and funcPango.tailor_break.
 * Params:
 *   text = text to break. Must be valid UTF-8
 *   attrList = `PangoAttrList` to apply
 *   offset = Byte offset of text from the beginning of the paragraph
 *   attrs = array with one `PangoLogAttr`
 *     per character in text, plus one extra, to be filled in
 */
void attrBreak(string text, AttrList attrList, int offset, LogAttr[] attrs)
{
  int _length;
  if (text)
    _length = cast(int)text.length;

  auto _text = cast(const(char)*)text.ptr;
  int _attrsLen;
  if (attrs)
    _attrsLen = cast(int)attrs.length;

  auto _attrs = cast(PangoLogAttr*)attrs.ptr;
  pango_attr_break(_text, _length, attrList ? cast(PangoAttrList*)attrList.cPtr(No.Dup) : null, offset, _attrs, _attrsLen);
}

/**
 * Create a new font fallback attribute.
 * If fallback is disabled, characters will only be
 * used from the closest matching font on the system.
 * No fallback will be done to other fonts on the system
 * that might contain the characters in the text.
 * Params:
 *   enableFallback = %TRUE if we should fall back on other fonts
 *     for characters the active font is missing
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrFallbackNew(bool enableFallback)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_fallback_new(enableFallback);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new font family attribute.
 * Params:
 *   family = the family or comma-separated list of families
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrFamilyNew(string family)
{
  PangoAttribute* _cretval;
  const(char)* _family = family.toCString(No.Alloc);
  _cretval = pango_attr_family_new(_family);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new font scale attribute.
 * The effect of this attribute is to change the font size of a run,
 * relative to the size of preceding run.
 * Params:
 *   scale = a `PangoFontScale` value, which indicates font size change relative
 *     to the size of the previous run.
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrFontScaleNew(FontScale scale)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_font_scale_new(scale);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new foreground alpha attribute.
 * Params:
 *   alpha = the alpha value, between 1 and 65536
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrForegroundAlphaNew(ushort alpha)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_foreground_alpha_new(alpha);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new foreground color attribute.
 * Params:
 *   red = the red value $(LPAREN)ranging from 0 to 65535$(RPAREN)
 *   green = the green value
 *   blue = the blue value
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrForegroundNew(ushort red, ushort green, ushort blue)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_foreground_new(red, green, blue);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new gravity hint attribute.
 * Params:
 *   hint = the gravity hint value
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrGravityHintNew(GravityHint hint)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_gravity_hint_new(hint);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new gravity attribute.
 * Params:
 *   gravity = the gravity value; should not be %PANGO_GRAVITY_AUTO
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrGravityNew(Gravity gravity)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_gravity_new(gravity);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new insert-hyphens attribute.
 * Pango will insert hyphens when breaking lines in
 * the middle of a word. This attribute can be used
 * to suppress the hyphen.
 * Params:
 *   insertHyphens = %TRUE if hyphens should be inserted
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrInsertHyphensNew(bool insertHyphens)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_insert_hyphens_new(insertHyphens);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new letter-spacing attribute.
 * Params:
 *   letterSpacing = amount of extra space to add between
 *     graphemes of the text, in Pango units
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrLetterSpacingNew(int letterSpacing)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_letter_spacing_new(letterSpacing);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Modify the height of logical line extents by a factor.
 * This affects the values returned by
 * [pango.layout_line.LayoutLine.getExtents],
 * [pango.layout_line.LayoutLine.getPixelExtents] and
 * [pango.layout_iter.LayoutIter.getLineExtents].
 * Params:
 *   factor = the scaling factor to apply to the logical height
 * Returns:
 */
Attribute attrLineHeightNew(double factor)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_line_height_new(factor);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Override the height of logical line extents to be height.
 * This affects the values returned by
 * [pango.layout_line.LayoutLine.getExtents],
 * [pango.layout_line.LayoutLine.getPixelExtents] and
 * [pango.layout_iter.LayoutIter.getLineExtents].
 * Params:
 *   height = the line height, in %PANGO_SCALE-ths of a point
 * Returns:
 */
Attribute attrLineHeightNewAbsolute(int height)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_line_height_new_absolute(height);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new overline color attribute.
 * This attribute modifies the color of overlines.
 * If not set, overlines will use the foreground color.
 * Params:
 *   red = the red value $(LPAREN)ranging from 0 to 65535$(RPAREN)
 *   green = the green value
 *   blue = the blue value
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrOverlineColorNew(ushort red, ushort green, ushort blue)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_overline_color_new(red, green, blue);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new overline-style attribute.
 * Params:
 *   overline = the overline style
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrOverlineNew(Overline overline)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_overline_new(overline);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new baseline displacement attribute.
 * Params:
 *   rise = the amount that the text should be displaced vertically,
 *     in Pango units. Positive values displace the text upwards.
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrRiseNew(int rise)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_rise_new(rise);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new font size scale attribute.
 * The base font for the affected text will have
 * its size multiplied by scale_factor.
 * Params:
 *   scaleFactor = factor to scale the font
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrScaleNew(double scaleFactor)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_scale_new(scaleFactor);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Marks the range of the attribute as a single sentence.
 * Note that this may require adjustments to word and
 * sentence classification around the range.
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrSentenceNew()
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_sentence_new();
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new attribute that influences how invisible
 * characters are rendered.
 * Params:
 *   flags = `PangoShowFlags` to apply
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrShowNew(ShowFlags flags)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_show_new(flags);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new font stretch attribute.
 * Params:
 *   stretch = the stretch
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrStretchNew(Stretch stretch)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_stretch_new(stretch);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new strikethrough color attribute.
 * This attribute modifies the color of strikethrough lines.
 * If not set, strikethrough lines will use the foreground color.
 * Params:
 *   red = the red value $(LPAREN)ranging from 0 to 65535$(RPAREN)
 *   green = the green value
 *   blue = the blue value
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrStrikethroughColorNew(ushort red, ushort green, ushort blue)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_strikethrough_color_new(red, green, blue);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new strike-through attribute.
 * Params:
 *   strikethrough = %TRUE if the text should be struck-through
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrStrikethroughNew(bool strikethrough)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_strikethrough_new(strikethrough);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new font slant style attribute.
 * Params:
 *   style = the slant style
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrStyleNew(Style style)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_style_new(style);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new attribute that influences how characters
 * are transformed during shaping.
 * Params:
 *   transform = `PangoTextTransform` to apply
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrTextTransformNew(TextTransform transform)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_text_transform_new(transform);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new underline color attribute.
 * This attribute modifies the color of underlines.
 * If not set, underlines will use the foreground color.
 * Params:
 *   red = the red value $(LPAREN)ranging from 0 to 65535$(RPAREN)
 *   green = the green value
 *   blue = the blue value
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrUnderlineColorNew(ushort red, ushort green, ushort blue)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_underline_color_new(red, green, blue);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new underline-style attribute.
 * Params:
 *   underline = the underline style
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrUnderlineNew(Underline underline)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_underline_new(underline);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new font variant attribute $(LPAREN)normal or small caps$(RPAREN).
 * Params:
 *   variant = the variant
 * Returns: the newly allocated `PangoAttribute`,
 *   which should be freed with [pango.attribute.Attribute.destroy].
 */
Attribute attrVariantNew(Variant variant)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_variant_new(variant);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Create a new font weight attribute.
 * Params:
 *   weight = the weight
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrWeightNew(Weight weight)
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_weight_new(weight);
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Marks the range of the attribute as a single word.
 * Note that this may require adjustments to word and
 * sentence classification around the range.
 * Returns: the newly allocated
 *   `PangoAttribute`, which should be freed with
 *   [pango.attribute.Attribute.destroy]
 */
Attribute attrWordNew()
{
  PangoAttribute* _cretval;
  _cretval = pango_attr_word_new();
  auto _retval = _cretval ? new Attribute(cast(void*)_cretval, Yes.Take) : null;
  return _retval;
}

/**
 * Determines possible line, word, and character breaks
 * for a string of Unicode text with a single analysis.
 * For most purposes you may want to use funcPango.get_log_attrs.
 * Params:
 *   text = the text to process. Must be valid UTF-8
 *   analysis = `PangoAnalysis` structure for text
 *   attrs = an array to store character information in

 * Deprecated: Use funcPango.default_break,
 *   funcPango.tailor_break and funcPango.attr_break.
 */
void break_(string text, Analysis analysis, LogAttr[] attrs)
{
  int _length;
  if (text)
    _length = cast(int)text.length;

  auto _text = cast(const(char)*)text.ptr;
  int _attrsLen;
  if (attrs)
    _attrsLen = cast(int)attrs.length;

  auto _attrs = cast(PangoLogAttr*)attrs.ptr;
  pango_break(_text, _length, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, _attrs, _attrsLen);
}

/**
 * This is the default break algorithm.
 * It applies rules from the [Unicode Line Breaking Algorithm](http://www.unicode.org/unicode/reports/tr14/)
 * without language-specific tailoring, therefore the analyis argument is unused
 * and can be %NULL.
 * See funcPango.tailor_break for language-specific breaks.
 * See funcPango.attr_break for attribute-based customization.
 * Params:
 *   text = text to break. Must be valid UTF-8
 *   analysis = a `PangoAnalysis` structure for the text
 *   attrs = logical attributes to fill in
 *   attrsLen = size of the array passed as attrs
 */
void defaultBreak(string text, Analysis analysis, LogAttr attrs, int attrsLen)
{
  int _length;
  if (text)
    _length = cast(int)text.length;

  auto _text = cast(const(char)*)text.ptr;
  pango_default_break(_text, _length, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, &attrs, attrsLen);
}

/**
 * Converts extents from Pango units to device units.
 * The conversion is done by dividing by the %PANGO_SCALE factor and
 * performing rounding.
 * The inclusive rectangle is converted by flooring the x/y coordinates
 * and extending width/height, such that the final rectangle completely
 * includes the original rectangle.
 * The nearest rectangle is converted by rounding the coordinates
 * of the rectangle to the nearest device unit $(LPAREN)pixel$(RPAREN).
 * The rule to which argument to use is: if you want the resulting device-space
 * rectangle to completely contain the original rectangle, pass it in as
 * inclusive. If you want two touching-but-not-overlapping rectangles stay
 * touching-but-not-overlapping after rounding to device units, pass them in
 * as nearest.
 * Params:
 *   inclusive = rectangle to round to pixels inclusively
 *   nearest = rectangle to round to nearest pixels
 */
void extentsToPixels(Rectangle inclusive, Rectangle nearest)
{
  pango_extents_to_pixels(&inclusive, &nearest);
}

/**
 * Searches a string the first character that has a strong
 * direction, according to the Unicode bidirectional algorithm.
 * Params:
 *   text = the text to process. Must be valid UTF-8
 * Returns: The direction corresponding to the first strong character.
 *   If no such character is found, then %PANGO_DIRECTION_NEUTRAL is returned.
 */
Direction findBaseDir(string text)
{
  PangoDirection _cretval;
  int _length;
  if (text)
    _length = cast(int)text.length;

  auto _text = cast(const(char)*)text.ptr;
  _cretval = pango_find_base_dir(_text, _length);
  Direction _retval = cast(Direction)_cretval;
  return _retval;
}

/**
 * Locates a paragraph boundary in text.
 * A boundary is caused by delimiter characters, such as
 * a newline, carriage return, carriage return-newline pair,
 * or Unicode paragraph separator character.
 * The index of the run of delimiters is returned in
 * paragraph_delimiter_index. The index of the start of the
 * next paragraph $(LPAREN)index after all delimiters$(RPAREN) is stored n
 * next_paragraph_start.
 * If no delimiters are found, both paragraph_delimiter_index
 * and next_paragraph_start are filled with the length of text
 * $(LPAREN)an index one off the end$(RPAREN).
 * Params:
 *   text = UTF-8 text
 *   paragraphDelimiterIndex = return location for index of
 *     delimiter
 *   nextParagraphStart = return location for start of next
 *     paragraph
 */
void findParagraphBoundary(string text, out int paragraphDelimiterIndex, out int nextParagraphStart)
{
  int _length;
  if (text)
    _length = cast(int)text.length;

  auto _text = cast(const(char)*)text.ptr;
  pango_find_paragraph_boundary(_text, _length, cast(int*)&paragraphDelimiterIndex, cast(int*)&nextParagraphStart);
}

/**
 * Computes a `PangoLogAttr` for each character in text.
 * The attrs array must have one `PangoLogAttr` for
 * each position in text; if text contains N characters,
 * it has N+1 positions, including the last position at the
 * end of the text. text should be an entire paragraph;
 * logical attributes can't be computed without context
 * $(LPAREN)for example you need to see spaces on either side of
 * a word to know the word is a word$(RPAREN).
 * Params:
 *   text = text to process. Must be valid UTF-8
 *   level = embedding level, or -1 if unknown
 *   language = language tag
 *   attrs = array with one `PangoLogAttr`
 *     per character in text, plus one extra, to be filled in
 */
void getLogAttrs(string text, int level, PgLanguage language, LogAttr[] attrs)
{
  int _length;
  if (text)
    _length = cast(int)text.length;

  auto _text = cast(const(char)*)text.ptr;
  int _attrsLen;
  if (attrs)
    _attrsLen = cast(int)attrs.length;

  auto _attrs = cast(PangoLogAttr*)attrs.ptr;
  pango_get_log_attrs(_text, _length, level, language ? cast(PangoLanguage*)language.cPtr(No.Dup) : null, _attrs, _attrsLen);
}

/**
 * Checks if a character that should not be normally rendered.
 * This includes all Unicode characters with "ZERO WIDTH" in their name,
 * as well as *bidi* formatting characters, and a few other ones.
 * This is totally different from funcGLib.unichar_iszerowidth and is at best misnamed.
 * Params:
 *   ch = a Unicode character
 * Returns: %TRUE if ch is a zero-width character, %FALSE otherwise
 */
bool isZeroWidth(dchar ch)
{
  bool _retval;
  _retval = pango_is_zero_width(ch);
  return _retval;
}

/**
 * Breaks a piece of text into segments with consistent directional
 * level and font.
 * Each byte of text will be contained in exactly one of the items in the
 * returned list; the generated list of items will be in logical order $(LPAREN)the
 * start offsets of the items are ascending$(RPAREN).
 * cached_iter should be an iterator over attrs currently positioned
 * at a range before or containing start_index; cached_iter will be
 * advanced to the range covering the position just after
 * start_index + length. $(LPAREN)i.e. if itemizing in a loop, just keep passing
 * in the same cached_iter$(RPAREN).
 * Params:
 *   context = a structure holding information that affects
 *     the itemization process.
 *   text = the text to itemize. Must be valid UTF-8
 *   startIndex = first byte in text to process
 *   length = the number of bytes $(LPAREN)not characters$(RPAREN) to process
 *     after start_index. This must be >\= 0.
 *   attrs = the set of attributes that apply to text.
 *   cachedIter = Cached attribute iterator
 * Returns: a `GList` of
 *   [pango.item.Item] structures. The items should be freed using
 *   [pango.item.Item.free] in combination with [glib.list.List.freeFull].
 */
Item[] itemize(Context context, string text, int startIndex, int length, AttrList attrs, AttrIterator cachedIter)
{
  GList* _cretval;
  const(char)* _text = text.toCString(No.Alloc);
  _cretval = pango_itemize(context ? cast(PangoContext*)context.cPtr(No.Dup) : null, _text, startIndex, length, attrs ? cast(PangoAttrList*)attrs.cPtr(No.Dup) : null, cachedIter ? cast(PangoAttrIterator*)cachedIter.cPtr(No.Dup) : null);
  auto _retval = gListToD!(Item, GidOwnership.Full)(cast(GList*)_cretval);
  return _retval;
}

/**
 * Like `[pango.global.itemize]`, but with an explicitly specified base direction.
 * The base direction is used when computing bidirectional levels.
 * funcitemize gets the base direction from the `PangoContext`
 * $(LPAREN)see [pango.context.Context.setBaseDir]$(RPAREN).
 * Params:
 *   context = a structure holding information that affects
 *     the itemization process.
 *   baseDir = base direction to use for bidirectional processing
 *   text = the text to itemize.
 *   startIndex = first byte in text to process
 *   length = the number of bytes $(LPAREN)not characters$(RPAREN) to process
 *     after start_index. This must be >\= 0.
 *   attrs = the set of attributes that apply to text.
 *   cachedIter = Cached attribute iterator
 * Returns: a `GList` of
 *   [pango.item.Item] structures. The items should be freed using
 *   [pango.item.Item.free] probably in combination with [glib.list.List.freeFull].
 */
Item[] itemizeWithBaseDir(Context context, Direction baseDir, string text, int startIndex, int length, AttrList attrs, AttrIterator cachedIter)
{
  GList* _cretval;
  const(char)* _text = text.toCString(No.Alloc);
  _cretval = pango_itemize_with_base_dir(context ? cast(PangoContext*)context.cPtr(No.Dup) : null, baseDir, _text, startIndex, length, attrs ? cast(PangoAttrList*)attrs.cPtr(No.Dup) : null, cachedIter ? cast(PangoAttrIterator*)cachedIter.cPtr(No.Dup) : null);
  auto _retval = gListToD!(Item, GidOwnership.Full)(cast(GList*)_cretval);
  return _retval;
}

/**
 * Finishes parsing markup.
 * After feeding a Pango markup parser some data with [glib.markup_parse_context.MarkupParseContext.parse],
 * use this function to get the list of attributes and text out of the
 * markup. This function will not free context, use [glib.markup_parse_context.MarkupParseContext.free]
 * to do so.
 * Params:
 *   context = A valid parse context that was returned from funcmarkup_parser_new
 *   attrList = address of return location for a `PangoAttrList`
 *   text = address of return location for text with tags stripped
 *   accelChar = address of return location for accelerator char
 * Returns: %FALSE if error is set, otherwise %TRUE
 */
bool markupParserFinish(MarkupParseContext context, out AttrList attrList, out string text, out dchar accelChar)
{
  bool _retval;
  PangoAttrList* _attrList;
  char* _text;
  GError *_err;
  _retval = pango_markup_parser_finish(context ? cast(GMarkupParseContext*)context.cPtr(No.Dup) : null, &_attrList, &_text, cast(dchar*)&accelChar, &_err);
  if (_err)
    throw new ErrorG(_err);
  attrList = new AttrList(cast(void*)_attrList, Yes.Take);
  text = _text.fromCString(Yes.Free);
  return _retval;
}

/**
 * Incrementally parses marked-up text to create a plain-text string
 * and an attribute list.
 * See the [Pango Markup](pango_markup.html) docs for details about the
 * supported markup.
 * If accel_marker is nonzero, the given character will mark the
 * character following it as an accelerator. For example, accel_marker
 * might be an ampersand or underscore. All characters marked
 * as an accelerator will receive a %PANGO_UNDERLINE_LOW attribute,
 * and the first character so marked will be returned in accel_char,
 * when calling funcmarkup_parser_finish. Two accel_marker characters
 * following each other produce a single literal accel_marker character.
 * To feed markup to the parser, use [glib.markup_parse_context.MarkupParseContext.parse]
 * on the returned [glib.markup_parse_context.MarkupParseContext]. When done with feeding markup
 * to the parser, use funcmarkup_parser_finish to get the data out
 * of it, and then use [glib.markup_parse_context.MarkupParseContext.free] to free it.
 * This function is designed for applications that read Pango markup
 * from streams. To simply parse a string containing Pango markup,
 * the funcPango.parse_markup API is recommended instead.
 * Params:
 *   accelMarker = character that precedes an accelerator, or 0 for none
 * Returns: a `GMarkupParseContext` that should be
 *   destroyed with [glib.markup_parse_context.MarkupParseContext.free].
 */
MarkupParseContext markupParserNew(dchar accelMarker)
{
  GMarkupParseContext* _cretval;
  _cretval = pango_markup_parser_new(accelMarker);
  auto _retval = _cretval ? new MarkupParseContext(cast(void*)_cretval, No.Take) : null;
  return _retval;
}

/**
 * Parses an enum type and stores the result in value.
 * If str does not match the nick name of any of the possible values
 * for the enum and is not an integer, %FALSE is returned, a warning
 * is issued if warn is %TRUE, and a string representing the list of
 * possible values is stored in possible_values. The list is
 * slash-separated, eg. "none/start/middle/end".
 * If failed and possible_values is not %NULL, returned string should
 * be freed using [glib.global.gfree].
 * Params:
 *   type = enum type to parse, eg. %PANGO_TYPE_ELLIPSIZE_MODE
 *   str = string to parse
 *   value = integer to store the result in
 *   warn = if %TRUE, issue a g_warning$(LPAREN)$(RPAREN) on bad input
 *   possibleValues = place to store list of possible
 *     values on failure
 * Returns: %TRUE if str was successfully parsed
 */
bool parseEnum(GType type, string str, out int value, bool warn, out string possibleValues)
{
  bool _retval;
  const(char)* _str = str.toCString(No.Alloc);
  char* _possibleValues;
  _retval = pango_parse_enum(type, _str, cast(int*)&value, warn, &_possibleValues);
  possibleValues = _possibleValues.fromCString(Yes.Free);
  return _retval;
}

/**
 * Parses marked-up text to create a plain-text string and an attribute list.
 * See the [Pango Markup](pango_markup.html) docs for details about the
 * supported markup.
 * If accel_marker is nonzero, the given character will mark the
 * character following it as an accelerator. For example, accel_marker
 * might be an ampersand or underscore. All characters marked
 * as an accelerator will receive a %PANGO_UNDERLINE_LOW attribute,
 * and the first character so marked will be returned in accel_char.
 * Two accel_marker characters following each other produce a single
 * literal accel_marker character.
 * To parse a stream of pango markup incrementally, use funcmarkup_parser_new.
 * If any error happens, none of the output arguments are touched except
 * for error.
 * Params:
 *   markupText = markup to parse $(LPAREN)see the [Pango Markup](pango_markup.html) docs$(RPAREN)
 *   accelMarker = character that precedes an accelerator, or 0 for none
 *   attrList = address of return location for a `PangoAttrList`
 *   text = address of return location for text with tags stripped
 *   accelChar = address of return location for accelerator char
 * Returns: %FALSE if error is set, otherwise %TRUE
 */
bool parseMarkup(string markupText, dchar accelMarker, out AttrList attrList, out string text, out dchar accelChar)
{
  bool _retval;
  int _length;
  if (markupText)
    _length = cast(int)markupText.length;

  auto _markupText = cast(const(char)*)markupText.ptr;
  PangoAttrList* _attrList;
  char* _text;
  GError *_err;
  _retval = pango_parse_markup(_markupText, _length, accelMarker, &_attrList, &_text, cast(dchar*)&accelChar, &_err);
  if (_err)
    throw new ErrorG(_err);
  attrList = new AttrList(cast(void*)_attrList, Yes.Take);
  text = _text.fromCString(Yes.Free);
  return _retval;
}

/**
 * Parses a font stretch.
 * The allowed values are
 * "ultra_condensed", "extra_condensed", "condensed",
 * "semi_condensed", "normal", "semi_expanded", "expanded",
 * "extra_expanded" and "ultra_expanded". Case variations are
 * ignored and the '_' characters may be omitted.
 * Params:
 *   str = a string to parse.
 *   stretch = a `PangoStretch` to store the result in.
 *   warn = if %TRUE, issue a g_warning$(LPAREN)$(RPAREN) on bad input.
 * Returns: %TRUE if str was successfully parsed.
 */
bool parseStretch(string str, out Stretch stretch, bool warn)
{
  bool _retval;
  const(char)* _str = str.toCString(No.Alloc);
  _retval = pango_parse_stretch(_str, &stretch, warn);
  return _retval;
}

/**
 * Parses a font style.
 * The allowed values are "normal", "italic" and "oblique", case
 * variations being
 * ignored.
 * Params:
 *   str = a string to parse.
 *   style = a `PangoStyle` to store the result in.
 *   warn = if %TRUE, issue a g_warning$(LPAREN)$(RPAREN) on bad input.
 * Returns: %TRUE if str was successfully parsed.
 */
bool parseStyle(string str, out Style style, bool warn)
{
  bool _retval;
  const(char)* _str = str.toCString(No.Alloc);
  _retval = pango_parse_style(_str, &style, warn);
  return _retval;
}

/**
 * Parses a font variant.
 * The allowed values are "normal", "small-caps", "all-small-caps",
 * "petite-caps", "all-petite-caps", "unicase" and "title-caps",
 * case variations being ignored.
 * Params:
 *   str = a string to parse.
 *   variant = a `PangoVariant` to store the result in.
 *   warn = if %TRUE, issue a g_warning$(LPAREN)$(RPAREN) on bad input.
 * Returns: %TRUE if str was successfully parsed.
 */
bool parseVariant(string str, out Variant variant, bool warn)
{
  bool _retval;
  const(char)* _str = str.toCString(No.Alloc);
  _retval = pango_parse_variant(_str, &variant, warn);
  return _retval;
}

/**
 * Parses a font weight.
 * The allowed values are "heavy",
 * "ultrabold", "bold", "normal", "light", "ultraleight"
 * and integers. Case variations are ignored.
 * Params:
 *   str = a string to parse.
 *   weight = a `PangoWeight` to store the result in.
 *   warn = if %TRUE, issue a g_warning$(LPAREN)$(RPAREN) on bad input.
 * Returns: %TRUE if str was successfully parsed.
 */
bool parseWeight(string str, out Weight weight, bool warn)
{
  bool _retval;
  const(char)* _str = str.toCString(No.Alloc);
  _retval = pango_parse_weight(_str, &weight, warn);
  return _retval;
}

/**
 * Quantizes the thickness and position of a line to whole device pixels.
 * This is typically used for underline or strikethrough. The purpose of
 * this function is to avoid such lines looking blurry.
 * Care is taken to make sure thickness is at least one pixel when this
 * function returns, but returned position may become zero as a result
 * of rounding.
 * Params:
 *   thickness = pointer to the thickness of a line, in Pango units
 *   position = corresponding position
 */
void quantizeLineGeometry(ref int thickness, ref int position)
{
  pango_quantize_line_geometry(cast(int*)&thickness, cast(int*)&position);
}

/**
 * Reads an entire line from a file into a buffer.
 * Lines may be delimited with '\n', '\r', '\n\r', or '\r\n'. The delimiter
 * is not written into the buffer. Text after a '#' character is treated as
 * a comment and skipped. '\' can be used to escape a # character.
 * '\' proceeding a line delimiter combines adjacent lines. A '\' proceeding
 * any other character is ignored and written into the output buffer
 * unmodified.
 * Params:
 *   stream = a stdio stream
 *   str = `GString` buffer into which to write the result
 * Returns: 0 if the stream was already at an %EOF character,
 *   otherwise the number of lines read $(LPAREN)this is useful for maintaining
 *   a line number counter which doesn't combine lines with '\'$(RPAREN)
 */
int readLine(void* stream, String str)
{
  int _retval;
  _retval = pango_read_line(stream, str ? cast(GString*)str.cPtr(No.Dup) : null);
  return _retval;
}

/**
 * Reorder items from logical order to visual order.
 * The visual order is determined from the associated directional
 * levels of the items. The original list is unmodified.
 * $(LPAREN)Please open a bug if you use this function.
 * It is not a particularly convenient interface, and the code
 * is duplicated elsewhere in Pango for that reason.$(RPAREN)
 * Params:
 *   items = a `GList` of `PangoItem`
 *     in logical order.
 * Returns: a `GList`
 *   of `PangoItem` structures in visual order.
 */
Item[] reorderItems(Item[] items)
{
  GList* _cretval;
  auto _items = gListFromD!(Item)(items);
  scope(exit) containerFree!(GList*, Item, GidOwnership.None)(_items);
  _cretval = pango_reorder_items(_items);
  auto _retval = gListToD!(Item, GidOwnership.Full)(cast(GList*)_cretval);
  return _retval;
}

/**
 * Convert the characters in text into glyphs.
 * Given a segment of text and the corresponding `PangoAnalysis` structure
 * returned from funcPango.itemize, convert the characters into glyphs. You
 * may also pass in only a substring of the item from funcPango.itemize.
 * It is recommended that you use funcPango.shape_full instead, since
 * that API allows for shaping interaction happening across text item
 * boundaries.
 * Some aspects of hyphen insertion and text transformation $(LPAREN)in particular,
 * capitalization$(RPAREN) require log attrs, and thus can only be handled by
 * funcPango.shape_item.
 * Note that the extra attributes in the analyis that is returned from
 * funcPango.itemize have indices that are relative to the entire paragraph,
 * so you need to subtract the item offset from their indices before
 * calling funcPango.shape.
 * Params:
 *   text = the text to process
 *   analysis = `PangoAnalysis` structure from funcPango.itemize
 *   glyphs = glyph string in which to store results
 */
void shape(string text, Analysis analysis, GlyphString glyphs)
{
  int _length;
  if (text)
    _length = cast(int)text.length;

  auto _text = cast(const(char)*)text.ptr;
  pango_shape(_text, _length, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, glyphs ? cast(PangoGlyphString*)glyphs.cPtr(No.Dup) : null);
}

/**
 * Convert the characters in text into glyphs.
 * Given a segment of text and the corresponding `PangoAnalysis` structure
 * returned from funcPango.itemize, convert the characters into glyphs.
 * You may also pass in only a substring of the item from funcPango.itemize.
 * This is similar to funcPango.shape, except it also can optionally take
 * the full paragraph text as input, which will then be used to perform
 * certain cross-item shaping interactions. If you have access to the broader
 * text of which item_text is part of, provide the broader text as
 * paragraph_text. If paragraph_text is %NULL, item text is used instead.
 * Some aspects of hyphen insertion and text transformation $(LPAREN)in particular,
 * capitalization$(RPAREN) require log attrs, and thus can only be handled by
 * funcPango.shape_item.
 * Note that the extra attributes in the analyis that is returned from
 * funcPango.itemize have indices that are relative to the entire paragraph,
 * so you do not pass the full paragraph text as paragraph_text, you need
 * to subtract the item offset from their indices before calling
 * funcPango.shape_full.
 * Params:
 *   itemText = valid UTF-8 text to shape.
 *   paragraphText = text of the paragraph $(LPAREN)see details$(RPAREN).
 *   analysis = `PangoAnalysis` structure from funcPango.itemize.
 *   glyphs = glyph string in which to store results.
 */
void shapeFull(string itemText, string paragraphText, Analysis analysis, GlyphString glyphs)
{
  int _itemLength;
  if (itemText)
    _itemLength = cast(int)itemText.length;

  auto _itemText = cast(const(char)*)itemText.ptr;
  int _paragraphLength;
  if (paragraphText)
    _paragraphLength = cast(int)paragraphText.length;

  auto _paragraphText = cast(const(char)*)paragraphText.ptr;
  pango_shape_full(_itemText, _itemLength, _paragraphText, _paragraphLength, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, glyphs ? cast(PangoGlyphString*)glyphs.cPtr(No.Dup) : null);
}

/**
 * Convert the characters in item into glyphs.
 * This is similar to funcPango.shape_with_flags, except it takes a
 * `PangoItem` instead of separate item_text and analysis arguments.
 * It also takes log_attrs, which are needed for implementing some aspects
 * of hyphen insertion and text transforms $(LPAREN)in particular, capitalization$(RPAREN).
 * Note that the extra attributes in the analyis that is returned from
 * funcPango.itemize have indices that are relative to the entire paragraph,
 * so you do not pass the full paragraph text as paragraph_text, you need
 * to subtract the item offset from their indices before calling
 * funcPango.shape_with_flags.
 * Params:
 *   item = `PangoItem` to shape
 *   paragraphText = text of the paragraph $(LPAREN)see details$(RPAREN).
 *   logAttrs = array of `PangoLogAttr` for item
 *   glyphs = glyph string in which to store results
 *   flags = flags influencing the shaping process
 */
void shapeItem(Item item, string paragraphText, LogAttr logAttrs, GlyphString glyphs, ShapeFlags flags)
{
  int _paragraphLength;
  if (paragraphText)
    _paragraphLength = cast(int)paragraphText.length;

  auto _paragraphText = cast(const(char)*)paragraphText.ptr;
  pango_shape_item(item ? cast(PangoItem*)item.cPtr(No.Dup) : null, _paragraphText, _paragraphLength, &logAttrs, glyphs ? cast(PangoGlyphString*)glyphs.cPtr(No.Dup) : null, flags);
}

/**
 * Convert the characters in text into glyphs.
 * Given a segment of text and the corresponding `PangoAnalysis` structure
 * returned from funcPango.itemize, convert the characters into glyphs.
 * You may also pass in only a substring of the item from funcPango.itemize.
 * This is similar to funcPango.shape_full, except it also takes flags
 * that can influence the shaping process.
 * Some aspects of hyphen insertion and text transformation $(LPAREN)in particular,
 * capitalization$(RPAREN) require log attrs, and thus can only be handled by
 * funcPango.shape_item.
 * Note that the extra attributes in the analyis that is returned from
 * funcPango.itemize have indices that are relative to the entire paragraph,
 * so you do not pass the full paragraph text as paragraph_text, you need
 * to subtract the item offset from their indices before calling
 * funcPango.shape_with_flags.
 * Params:
 *   itemText = valid UTF-8 text to shape
 *   paragraphText = text of the paragraph $(LPAREN)see details$(RPAREN).
 *   analysis = `PangoAnalysis` structure from funcPango.itemize
 *   glyphs = glyph string in which to store results
 *   flags = flags influencing the shaping process
 */
void shapeWithFlags(string itemText, string paragraphText, Analysis analysis, GlyphString glyphs, ShapeFlags flags)
{
  int _itemLength;
  if (itemText)
    _itemLength = cast(int)itemText.length;

  auto _itemText = cast(const(char)*)itemText.ptr;
  int _paragraphLength;
  if (paragraphText)
    _paragraphLength = cast(int)paragraphText.length;

  auto _paragraphText = cast(const(char)*)paragraphText.ptr;
  pango_shape_with_flags(_itemText, _itemLength, _paragraphText, _paragraphLength, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, glyphs ? cast(PangoGlyphString*)glyphs.cPtr(No.Dup) : null, flags);
}

/**
 * Splits a %G_SEARCHPATH_SEPARATOR-separated list of files, stripping
 * white space and substituting ~/ with \$HOME/.
 * Params:
 *   str = a %G_SEARCHPATH_SEPARATOR separated list of filenames
 * Returns: a list of
 *   strings to be freed with [glib.global.strfreev]
 */
string[] splitFileList(string str)
{
  char** _cretval;
  const(char)* _str = str.toCString(No.Alloc);
  _cretval = pango_split_file_list(_str);
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] !is null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(Yes.Free);
  }
  return _retval;
}

/**
 * Apply language-specific tailoring to the breaks in attrs.
 * The line breaks are assumed to have been produced by funcPango.default_break.
 * If offset is not -1, it is used to apply attributes from analysis that are
 * relevant to line breaking.
 * Note that it is better to pass -1 for offset and use funcPango.attr_break
 * to apply attributes to the whole paragraph.
 * Params:
 *   text = text to process. Must be valid UTF-8
 *   analysis = `PangoAnalysis` for text
 *   offset = Byte offset of text from the beginning of the
 *     paragraph, or -1 to ignore attributes from analysis
 *   attrs = array with one `PangoLogAttr`
 *     per character in text, plus one extra, to be filled in
 */
void tailorBreak(string text, Analysis analysis, int offset, LogAttr[] attrs)
{
  int _length;
  if (text)
    _length = cast(int)text.length;

  auto _text = cast(const(char)*)text.ptr;
  int _attrsLen;
  if (attrs)
    _attrsLen = cast(int)attrs.length;

  auto _attrs = cast(PangoLogAttr*)attrs.ptr;
  pango_tailor_break(_text, _length, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, offset, _attrs, _attrsLen);
}

/**
 * Trims leading and trailing whitespace from a string.
 * Params:
 *   str = a string
 * Returns: A newly-allocated string that must be freed with [glib.global.gfree]
 */
string trimString(string str)
{
  char* _cretval;
  const(char)* _str = str.toCString(No.Alloc);
  _cretval = pango_trim_string(_str);
  string _retval = _cretval.fromCString(Yes.Free);
  return _retval;
}

/**
 * Determines the inherent direction of a character.
 * The inherent direction is either `PANGO_DIRECTION_LTR`, `PANGO_DIRECTION_RTL`,
 * or `PANGO_DIRECTION_NEUTRAL`.
 * This function is useful to categorize characters into left-to-right
 * letters, right-to-left letters, and everything else. If full Unicode
 * bidirectional type of a character is needed, funcPango.BidiType.for_unichar
 * can be used instead.
 * Params:
 *   ch = a Unicode character
 * Returns: the direction of the character.
 */
Direction unicharDirection(dchar ch)
{
  PangoDirection _cretval;
  _cretval = pango_unichar_direction(ch);
  Direction _retval = cast(Direction)_cretval;
  return _retval;
}

/**
 * Converts a floating-point number to Pango units.
 * The conversion is done by multiplying d by %PANGO_SCALE and
 * rounding the result to nearest integer.
 * Params:
 *   d = double floating-point value
 * Returns: the value in Pango units.
 */
int unitsFromDouble(double d)
{
  int _retval;
  _retval = pango_units_from_double(d);
  return _retval;
}

/**
 * Converts a number in Pango units to floating-point.
 * The conversion is done by dividing i by %PANGO_SCALE.
 * Params:
 *   i = value in Pango units
 * Returns: the double value.
 */
double unitsToDouble(int i)
{
  double _retval;
  _retval = pango_units_to_double(i);
  return _retval;
}

/**
 * Returns the encoded version of Pango available at run-time.
 * This is similar to the macro %PANGO_VERSION except that the macro
 * returns the encoded version available at compile-time. A version
 * number can be encoded into an integer using PANGO_VERSION_ENCODE$(LPAREN)$(RPAREN).
 * Returns: The encoded version of Pango library available at run time.
 */
int version_()
{
  int _retval;
  _retval = pango_version();
  return _retval;
}

/**
 * Checks that the Pango library in use is compatible with the
 * given version.
 * Generally you would pass in the constants %PANGO_VERSION_MAJOR,
 * %PANGO_VERSION_MINOR, %PANGO_VERSION_MICRO as the three arguments
 * to this function; that produces a check that the library in use at
 * run-time is compatible with the version of Pango the application or
 * module was compiled against.
 * Compatibility is defined by two things: first the version
 * of the running library is newer than the version
 * required_major.required_minor.required_micro. Second
 * the running library must be binary compatible with the
 * version required_major.required_minor.required_micro
 * $(LPAREN)same major version.$(RPAREN)
 * For compile-time version checking use PANGO_VERSION_CHECK$(LPAREN)$(RPAREN).
 * Params:
 *   requiredMajor = the required major version
 *   requiredMinor = the required minor version
 *   requiredMicro = the required major version
 * Returns: %NULL if the Pango library is compatible
 *   with the given version, or a string describing the version
 *   mismatch.  The returned string is owned by Pango and should not
 *   be modified or freed.
 */
string versionCheck(int requiredMajor, int requiredMinor, int requiredMicro)
{
  const(char)* _cretval;
  _cretval = pango_version_check(requiredMajor, requiredMinor, requiredMicro);
  string _retval = _cretval.fromCString(No.Free);
  return _retval;
}

/**
 * Returns the version of Pango available at run-time.
 * This is similar to the macro %PANGO_VERSION_STRING except that the
 * macro returns the version available at compile-time.
 * Returns: A string containing the version of Pango library available
 *   at run time. The returned string is owned by Pango and should not
 *   be modified or freed.
 */
string versionString()
{
  const(char)* _cretval;
  _cretval = pango_version_string();
  string _retval = _cretval.fromCString(No.Free);
  return _retval;
}
