CXXFLAGS  = -g -Wall -Werror -I. -std=c++11

# all: create use
all: create use

create: use-shared-memory-1.c
	$(CXX) $(CXXFLAGS) use-shared-memory-1.c -o create -lrt

use: use-shared-memory-2.c
	$(CXX) $(CXXFLAGS) use-shared-memory-2.c -o use -lrt

clean:
	rm -f create use
