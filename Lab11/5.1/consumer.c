//consumer-ul trb sa deschida coada de can consume
//daca reuseste sa faca msgrcv atunci deschide coada de can produce si scrie un msg nul;
//daca intalneste mesajul de tip 2 atunci se termina procesul de consume si se inchid toate cozile

#include "main.h"
#include <sys/msg.h>
#include <sys/types.h>
#include <sys/types.h>
#include "hdr.h"
#include <errno.h>


static void closeQueue(int qID)
{
	if( msgctl(qID,IPC_RMID,NULL) <0 )
	{
		if(errno == EINVAL)
		{
			fprintf(stderr,"Coada inexistenta\n");
		}
		else if(errno == EIDRM)
		{
			fprintf(stderr,"Coada deja inchisa\n");
		}
		else{
			fprintf(stderr,"Eroare necunoscuta, se inchide programul\n");
			exit(-1);
		}
	}
}



int main(void)
{
	int mayProduceQueueID;
	int mayConsumeQueueID;
	struct datamsg myDataMsg;
	struct nullmsg myNullMsg;

	myNullMsg.mtype = 1;
	myNullMsg.mtext = '\0';

	if( (mayConsumeQueueID = msgget( (key_t)KEY_MAY_CONSUME,0666)) < 0 )
	{
		err_sys("Eroare la deschiderea cozii de may consume in consumer.\n");
	}

	if( (mayProduceQueueID = msgget( (key_t)KEY_MAY_PRODUCE,0666 )  ) < 0 )

	{
		err_sys("Eroare la deschiderea cozii de may produce in consumer..\n");
	}


	for ever
	{

		if( ( msgrcv(mayConsumeQueueID,(struct msgbuf* )&myDataMsg,sizeof(myDataMsg) - sizeof(long),-2,0 )) < 0 )
		{
			err_sys("Eroare la citire din coada de may consume in consumer\n");
		}

		if(myDataMsg.mtype == 1)
		{
			printf("S-a preluat un element din coada de may consume..\n");

		}
		else
		{
			printf("S-a receptionat mesajul de final de scriere emis de producer..\n");
			break;
		}


		if( (msgsnd(mayProduceQueueID,(struct msgbuf*)&myNullMsg,sizeof(myNullMsg) - sizeof(long),0 ) ) <0)
		{
			err_sys("Eroare la scriere mesaj in may produce queue in consumer..\n");
		}	




	}

	closeQueue(mayProduceQueueID);
	closeQueue(mayConsumeQueueID);



	return 0;
}
