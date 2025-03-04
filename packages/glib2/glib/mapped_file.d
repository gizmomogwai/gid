module glib.mapped_file;

import gid.global;
import glib.bytes;
import glib.c.functions;
import glib.c.types;
import glib.error;
import glib.types;
import gobject.boxed;

/**
 * The #GMappedFile represents a file mapping created with
 * [glib.mapped_file.MappedFile.new_]. It has only private members and should
 * not be accessed directly.
 */
class MappedFile : Boxed
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
    return cast(void function())g_mapped_file_get_type != &gidSymbolNotFound ? g_mapped_file_get_type() : cast(GType)0;
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Maps a file into memory. On UNIX, this is using the mmap$(LPAREN)$(RPAREN) function.
   * If writable is %TRUE, the mapped buffer may be modified, otherwise
   * it is an error to modify the mapped buffer. Modifications to the buffer
   * are not visible to other processes mapping the same file, and are not
   * written back to the file.
   * Note that modifications of the underlying file might affect the contents
   * of the #GMappedFile. Therefore, mapping should only be used if the file
   * will not be modified, or if all modifications of the file are done
   * atomically $(LPAREN)e.g. using [glib.global.fileSetContents]$(RPAREN).
   * If filename is the name of an empty, regular file, the function
   * will successfully return an empty #GMappedFile. In other cases of
   * size 0 $(LPAREN)e.g. device files such as /dev/null$(RPAREN), error will be set
   * to the #GFileError value %G_FILE_ERROR_INVAL.
   * Params:
   *   filename = The path of the file to load, in the GLib
   *     filename encoding
   *   writable = whether the mapping should be writable
   * Returns: a newly allocated #GMappedFile which must be unref'd
   *   with [glib.mapped_file.MappedFile.unref], or %NULL if the mapping failed.
   */
  this(string filename, bool writable)
  {
    GMappedFile* _cretval;
    const(char)* _filename = filename.toCString(No.Alloc);
    GError *_err;
    _cretval = g_mapped_file_new(_filename, writable, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, Yes.Take);
  }

  /**
   * Maps a file into memory. On UNIX, this is using the mmap$(LPAREN)$(RPAREN) function.
   * If writable is %TRUE, the mapped buffer may be modified, otherwise
   * it is an error to modify the mapped buffer. Modifications to the buffer
   * are not visible to other processes mapping the same file, and are not
   * written back to the file.
   * Note that modifications of the underlying file might affect the contents
   * of the #GMappedFile. Therefore, mapping should only be used if the file
   * will not be modified, or if all modifications of the file are done
   * atomically $(LPAREN)e.g. using [glib.global.fileSetContents]$(RPAREN).
   * Params:
   *   fd = The file descriptor of the file to load
   *   writable = whether the mapping should be writable
   * Returns: a newly allocated #GMappedFile which must be unref'd
   *   with [glib.mapped_file.MappedFile.unref], or %NULL if the mapping failed.
   */
  static MappedFile newFromFd(int fd, bool writable)
  {
    GMappedFile* _cretval;
    GError *_err;
    _cretval = g_mapped_file_new_from_fd(fd, writable, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new MappedFile(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Creates a new #GBytes which references the data mapped from file.
   * The mapped contents of the file must not be modified after creating this
   * bytes object, because a #GBytes should be immutable.
   * Returns: A newly allocated #GBytes referencing data
   *   from file
   */
  Bytes getBytes()
  {
    GBytes* _cretval;
    _cretval = g_mapped_file_get_bytes(cast(GMappedFile*)cPtr);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, Yes.Take) : null;
    return _retval;
  }

  /**
   * Returns the contents of a #GMappedFile.
   * Note that the contents may not be zero-terminated,
   * even if the #GMappedFile is backed by a text file.
   * If the file is empty then %NULL is returned.
   * Returns: the contents of file, or %NULL.
   */
  string getContents()
  {
    char* _cretval;
    _cretval = g_mapped_file_get_contents(cast(GMappedFile*)cPtr);
    string _retval = _cretval.fromCString(Yes.Free);
    return _retval;
  }

  /**
   * Returns the length of the contents of a #GMappedFile.
   * Returns: the length of the contents of file.
   */
  size_t getLength()
  {
    size_t _retval;
    _retval = g_mapped_file_get_length(cast(GMappedFile*)cPtr);
    return _retval;
  }
}
