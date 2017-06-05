CC=gcc
CFLAGS  = -g -Wall

SRCS=main.cpp add.cpp
OBJS=$(subst .cc,.o,$(SRCS))

main: $(OBJS)

%.o: %.c 
	    $(CC) $(CFLAGS) $(CPPFLAGS) -c $<
