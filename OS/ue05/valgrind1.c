#include <stdlib.h>
#include <string.h>
int main(int argc, char **argv) {
  char *cp;
  cp = (char *)malloc(50);
  cp = "ohohoh";
  free(cp);
  return 0;
}
