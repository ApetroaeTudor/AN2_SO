CC = gcc
CFLAGS = -Wall -Wextra
SRC1 = main.c
SRC2 = producer.c
SRC3 = consumer.c


OBJ1 = $(SRC1:.c=.o)
OBJ2 = $(SRC2:.c=.o)
OBJ3 = $(SRC3:.c=.o)
OBJ4 = hdr.o

TARGET1 = $(basename $(SRC1))
TARGET2 = $(basename $(SRC2))
TARGET3 = $(basename $(SRC3))

all: $(TARGET1) $(TARGET2) $(TARGET3)

$(TARGET1) : $(OBJ1) $(OBJ4)
	$(CC) $(CFLAGS) $(OBJ1) $(OBJ4) -o $(TARGET1)

$(TARGET2) : $(OBJ2) $(OBJ4)
	$(CC) $(CFLAGS) $(OBJ2) $(OBJ4) -o $(TARGET2)

$(TARGET3) : $(OBJ3) $(OBJ4)
	$(CC) $(CFLAGS) $(OBJ3) $(OBJ4) -o $(TARGET3)


$(OBJ1) : $(SRC1)
	$(CC) $(CFLAGS) -c $(SRC1) -o $(OBJ1)

$(OBJ2) : $(SRC2)
	$(CC) $(CFLAGS) -c $(SRC2) -o $(OBJ2)

$(OBJ3) : $(SRC3)
	$(CC) $(CFLAGS) -c $(SRC3) -o $(OBJ3)


.PHONY: clean
clean:
	rm -f $(OBJ1) $(OBJ2) $(OBJ3) $(TARGET1) $(TARGET2) $(TARGET3)
	
