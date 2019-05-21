CFLAGS = -O
CC = g++

main: client server
	

client: client.c
	$(CC) $(CFLAGS) client.c -o client

server: main.cpp server.cpp server.h
	$(CC) $(CLFAGS) main.cpp server.cpp -o server

clean:
	rm client server server.txt
