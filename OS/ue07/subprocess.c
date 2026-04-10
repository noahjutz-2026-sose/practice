#include <stdio.h>
#include <ctype.h>

void strToUpper(char *sPtr) {
  while (*sPtr != '\0') {
    *sPtr = toupper((unsigned char)*sPtr);
    sPtr++;
  }
}

int main() {
    char str[] = "Hello World";
    printf("%s\n", str);
    strToUpper(str);
    printf("%s\n", str);
}
