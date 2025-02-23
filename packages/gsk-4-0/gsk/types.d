module gsk.types;

import gid.gid;
import glib.error;
import graphene.point;
import gsk.c.functions;
import gsk.c.types;
import gsk.types;


// Enums
alias BlendMode = GskBlendMode;
alias Corner = GskCorner;
alias FillRule = GskFillRule;
alias GLUniformType = GskGLUniformType;
alias LineCap = GskLineCap;
alias LineJoin = GskLineJoin;
alias MaskMode = GskMaskMode;
alias PathDirection = GskPathDirection;
alias PathForeachFlags = GskPathForeachFlags;
alias PathOperation = GskPathOperation;
alias RenderNodeType = GskRenderNodeType;
alias ScalingFilter = GskScalingFilter;
alias SerializationError = GskSerializationError;
alias TransformCategory = GskTransformCategory;

// Structs
alias ParseLocation = GskParseLocation;

// Callbacks
alias ParseErrorFunc = void delegate(ParseLocation start, ParseLocation end, ErrorG error);
alias PathForeachFunc = bool delegate(PathOperation op, Point pts, size_t nPts, float weight);
