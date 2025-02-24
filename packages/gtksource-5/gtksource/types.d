module gtksource.types;

import gid.gid;
import gtksource.c.functions;
import gtksource.c.types;
import gtksource.types;


// Enums
alias BackgroundPatternType = GtkSourceBackgroundPatternType;
alias BracketMatchType = GtkSourceBracketMatchType;
alias ChangeCaseType = GtkSourceChangeCaseType;
alias CompletionActivation = GtkSourceCompletionActivation;
alias CompletionColumn = GtkSourceCompletionColumn;
alias CompressionType = GtkSourceCompressionType;
alias FileLoaderError = GtkSourceFileLoaderError;
alias FileSaverError = GtkSourceFileSaverError;
alias FileSaverFlags = GtkSourceFileSaverFlags;
alias GutterRendererAlignmentMode = GtkSourceGutterRendererAlignmentMode;
alias NewlineType = GtkSourceNewlineType;
alias SmartHomeEndType = GtkSourceSmartHomeEndType;
alias SortFlags = GtkSourceSortFlags;
alias SpaceLocationFlags = GtkSourceSpaceLocationFlags;
alias SpaceTypeFlags = GtkSourceSpaceTypeFlags;
alias ViewGutterPosition = GtkSourceViewGutterPosition;

// Callbacks
alias SchedulerCallback = bool delegate(long deadline);

/**
 * Like [GtkSource.Global.getMajorVersion], but from the headers used at
 * application compile time, rather than from the library linked
 * against at application run time.
 */
enum MAJOR_VERSION = 5;


/**
 * Like [GtkSource.Global.getMicroVersion], but from the headers used at
 * application compile time, rather than from the library linked
 * against at application run time.
 */
enum MICRO_VERSION = 1;


/**
 * Like [GtkSource.Global.getMinorVersion], but from the headers used at
 * application compile time, rather than from the library linked
 * against at application run time.
 */
enum MINOR_VERSION = 12;

