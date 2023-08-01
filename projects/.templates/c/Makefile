.PHONY: clean, mrproper
CC = gcc
CFLAGS = -g -Wall

all: app

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

app: app.o
	$(CC) $(CFLAGS) -o $@ $+

clean:
	rm -f *.o core.*

mrproper: clean
	rm -f app
