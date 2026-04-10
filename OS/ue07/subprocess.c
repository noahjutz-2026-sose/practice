#include <ctype.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <unistd.h>

void strToUpper(char *sPtr) {
  while (*sPtr != '\0') {
    *sPtr = toupper((unsigned char)*sPtr);
    sPtr++;
  }
}

int main() {
  char buffer[50];

  int req[2], res[2];
  pipe(req);
  pipe(res);

  int pid = fork();

  if (pid < 0) {
    exit(1);
  }

  if (pid == 0) {
    close(req[1]);
    close(res[0]);

    while (read(req[0], buffer, 50) > 0) {
        strToUpper(buffer);
        write(res[1], buffer, 50);
    }
  } else {
    close(req[0]);
    close(res[1]);

    FILE *file = fopen("input.txt", "r");

    while (fgets(buffer, sizeof(buffer), file) != NULL) {
      write(req[1], buffer, strlen(buffer) + 1);
    }

    fclose(file);
    close(req[1]);

    while (read(res[0], buffer, 50) > 0) {
        printf("%s\n", buffer);
    }

    close(res[0]);
    wait(NULL);
  }
}
