#include "err.h"
#include <signal.h>

void print_exit(int status)
{
  if(WIFEXITED(status))
  {
    printf("Terminare normala, stare de exit=%d\n",WEXITSTATUS(status));
  }
  else if(WIFSIGNALED(status))
  {

    printf("Terminare anormala, numar de semnal=%d=%s%s\n",WTERMSIG(status),
                                                          strsignal(WSTOPSIG(status)),
                                                          #ifdef WCOREDUMP
                                                          WCOREDUMP(status)?"(generat fisierul core: )":""
                                                          #else
                                                            ""
                                                          #endif
                                                            );
  }
    else if(WIFSTOPPED(status))
    {
      printf("Proces fiu oprit, numar semnal= %d%s\n",WSTOPSIG(status), strsignal(status));

    }
  }


