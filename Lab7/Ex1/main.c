#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h>
#include <fcntl.h>

#define LOCKDIR "/tmp/"
#define MAXINCERC 3
#define WAITTIME 3

static char* lockpath(char* name)
{
    static char path[256]; 
    snprintf(path, sizeof(path), "%s%s.lock", LOCKDIR, name);
    return path;
}


void unlock(char* name)
{
    if (unlink(lockpath(name)) < 0)
    {
        perror("unlock error");
    }
}

bool lock(char* name)
{
    char* path;
    int fd, incerc = 0;
    path = lockpath(name);
    while ((fd = creat(path,0))<0 && errno==EACCES)
    {
        if (++incerc >= MAXINCERC)
        {
            return false;
        }
        sleep(WAITTIME);
    }

    if (fd < 0)
    {
        perror("lock error");
        return false;
    }

    printf("Current process, with PID:%d, owns the resource\n", getpid());
    close(fd);
    return true;
}



int main(int argc, char* argv[])
{
    pid_t arr[5];
    int i;
    char myWord[16] = "ResursaCritica";

    for (i = 0; i < 5; i++)
    {
        arr[i] = fork();
    }

    for (i = 0; i < 5; i++)
    {
        if (arr[i] == 0)
        {
            if (!lock(myWord))
            {
                printf("Child process %d failed to acquire the lock\n", getpid());
                exit(1);
            }
            else
            {//regiune critica
                printf("hello din regiunea critica!!!");
                unlock(myWord);
            //sfarsit regiune critica
                exit(0);
            }
        }
        else if (arr[i] < 0)
        {
            perror("Fork failed!");
            exit(1);
        }
    }

    for (i = 0; i < 5; i++)
    {
        if (arr[i] != 0)
            waitpid(arr[i], 0, 0);
    }

    return 0;
}
