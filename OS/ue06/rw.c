#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <unistd.h>

struct shared_data {
  pthread_mutex_t mutex;
  pthread_cond_t condition;
  int value;
};

int main() {
  pid_t pid;             /* variable to record process id of child */
  int i_parent, i_child; /* index variables */

  struct shared_data *sd;
  sd = mmap(0, sizeof(struct shared_data), PROT_READ | PROT_WRITE,
            MAP_ANONYMOUS | MAP_SHARED, -1, 0);

  pthread_mutexattr_t mattr;
  pthread_mutexattr_init(&mattr);
  pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_SHARED);

  pthread_mutex_init(&(sd->mutex), &mattr);

  pthread_condattr_t cattr;
  pthread_condattr_init(&cattr);
  pthread_condattr_setpshared(&cattr, PTHREAD_PROCESS_SHARED);

  pthread_cond_init(&(sd->condition), &cattr);

  sd->value = -1;

  // if (sd == (char *)-1) {
  //   fprintf(stderr, "%s\n", strerror(errno));
  //   return errno;
  // }

  if ((pid = fork()) < 0) { /* apply fork and check for error */
    fprintf(stderr, "%s\n", strerror(errno));
    return errno;
  }

  if (pid == 0) {
    printf("The child process begins.\n");
    for (i_child = 0; i_child < 10; i_child++) {
      pthread_mutex_lock(&sd->mutex);
      while (sd->value == -1)
        pthread_cond_wait(&sd->condition, &sd->mutex);
      int value = sd->value;
      sd->value = -1;
      printf("Child’s report: current value = %2d\n", value);
      pthread_cond_signal(&sd->condition);
      pthread_mutex_unlock(&sd->mutex);
    }
    printf("The child is done\n");
  } else {
    int childExitStatus;
    printf("The parent process begins.\n");
    for (i_parent = 0; i_parent < 10; i_parent++) {
      pthread_mutex_lock(&sd->mutex);
      printf("Parent’s report: current index = %2d\n", i_parent);
      while (sd->value != -1)
        pthread_cond_wait(&sd->condition, &sd->mutex);
      sd->value = i_parent * i_parent;
      pthread_cond_signal(&sd->condition);
      pthread_mutex_unlock(&sd->mutex);
    }
    wait(&childExitStatus);
    printf("The parent is done\n");
  }
  return 0;
}
