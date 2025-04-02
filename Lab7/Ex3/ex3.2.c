#include "err.h"

int main(void){
  pid_t relParent_pid=fork();

  pid_t root_pid=getpid();

  if(relParent_pid==0){ //parintele pentru cele 4 procese ce urmeaza
    int nrOfChildren=4;
    int i;
    pid_t childArr[4];
    char isParent='t';

    for(i=0;i<nrOfChildren;++i){
    
      childArr[i]=fork(); //array ce tine pidurile copiilor
      if(childArr[i]==0){
        isParent='f';
      }
      if(isParent=='f'){
        break; //daca e un copil trebuie sa il intrerup din a da fork si el in continuare
      }
    
    }

    if(isParent=='t'){
      printf("[%d] Proces Parinte -- Procese fii: [%d][%d][%d][%d]\n",getpid(),
                                                                      childArr[0],
                                                                      childArr[1],
                                                                      childArr[2],
                                                                      childArr[3]);
    }
    if(isParent=='t'){
      for(i=0;i<nrOfChildren;++i){
        waitpid(childArr[i],0,0);
      }
      exit(0);
    }

    
    for(i=0;i<nrOfChildren;++i){
      if(childArr[i]==0){ //copil al parintelui creat
        printf("[%d] Proces fiu -- Cu Proces parinte [%d]\n",getpid(),getppid());
        exit(0);
      }
      else if (childArr[i]<0){
        perror("Fork failed from parent!");
        exit(1);
      }
    }

  }
  else if(relParent_pid>0){ //parintele mare -- bunicul
    waitpid(relParent_pid,0,0);
  }
  else{
    perror("Fork failed");
    exit(1);
  }

return 0;

}
