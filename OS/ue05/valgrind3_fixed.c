#include <stdio.h>
#include <stdlib.h>
int main(int argc, char **argv) {
  char *p = (char *) malloc(2);
  p[1] = 'a';
  char c = *(p + 1);
  printf("\n [%c]\n", c);
  free(p);
  return 0;
}
