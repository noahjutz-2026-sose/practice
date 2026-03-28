CC = gcc
CFLAGS = -Wall -g

TARGET = my_program

all: $(TARGET)

$(TARGET): main.o tester.o
	$(CC) $(CFLAGS) -o $(TARGET) main.o tester.o

main.o: main.c tester.h
	$(CC) $(CFLAGS) -c main.c

tester.o: tester.c tester.h
	$(CC) $(CFLAGS) -c tester.c

clean:
	rm -f *.o $(TARGET)
