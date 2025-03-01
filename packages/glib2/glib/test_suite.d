module glib.test_suite;

import gid.global;
import glib.c.functions;
import glib.c.types;
import glib.types;

/**
 * An opaque structure representing a test suite.
 */
class TestSuite
{
  GTestSuite* cInstancePtr;
  bool owned;

  this(void* ptr, Flag!"Take" take = No.Take)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TestSuite");

    cInstancePtr = cast(GTestSuite*)ptr;

    owned = take;
  }

  ~this()
  {
    if (owned)
      g_test_suite_free(cInstancePtr);
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Adds test_case to suite.
   * Params:
   *   testCase = a #GTestCase
   */
  void add(TestCase testCase)
  {
    g_test_suite_add(cast(GTestSuite*)cPtr, testCase);
  }

  /**
   * Adds nestedsuite to suite.
   * Params:
   *   nestedsuite = another #GTestSuite
   */
  void addSuite(TestSuite nestedsuite)
  {
    g_test_suite_add_suite(cast(GTestSuite*)cPtr, nestedsuite ? cast(GTestSuite*)nestedsuite.cPtr : null);
  }
}
