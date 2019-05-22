CFLAGS = -Wall -Werror -g
CC = g++

main: client server
	

client: client.c
	$(CC) $(CFLAGS) client.c -o client

server: main.cpp server.cpp server.h
	$(CC) $(CFLAGS) main.cpp server.cpp -o server

clean:
	rm -f client server
