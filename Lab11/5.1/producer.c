//producerul trb intai sa incerce sa dea msgrcv din MAYPRODUCE QUEUE
//daca trece de acel msgrcv atunci produce un mesaj si ii da msgsnd in MAYCONSUMEQUEUE


#include "main.h"
#include "hdr.h"
#include <sys/msg.h>
#include <sys/ipc.h>
#include <sys/types.h>

int main(void)
{
	int mayProduceQueueID;
	int mayConsumeQueueID;
	struct nullmsg myNullMsg;
	struct datamsg myDataMsg;
	int index = 0;

	if( (mayProduceQueueID = msgget( (key_t)KEY_MAY_PRODUCE, 0666 )) < 0 )
	{
		err_sys("Eroare in deschiderea cozii de may produce in producer.\n");
	}	

	if( ( mayConsumeQueueID = msgget( (key_t)KEY_MAY_CONSUME,0666)) < 0 )
	{
		err_sys("Eroare in producer la deschiderea cozii de may consume.\n");
	}

	for ever
	{

		if( msgrcv(mayProduceQueueID,(struct msgbuf*)&myNullMsg,sizeof(myNullMsg) - sizeof(long),1,0) <0 )
		{
			err_sys("Eroare la receiving msg din MayProduceQueue.\n");
		}
		printf("Producer: received token: now producing..\n");
		//acum se produce un mesaj si se pune in may consume queue
		index++;

		myDataMsg.mtype = 1;
		char buffer[3]; buffer[0] = '0'; buffer[1] = '0'; buffer[2] = '0';
		sprintf(buffer,"%d",index);
		myDataMsg.mtext[0] = buffer[0];
		myDataMsg.mtext[1] = buffer[1];
		myDataMsg.mtext[2] = buffer[2];

		if(( msgsnd(mayConsumeQueueID,(struct msgbuf*)&myDataMsg,sizeof(myDataMsg)-sizeof(long),0 )) <0 )
		{
			err_sys("Error sending msg in producer.\n");
		}	
		if(index == 10)
		{
			break;
		}
	}

	myDataMsg.mtype = 2;
	myDataMsg.mtext[0] = 'd';
	myDataMsg.mtext[1] = '\n';

	if( (msgsnd(mayConsumeQueueID,(struct msgbuf*)&myDataMsg,sizeof(myDataMsg)-sizeof(long),0)) <0  )
	{
		err_sys("Eroare la trimitere de mesaj.\n");
	}

	return 0;
}
