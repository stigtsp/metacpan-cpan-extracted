/* This is a program that 'test.syms' test-compiles to determine if a function
   has an integer return value.

   'test.syms' defines macro SYM on the compile command.
*/

#define _XOPEN_SOURCE_EXTENDED 1  /* We expect wide character functions */

#include "c-config.h"

main() {
  int ret;

  ret = SYM;
}
