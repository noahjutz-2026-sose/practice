#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  char *p = malloc(1);
  *p = 'a';
  char c = *p;
  printf("\n [%c]\n", c);
  free(p);
  return 0;
}

// export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
// valgrind ./a.out
