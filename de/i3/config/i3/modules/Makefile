CC = gcc

LIB_ALSA = `pkg-config --libs alsa`

PROGRAMS = battery brightness date network time user volume progger

all: $(PROGRAMS)

battery: src/battery.c
	$(CC) src/battery.c -o battery

brightness: src/brightness.c
	$(CC) src/brightness.c -lm -o brightness

date: src/date.c
	$(CC) src/date.c -o date

network: src/network.c
	$(CC) src/network.c -o network

time: src/time.c
	$(CC) src/time.c -o time

user: src/user.c
	$(CC) src/user.c -o user

volume: src/volume.c
	$(CC) src/volume.c $(LIB_ALSA) -o volume

progger: src/progger.c
	$(CC) src/progger.c -o progger

clean:
	rm -f battery brightness date network time user volume progger
