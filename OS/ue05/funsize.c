#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <syslog.h>

const int ret = 0xc3;

void fun() {
  return;
}

size_t size(void (*f)()) {
  int size = 0;
  while (memcmp(f+size, &ret, 1) != 0)
    size++;
  return size + 1;
}

void bytecode(void (*f)(), unsigned char bytes[]) {
  int i = 0;
  while (memcmp(f+i, &ret, 1) != 0) {
    bytes[i] = ((unsigned char *) f)[i];
    i++;
  }
  bytes[i] = ret;
}

void exec(const unsigned char bytes[], size_t size) {
  void *map = mmap(NULL, size, PROT_EXEC | PROT_WRITE | PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
  memcpy(map, bytes, size);
  mprotect(map, size, PROT_READ | PROT_EXEC);
  ((void (*)()) map)();
  munmap(map, size);
}

int main() {
  unsigned char bytes[size(fun)];
  bytecode(fun, bytes);
  for (int i = 0; i < size(fun); i++) {
    printf("%x ", bytes[i]);
  }
  exec(bytes, size(fun));
}
