CC = gcc
CFLAGS = -Wall -g

TARGET = my_program
LIB_NAME = libtester.a

all: $(TARGET)

$(TARGET): main.o $(LIB_NAME)
	$(CC) $(CFLAGS) -o $(TARGET) main.o -L. -ltester

$(LIB_NAME): tester.o
	$(AR) $(ARFLAGS) $(LIB_NAME) tester.o

main.o: main.c tester.h
	$(CC) $(CFLAGS) -c main.c

tester.o: tester.c tester.h
	$(CC) $(CFLAGS) -c tester.c

clean:
	rm -f *.o *.a $(TARGET)
