#ifndef MAIN_H
#define MAIN_H

#define KEY_MAY_CONSUME 0x1
#define KEY_MAY_PRODUCE 0x2
#define CAPACITY 5

struct datamsg{
	long mtype;
	char mtext[3];
};

struct nullmsg{
	long mtype;
	char mtext;
};




#endif
