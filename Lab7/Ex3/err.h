#ifndef _ERR_H
#define _ERR_H

#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>

void print_exit(int status);

#endif
