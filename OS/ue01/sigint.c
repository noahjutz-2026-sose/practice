#include <signal.h>
#include <stdio.h>

void handler(int sig) {
    printf("C-c\n");
}

int main() {
    signal(SIGINT, handler);
    while (1) {}
}
