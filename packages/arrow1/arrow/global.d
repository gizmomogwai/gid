module Arrow.global;

import arrow.c.functions;
import arrow.c.types;
import arrow.s3_global_options;
import arrow.types;
import gid.global;
import glib.error;


/**
 * Finalize the S3 APIs.
 * Returns: %TRUE on success, %FALSE on error.
 */
bool s3Finalize()
{
  bool _retval;
  GError *_err;
  _retval = garrow_s3_finalize(&_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * Normally, you don't need to call this function because the S3 APIs
 * are initialized with the default options automatically. If you want
 * to call this function, you must call this function before you use
 * any #GArrowS3FileSystem related APIs.
 * Params:
 *   options = Options to initialize the S3 APIs.
 * Returns: %TRUE on success, %FALSE on error.
 */
bool s3Initialize(S3GlobalOptions options)
{
  bool _retval;
  GError *_err;
  _retval = garrow_s3_initialize(options ? cast(GArrowS3GlobalOptions*)options.cPtr(No.Dup) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

bool s3IsEnabled()
{
  bool _retval;
  _retval = garrow_s3_is_enabled();
  return _retval;
}
