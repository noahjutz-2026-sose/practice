#include <pthread.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <sys/mman.h>
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

        read(req[0], buffer, 50);
        strToUpper(buffer);
        write(res[1], buffer, 50);
    } else {
        close(req[0]);
        close(res[1]);

        write(req[1], "Hi there", 9);
        read(res[0], buffer, 50);
        printf("%s\n", buffer);
    }
}
